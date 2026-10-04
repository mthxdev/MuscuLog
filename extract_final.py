import re
import json

with open(r'C:\Users\mathi\Downloads\workouts_raw.txt', 'r', encoding='utf-8', errors='ignore') as f:
    content = f.read()

# Nettoyage GLOBAL des corruptions de texte Apple
content = content.replace('Ǹ', 'é')
content = content.replace('?"', '-')
content = content.replace('?', '-')
# SUPPRESSION de la pollution Apple invisible sans la remplacer par "é" !
content = content.replace('Ǹ', '')
# Supprimer les char invisibles
content = re.sub(r'[^\x00-\x7F\u00C0-\u017F\s\.,\-\+\(\)\:]', '', content)

content = content.replace('%', 'É')
content = content.replace('ǽ', 'â')

lines = content.split('\n')

workouts = []
current_workout = None

def parse_chunk(chunk):
    chunk = chunk.strip().lower()
    if 'x' not in chunk: return []
    
    # Trouver explicitement chaque groupe "A x B" sans récursivité
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

current_ex_text = ''

for line in lines:
    line = line.strip()
    if not line: continue
    
    if line.startswith('=== SEANCE DATE:'):
        if current_workout:
            # Traiter le dernier exercice
            if current_ex_text:
                name_match = re.match(r'^(?:\d+\.\s*)?(.*?)(?:\s*-|\s*–|\s*\d)', current_ex_text)
                ex_name = name_match.group(1).strip().capitalize() if name_match else 'Exercice'
                text_clean = re.sub(r'\d+x\d+-\d+', '', current_ex_text)
                text_clean = re.sub(r'\d+-\d+-\d+', '', text_clean)
                text_clean = re.sub(r'\d+-\d+', '', text_clean)
                sets = []
                for c in re.split(r'[,\s]+', text_clean): sets.extend(parse_chunk(c))
                if sets: current_workout['exercises'].append({'name': ex_name, 'sets': sets})
            workouts.append(current_workout)
            
        date_str = line.split('DATE: ')[1].strip(' =')
        parts = date_str.split('/')
        iso_date = f'20{parts[2]}-{parts[1]}-{parts[0]}T08:00:00Z' if len(parts)==3 else '2026-01-01T08:00:00Z'
        current_workout = {'date': iso_date, 'name': 'Séance', 'exercises': []}
        current_ex_text = ''
        
    elif line.startswith('TITRE:'):
        current_workout['name'] = 'Upper' if 'Upper' in line else 'Lower'
    elif line in ['S1', 'S2', 'Douche.', 'Douche'] or 'deload' in line.lower() or 'involontairement' in line.lower():
        continue
    else:
        # Check si c'est un nouvel exo
        if re.match(r'^\d+\.', line) or line.lower().startswith('abdo') or line.lower().startswith('crunch'):
            if current_ex_text:
                name_match = re.match(r'^(?:\d+\.\s*)?(.*?)(?:\s*-|\s*–|\s*\d)', current_ex_text)
                ex_name = name_match.group(1).strip().capitalize() if name_match else 'Exercice'
                
                text_clean = re.sub(r'\d+x\d+-\d+', '', current_ex_text) # Enlève 3x8-12
                text_clean = re.sub(r'\d+-\d+-\d+', '', text_clean) # Enlève 5-8-10
                text_clean = re.sub(r'\d+-\d+', '', text_clean) # Enlève 3-10
                
                sets = []
                chunks = re.split(r'[,\s]+', text_clean)
                for c in chunks:
                    sets.extend(parse_chunk(c))
                    
                if sets:
                    current_workout['exercises'].append({'name': ex_name, 'sets': sets})
            
            current_ex_text = line
        else:
            if current_ex_text:
                current_ex_text += ' ' + line
            else:
                current_ex_text = line

if current_workout and current_ex_text:
    name_match = re.match(r'^(?:\d+\.\s*)?(.*?)(?:\s*-|\s*–|\s*\d)', current_ex_text)
    ex_name = name_match.group(1).strip().capitalize() if name_match else 'Exercice'
    text_clean = re.sub(r'\d+x\d+-\d+', '', current_ex_text)
    text_clean = re.sub(r'\d+-\d+-\d+', '', text_clean)
    text_clean = re.sub(r'\d+-\d+', '', text_clean)
    sets = []
    for c in re.split(r'[,\s]+', text_clean): sets.extend(parse_chunk(c))
    if sets: current_workout['exercises'].append({'name': ex_name, 'sets': sets})
    workouts.append(current_workout)

print(f"Total séances analysées : {len(workouts)}")
for w in workouts[-2:]:
    print(f"\n--- {w['name']} le {w['date']} ---")
    for e in w['exercises']:
        print(f"  {e['name']}")
        for i, s in enumerate(e['sets']):
            print(f"    Série {i+1}: {s['weight']} kg x {s['reps']} reps")

# Export JSON
out_json = r'C:\Users\mathi\Downloads\MuscuLog_Migration_Parfaite.json'
final_workouts = []
for w in workouts:
    bw = {
        'date': w['date'],
        'startedAt': w['date'],
        'finishedAt': w['date'].replace('08:', '09:'),
        'programName': 'Import',
        'workoutName': w['name'],
        'exercises': []
    }
    for i, e in enumerate(w['exercises']):
        be = {
            'exerciseName': e['name'],
            'displayOrder': i,
            'sets': []
        }
        for j, s in enumerate(e['sets']):
            be['sets'].append({
                'weight': s['weight'],
                'reps': s['reps'],
                'setNumber': j + 1
            })
        bw['exercises'].append(be)
    final_workouts.append(bw)

final_data = {'version': 1, 'exportDate': '2026-10-04T12:00:00Z', 'workouts': final_workouts}
with open(out_json, 'w', encoding='utf-8') as f:
    json.dump(final_data, f, indent=2, ensure_ascii=False)
