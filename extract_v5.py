import json
import glob
import re
from bs4 import BeautifulSoup

out_json = r'C:\Users\mathi\Downloads\MuscuLog_Import_Final.json'
files = glob.glob(r'C:\Users\mathi\Downloads\Entries\*.html')
workouts = []

def get_exercise_name(text):
    text = re.sub(r'^\d+[\.\)]\s*', '', text)
    m = re.search(r'[-–—]|(\d+\s*[xX×])', text)
    if m:
        name = text[:m.start()].strip()
        if len(name) > 2: return name
    m2 = re.match(r'^([a-zA-ZÀ-ÿ\s\(\)]+[a-zA-ZÀ-ÿ\)])', text)
    if m2:
        name = m2.group(1).strip()
        if len(name) > 2: return name
    return ''

def extract_sets(line):
    line = re.sub(r'[-–—]\s*\d+\s*[xX×]\s*[\d-]+', '', line)
    if 'x' not in line.lower(): return []
    
    chunks = re.split(r', (?=\d)', line)
    res = []
    
    for c in chunks:
        if c.lower().count('x') > 1:
            subchunks = c.split('+')
        else:
            subchunks = [c]
            
        for sc in subchunks:
            sc = sc.replace(',', '.')
            match = re.search(r'([\d\.\+]+)\s*[xX×]\s*([\d\.\+]+)', sc)
            if match:
                left, right = match.groups()
                try:
                    left_val = sum(float(x) for x in left.split('+') if x)
                    right_val = sum(float(x) for x in right.split('+') if x)
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
    with open(f, 'r', encoding='utf-8', errors='ignore') as file:
        content = file.read()
        if 'Salle' not in content: continue
        
        date_match = re.search(r'(\d{2})/(\d{2})/(\d{2,4})', content)
        if date_match:
            d, m, y = date_match.groups()
            if len(y) == 2: y = '20' + y
            iso_date = f'{y}-{m}-{d}T08:00:00Z'
        else:
            iso_date = '2026-01-01T08:00:00Z'
            
        soup = BeautifulSoup(content, 'html.parser')
        lines = soup.get_text(separator='\n', strip=True).split('\n')
        
        workout_name = 'Lower'
        for l in lines:
            if 'Upper' in l: workout_name = 'Upper'; break
            if 'Lower' in l: workout_name = 'Lower'; break
            
        current_workout = {
            'date': iso_date,
            'startedAt': iso_date,
            'finishedAt': iso_date.replace('08:', '09:'),
            'programName': 'Import',
            'workoutName': workout_name,
            'exercises': []
        }
        
        current_ex = None
        started = False
        for line in lines:
            line = line.replace('?', '-').replace('Ǹ', 'é').replace('%', 'É').replace('ǽ', 'â').strip()
            if not line: continue
            if 'Salle' in line and ('Upper' in line or 'Lower' in line):
                started = True
                continue
            if not started: continue
            
            if line.lower() == 'douche' or 'douche' in line.lower() or re.match(r'^\d{1,2}h', line):
                break
                
            name = get_exercise_name(line)
            if name:
                current_ex = {
                    'exerciseName': name.capitalize(),
                    'displayOrder': len(current_workout['exercises']),
                    'sets': []
                }
                current_workout['exercises'].append(current_ex)
                
            sets = extract_sets(line)
            if current_ex and sets:
                for s in sets:
                    s['setNumber'] = len(current_ex['sets']) + 1
                    current_ex['sets'].append(s)
        
        current_workout['exercises'] = [e for e in current_workout['exercises'] if len(e['sets']) > 0]
        if len(current_workout['exercises']) > 0:
            workouts.append(current_workout)
            if iso_date == '2026-10-04T08:00:00Z':
                print(f'--- {workout_name} du {iso_date} ---')
                for ex in current_workout['exercises']:
                    print('  ' + ex['exerciseName'])
                    for s in ex['sets']:
                        print('    Série ' + str(s['setNumber']) + ': ' + str(s['weight']) + ' kg x ' + str(s['reps']) + ' reps')

final_data = {'version': 1, 'exportDate': '2026-10-04T12:00:00Z', 'workouts': workouts}
with open(out_json, 'w', encoding='utf-8') as file_out:
    json.dump(final_data, file_out, indent=2, ensure_ascii=False)
