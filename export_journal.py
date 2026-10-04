import os
import re
import json
from datetime import datetime
from bs4 import BeautifulSoup

entries_dir = r"C:\Users\mathi\Downloads\Entries"
output_file = r"C:\Users\mathi\Downloads\MuscuLog_Migration.json"

backup_workouts = []

# Expressions régulières pour analyser les séries (ex: 32x12, 12x11x10, 10x20)
# Parfois tu mets Poids x Reps, parfois Reps x Poids.
# Format commun: "32x12" (Poids x Reps ou inverse, on va extraire les couples)
set_pattern = re.compile(r"(\d+(?:[.,]\d+)?)\s*x\s*(\d+(?:[.,]\d+)?)")

def extract_sets(text):
    # Cherche tous les motifs de type "poids x reps"
    matches = set_pattern.findall(text)
    sets = []
    set_number = 1
    for match in matches:
        a = float(match[0].replace(',', '.'))
        b = float(match[1].replace(',', '.'))
        
        # Souvent, si un nombre est petit (genre 6, 8, 10, 12) et l'autre grand (20, 30, 40),
        # le petit est les reps et le grand le poids. Si les deux sont petits (ex: élévations 15x2.3),
        # on doit faire attention. Généralement, pour MuscuLog, weight et reps.
        
        # On essaie d'être malin.
        if a > b and a > 15: # Ex: 32x12 -> weight=32, reps=12
            weight = a
            reps = int(b)
        elif b > a and b > 15: # Ex: 10x20 -> weight=20, reps=10
            weight = b
            reps = int(a)
        else:
            # S'ils sont proches, on suppose Poids x Reps en premier, ou Reps x Poids.
            # D'après "10x20", ça ressemble à Reps x Poids. "32x12" = Poids x Reps.
            # C'est un peu mélangé. On va utiliser la convention générale: Si a > b, Poids x Reps.
            weight = a
            reps = int(b)

        sets.append({
            "weight": float(weight),
            "reps": int(reps),
            "setNumber": set_number
        })
        set_number += 1
    return sets


for filename in os.listdir(entries_dir):
    if not filename.endswith(".html"):
        continue

    filepath = os.path.join(entries_dir, filename)
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        html_content = f.read()

    soup = BeautifulSoup(html_content, "html.parser")
    
    # Trouver la date dans <div class='title'>
    title_div = soup.find('div', class_='title')
    if not title_div:
        continue
    date_str = title_div.get_text(strip=True) # Ex: 11/10/25
    
    try:
        workout_date = datetime.strptime(date_str, "%d/%m/%y")
    except ValueError:
        try:
            workout_date = datetime.strptime(date_str, "%d/%m/%Y")
        except ValueError:
            continue # Si on ne peut pas parser la date, on passe

    # Chercher un paragraphe mentionnant "Salle"
    paragraphs = soup.find_all('p')
    for p in paragraphs:
        text = p.get_text()
        if "Salle (" in text or "Salle(" in text:
            workout_name_match = re.search(r"Salle\s*\((.*?)\)", text, re.IGNORECASE)
            workout_name = workout_name_match.group(1).strip() if workout_name_match else "Séance"
            
            # L'heure de début est généralement au début de la ligne, ex: "8h15 - Salle..."
            time_match = re.search(r"(\d{1,2})h(\d{2})", text)
            if time_match:
                hour = int(time_match.group(1))
                minute = int(time_match.group(2))
                workout_date = workout_date.replace(hour=hour, minute=minute)
            
            # Les exercices sont dans la balise <ol> suivante
            ol_tag = p.find_next_sibling('ol')
            if not ol_tag:
                continue
                
            backup_exercises = []
            display_order = 0
            
            for li in ol_tag.find_all('li'):
                ex_text = li.get_text(strip=True)
                
                # Splitter par "-" ou "–" pour avoir le nom
                parts = re.split(r"[-–—]", ex_text)
                ex_name = parts[0].strip() if len(parts) > 0 else "Exercice Inconnu"
                
                # On extrait les séries du texte entier
                sets = extract_sets(ex_text)
                
                backup_exercises.append({
                    "exerciseName": ex_name,
                    "displayOrder": display_order,
                    "sets": sets
                })
                display_order += 1
                
            backup_workouts.append({
                "date": workout_date.isoformat() + "Z",
                "startedAt": workout_date.isoformat() + "Z",
                "finishedAt": workout_date.replace(hour=min(workout_date.hour + 1, 23)).isoformat() + "Z", # 1h de séance environ
                "programName": "Import",
                "workoutName": workout_name,
                "exercises": backup_exercises
            })

# Trie des séances par date (chronologique, de la plus ancienne à la plus récente)
backup_workouts.sort(key=lambda x: x["date"])

backup_data = {
    "version": 1,
    "exportDate": datetime.now().isoformat() + "Z",
    "workouts": backup_workouts
}

with open(output_file, 'w', encoding='utf-8') as f:
    json.dump(backup_data, f, indent=2, ensure_ascii=False)

print(f"Extraction terminée. {len(backup_workouts)} séances trouvées.")
print(f"Fichier sauvegardé : {output_file}")
