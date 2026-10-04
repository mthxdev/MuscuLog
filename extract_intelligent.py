import json
import re

text_file = r'C:\Users\mathi\Downloads\workouts_raw.txt'
out_json = r'C:\Users\mathi\Downloads\MuscuLog_Migration.json'

with open(text_file, 'r', encoding='utf-8', errors='ignore') as f:
    lines = f.readlines()

workouts = []
current_workout = None
ex_order = 0

def clean_name(n):
    # Nettoie les caractères cassés, les tirets et les numéros du type "1. "
    n = n.replace('Ǹ', 'é').replace('%', 'É').replace('', 'é').replace('ǽ', 'â')
    # Enlève les tirets bizarres ou "?"
    n = n.replace('?"', '').replace('? "', '')
    n = re.sub(r'^\d+\.\s*', '', n)
    return n.strip(' -–—0123456789.')

for line in lines:
    line = line.strip()
    if not line:
        continue
    
    if line.startswith('=== SEANCE DATE:'):
        if current_workout:
            workouts.append(current_workout)
        date_str = line.split('DATE: ')[1].strip(' =')
        parts = date_str.split('/')
        if len(parts) == 3:
            # Format YY
            iso_date = f'20{parts[2]}-{parts[1]}-{parts[0]}T08:00:00Z'
        else:
            iso_date = '2026-01-01T08:00:00Z'
        current_workout = {
            'date': iso_date,
            'startedAt': iso_date,
            'finishedAt': iso_date.replace('08:', '09:'),
            'programName': 'Import',
            'workoutName': 'Séance',
            'exercises': []
        }
        ex_order = 0
    elif line.startswith('TITRE: '):
        name = line.split('Salle (')[1].split(')')[0] if '(' in line else 'Séance'
        current_workout['workoutName'] = name
    elif line.startswith('S1') or line.startswith('S2') or line.startswith('Douche') or line.startswith('deload'):
        pass
    elif 'x' in line or 'X' in line:
        # Ligne d'exercice
        # Exemple: 1. Presse inclinée - 5-8-10 115x10, 155x10, 195x10, 235x10.
        
        # On va diviser par les tirets ou assimilés
        parts = re.split(r' \?\" | - | – | — ', line, maxsplit=1)
        
        if len(parts) > 1:
            ex_name = clean_name(parts[0])
            set_text = parts[1]
        else:
            # S'il n'y a pas de tiret clair (ex: Abdos machine 3x10 10x40...)
            # On cherche le premier motif "nombre x nombre"
            match = re.search(r'\d+x\d+', line)
            if match:
                idx = match.start()
                ex_name = clean_name(line[:idx])
                set_text = line[idx:]
            else:
                ex_name = clean_name(line)
                set_text = ""
                
        # On nettoie les objectifs de la ligne (ex: 3x8-12, 5x8-10)
        set_text = re.sub(r'\d+x\d+-\d+', '', set_text)
        set_text = re.sub(r'\d+-\d+-\d+', '', set_text)
        set_text = re.sub(r'\d+-\d+', '', set_text)
        set_text = re.sub(r'\d+-\d+', '', set_text)
        
        # Remplace les virgules par des points pour la décimale
        set_text = set_text.replace(',', '.')
        
        sets = []
        set_idx = 1
        
        # Split par espaces ou vraies virgules (qui étaient . avant remplacement si on ne faisait pas attention)
        # Comme on a mis des points, séparons juste par les espaces ou le mot "et"
        set_chunks = re.split(r'\s+', set_text)
        
        for chunk in set_chunks:
            # Chercher un vrai A x B dans le bloc. Ex: "45x3+52x3+59x4" ou "39+2.3x10"
            # On va chercher tous les sous-blocs "valeur x valeur"
            sub_matches = re.findall(r'([\d\.\+]+)x([\d\.\+]+)', chunk)
            
            for m in sub_matches:
                left_str = m[0]
                right_str = m[1]
                
                try:
                    left_val = sum(float(v) for v in left_str.split('+') if v)
                    right_val = sum(float(v) for v in right_str.split('+') if v)
                    
                    if left_val > right_val and left_val >= 15:
                        w = left_val
                        r = right_val
                    elif right_val > left_val and right_val >= 15:
                        w = right_val
                        r = left_val
                    else:
                        # Si aucun n'est au-dessus de 15, on devine Reps x Poids.
                        w = right_val
                        r = left_val
                        
                    sets.append({
                        'weight': float(w),
                        'reps': int(r),
                        'setNumber': set_idx
                    })
                    set_idx += 1
                except:
                    continue
                    
        if len(sets) > 0 and ex_name != '':
            current_workout['exercises'].append({
                'exerciseName': ex_name.capitalize(),
                'displayOrder': ex_order,
                'sets': sets
            })
            ex_order += 1

if current_workout:
    workouts.append(current_workout)

final_data = {
    'version': 1,
    'exportDate': '2026-10-04T12:00:00Z',
    'workouts': workouts
}

with open(out_json, 'w', encoding='utf-8') as f:
    json.dump(final_data, f, indent=2, ensure_ascii=False)
