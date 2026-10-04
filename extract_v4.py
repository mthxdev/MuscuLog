import json
import glob
import os
import re
from bs4 import BeautifulSoup

# Fichiers sources et cible
out_json = r'C:\Users\mathi\Downloads\MuscuLog_Import_Final.json'
files = glob.glob(r'C:\Users\mathi\Downloads\Entries\*.html')

workouts = []

def parse_chunk(chunk):
    chunk = chunk.strip().lower()
    if 'x' not in chunk: return []
    
    sub_matches = re.findall(r'([\d\.\+]+)x([\d\.\+]+)', chunk)
    res = []
    for left, right in sub_matches:
        try:
            left_val = sum(float(x.replace(',', '.')) for x in left.split('+') if x)
            right_val = sum(float(x.replace(',', '.')) for x in right.split('+') if x)
            if left_val > right_val and left_val >= 12:
                w, r = left_val, right_val
            elif right_val > left_val and right_val >= 12:
                w, r = right_val, left_val
            else:
                w, r = right_val, left_val 
            res.append({'weight': round(w, 2), 'reps': int(r)})
        except:
            pass
    return res

for f in files:
    # LECTURE COMME LE V1 ! encoding utf-8 basique, sans aucune altération manuelle.
    with open(f, 'r', encoding='utf-8', errors='ignore') as file:
        content = file.read()
        
        if 'Salle' not in content:
            continue
            
        soup = BeautifulSoup(content, 'html.parser')
        title_div = soup.find('div', class_='title')
        date_str = title_div.get_text(strip=True) if title_div else os.path.basename(f)
        
        parts = date_str.split('/')
        iso_date = f'20{parts[2]}-{parts[1]}-{parts[0]}T08:00:00Z' if len(parts)==3 else '2026-01-01T08:00:00Z'
            
        current_workout = None
        
        for p in soup.find_all('p'):
            text = p.get_text(separator=' ', strip=True)
            if 'Salle' in text and ('Upper' in text or 'Lower' in text):
                name = 'Upper' if 'Upper' in text else 'Lower'
                
                current_workout = {
                    'date': iso_date,
                    'startedAt': iso_date,
                    'finishedAt': iso_date.replace('08:', '09:'),
                    'programName': 'Import',
                    'workoutName': name,
                    'exercises': []
                }
                
                lines_to_process = []
                ol = p.find_next_sibling('ol')
                
                if ol:
                    for li in ol.find_all('li'):
                        lines_to_process.append(li.get_text(separator=' ', strip=True))
                else:
                    curr_p = p.find_next_sibling('p')
                    while curr_p:
                        ptxt = curr_p.get_text(separator=' ', strip=True)
                        if 'Douche' in ptxt or re.match(r'\d{1,2}h', ptxt): break
                        if ptxt: lines_to_process.append(ptxt)
                        curr_p = curr_p.find_next_sibling('p')
                        
                ex_idx = 0
                for li_text in lines_to_process:
                    # Enlève simplement les ? qui apparaissent dans les tirets sans toucher au reste de l'encodage
                    li_text_clean = li_text.replace('?"', '-')
                    parts = re.split(r' - | – | — ', li_text_clean, maxsplit=1)
                    
                    if len(parts) > 1:
                        raw_name = parts[0]
                        set_text = parts[1]
                    else:
                        match = re.search(r'\d+x\d+', li_text_clean)
                        if match:
                            raw_name = li_text_clean[:match.start()]
                            set_text = li_text_clean[match.start():]
                        else:
                            raw_name = li_text_clean
                            set_text = ''
                            
                    # Nettoyage ultra-doux du nom, juste pour virer "1. "
                    ex_name = re.sub(r'^\d+\.\s*', '', raw_name).strip()
                    
                    # Cibles
                    set_text = re.sub(r'\d+x\d+-\d+', '', set_text)
                    set_text = re.sub(r'\d+-\d+-\d+', '', set_text)
                    set_text = set_text.replace(',', '.')
                    
                    sets = []
                    for c in re.split(r'[,\s]+', set_text):
                        sets.extend(parse_chunk(c))
                        
                    if sets and ex_name:
                        current_workout['exercises'].append({
                            'exerciseName': ex_name.capitalize(),
                            'displayOrder': ex_idx,
                            'sets': sets
                        })
                        ex_idx += 1
                        
                if current_workout and len(current_workout['exercises']) > 0:
                    workouts.append(current_workout)
                    current_workout = None

final_data = {'version': 1, 'exportDate': '2026-10-04T12:00:00Z', 'workouts': workouts}
with open(out_json, 'w', encoding='utf-8') as f:
    json.dump(final_data, f, indent=2, ensure_ascii=False)
