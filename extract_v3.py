import json
import glob
import os
import re
from bs4 import BeautifulSoup

out_json = r'C:\Users\mathi\Downloads\MuscuLog_Migration.json'
files = glob.glob(r'C:\Users\mathi\Downloads\Entries\*.html')

workouts = []

def decode_insane_apple_text(text):
    # Enlève la pollution Apple invisible et les tirets de liste
    text = text.replace('Ǹ', '').replace('', '').replace('%', 'E').replace('ǽ', 'a')
    
    clean = ''
    for char in text:
        # Garde seulement l'alphabet de base et les parenthèses
        if char.isalpha() or char.isspace() or char in ['(', ')', 'é', 'è', 'à', 'ê', 'â']:
            clean += char
            
    clean = clean.strip()
    
    # Nettoie les numéros qui seraient restés devant genre "1. " s'ils ne sont pas des alpha
    # Vu qu'on a viré les chiffres, ils ont disparu, donc on fait juste un capitalize
    return clean.capitalize()

for f in files:
    with open(f, 'rb') as file:
        content = file.read().decode('utf-8', errors='ignore')
        if 'Salle' not in content:
            continue
            
        soup = BeautifulSoup(content, 'html.parser')
        title_div = soup.find('div', class_='title')
        date_str = title_div.get_text(strip=True) if title_div else os.path.basename(f)
        
        parts = date_str.split('/')
        if len(parts) == 3:
            iso_date = f'20{parts[2]}-{parts[1]}-{parts[0]}T08:00:00Z'
        else:
            iso_date = '2026-01-01T08:00:00Z'
            
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
                
                # Cherche les listes en dessous ou les paragraphes
                # Si c'est juste un paragraphe "Abdominal machine en bas - 3x10 10x41..." (Lower du 04/10/26)
                # Il faut lire les paragraphes suivants s'il n'y a pas de liste.
                lines_to_process = []
                
                ol = p.find_next_sibling('ol')
                if ol:
                    for li in ol.find_all('li'):
                        lines_to_process.append(li.get_text(separator=' ', strip=True))
                else:
                    # Lire les <p> jusqu'à un marqueur de temps "XXh" ou "Douche"
                    curr_p = p.find_next_sibling('p')
                    while curr_p:
                        ptxt = curr_p.get_text(separator=' ', strip=True)
                        if 'Douche' in ptxt or re.match(r'\d{1,2}h', ptxt):
                            break
                        if ptxt:
                            lines_to_process.append(ptxt)
                        curr_p = curr_p.find_next_sibling('p')
                        
                ex_idx = 0
                for li_text in lines_to_process:
                    # On sépare le nom des séries par le premier tiret ou "?"
                    parts = re.split(r'\?\"|-|–|—', li_text, maxsplit=1)
                    if len(parts) > 1:
                        ex_name = decode_insane_apple_text(parts[0])
                        set_text = parts[1]
                    else:
                        match = re.search(r'\d+x\d+', li_text)
                        if match:
                            ex_name = decode_insane_apple_text(li_text[:match.start()])
                            set_text = li_text[match.start():]
                        else:
                            ex_name = decode_insane_apple_text(li_text)
                            set_text = ''
                            
                    set_text = re.sub(r'\d+x\d+-\d+', '', set_text)
                    set_text = re.sub(r'\d+-\d+-\d+', '', set_text)
                    set_text = set_text.replace(',', '.')
                    
                    sets = []
                    set_chunks = re.split(r'\s+', set_text)
                    s_idx = 1
                    for chunk in set_chunks:
                        sub_matches = re.findall(r'([\d\.\+]+)x([\d\.\+]+)', chunk)
                        for m in sub_matches:
                            try:
                                left_val = sum(float(v) for v in m[0].split('+') if v)
                                right_val = sum(float(v) for v in m[1].split('+') if v)
                                
                                if left_val > right_val and left_val >= 15:
                                    w, r = left_val, right_val
                                elif right_val > left_val and right_val >= 15:
                                    w, r = right_val, left_val
                                else:
                                    w, r = right_val, left_val
                                    
                                sets.append({'weight': float(w), 'reps': int(r), 'setNumber': s_idx})
                                s_idx += 1
                            except:
                                continue
                                
                    if len(sets) > 0 and ex_name != '':
                        current_workout['exercises'].append({
                            'exerciseName': ex_name.strip(),
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
print(f'Généré {len(workouts)} séances parfaitement nettoyées.')
