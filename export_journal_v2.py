import os
import re
import json
from datetime import datetime
from bs4 import BeautifulSoup

entries_dir = r"C:\Users\mathi\Downloads\Entries"
output_file = r"C:\Users\mathi\Downloads\MuscuLog_Migration.json"
backup_workouts = []

def parse_line(line_text):
    # Séparer le nom de l'exercice et la partie "séries"
    # Généralement séparé par " - " ou "  " ou " ?"
    parts = re.split(r"[-–—?]", line_text, maxsplit=1)
    if len(parts) < 2:
        return None, []
        
    ex_name = parts[0].strip()
    
    # Nettoyer les caractères parasites du nom
    ex_name = ex_name.replace("Ǹ", "é").replace("", "é").replace("ǽ", "â").replace("", "è")
    
    perf_text = parts[1].strip()
    
    # Supprimer la consigne cible (ex: "3x8-12 ou max possible", "4x8-10", "310-11")
    # On cherche le premier motif qui ressemble à "3x10", "48-10", "4-8-10" au début et on l'enlève.
    # On peut aussi juste chercher ce qui est après le dernier espace avant les vraies séries, 
    # ou se baser sur le fait que tes vraies séries sont séparées par des virgules (ex: 10x20, 10x30).
    
    # On va découper le texte par les virgules suivies d'un espace (pour ne pas casser "15,8" kg)
    # Remplaçons d'abord ", " par " | "
    perf_text = perf_text.replace(", ", " | ")
    # Gérons aussi le cas où la dernière série finit par un point
    perf_text = perf_text.replace(".", "")
    
    chunks = perf_text.split(" | ")
    
    actual_sets = []
    
    for chunk in chunks:
        # Dans chaque morceau, on cherche un motif Poids x Reps (ou Reps x Poids)
        # Ex: "32x12", "10x20", "12x11x10", "15x2,3", "59x1/2"
        # Remplaçons la virgule décimale par un point
        chunk = chunk.replace(",", ".")
        
        # Ignorer le chunk s'il contient "ou max possible" ou s'il n'y a pas de 'x'
        if "x" not in chunk.lower() and "" not in chunk:
            continue
            
        # Chercher tous les nombres dans le chunk
        # ex: "32x12" -> ['32', '12']
        # ex: "12x11x10" -> ['12', '11', '10']
        # ex: "3x8-12" -> ['3', '8', '12'] -> on veut ignorer ça
        nums = re.findall(r"\d+(?:\.\d+)?", chunk)
        
        if len(nums) < 2:
            continue
            
        # Si c'est le TOUT PREMIER chunk et qu'il ressemble à "3x8-12" ou "4x10-12 10x20"
        # On doit être prudent.
        if len(nums) >= 3 and "-" in chunk: 
            # C'est probablement la consigne (ex: 3x8-12) mélangée avec la première série (10x20)
            # Extrayons seulement la dernière partie qui a un 'x' sans tiret
            sub_chunks = chunk.split()
            for sub in sub_chunks:
                if "x" in sub.lower() and "-" not in sub:
                    nums = re.findall(r"\d+(?:\.\d+)?", sub)
                    break
            else:
                continue # on ignore
                
        if len(nums) >= 2:
            a = float(nums[0])
            b = float(nums[1])
            
            # Gestion de 12x11x10 (Poids x Reps x Reps)
            c = float(nums[2]) if len(nums) > 2 and "-" not in chunk else None
            
            if c is not None and c > 0:
                # ex: 12x11x10 -> weight=12, reps = (11+10)/2 ou juste 11
                weight = a
                reps = int((b + c) / 2) # Moyenne des deux bras
            else:
                # Trouver qui est le poids et qui sont les reps
                # D'habitude Reps x Poids (10x20, 10x30, 6x50) 
                # MAIS pour le tirage "32x12", c'est Poids x Reps.
                # On va utiliser une règle simple : le plus grand est le poids (si > 15).
                if a > b and a > 15:
                    weight = a
                    reps = b
                elif b > a and b > 15:
                    weight = b
                    reps = a
                else:
                    # Cas par défaut: si pas évident, assumons Reps x Poids si le premier est 8, 10, 12, etc.
                    weight = b
                    reps = a
            
            actual_sets.append({
                "weight": float(weight),
                "reps": int(reps)
            })
            
    return ex_name, actual_sets

for filename in os.listdir(entries_dir):
    if not filename.endswith(".html"):
        continue

    filepath = os.path.join(entries_dir, filename)
    with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
        html_content = f.read()

    soup = BeautifulSoup(html_content, "html.parser")
    
    title_div = soup.find('div', class_='title')
    if not title_div:
        continue
    date_str = title_div.get_text(strip=True)
    
    try:
        workout_date = datetime.strptime(date_str, "%d/%m/%y")
    except ValueError:
        try:
            workout_date = datetime.strptime(date_str, "%d/%m/%Y")
        except ValueError:
            continue

    paragraphs = soup.find_all('p')
    for p in paragraphs:
        text = p.get_text(separator=" ", strip=True)
        if "Salle" in text and ("Upper" in text or "Lower" in text):
            workout_name_match = re.search(r"Salle\s*\((.*?)\)", text, re.IGNORECASE)
            workout_name = workout_name_match.group(1).strip() if workout_name_match else "Séance"
            
            time_match = re.search(r"(\d{1,2})h(\d{2})", text)
            if time_match:
                workout_date = workout_date.replace(hour=int(time_match.group(1)), minute=int(time_match.group(2)))
            
            ol_tag = p.find_next_sibling('ol')
            if not ol_tag:
                # Parfois c'est pas une liste <ol>, c'est des paragraphes en dessous
                continue
                
            backup_exercises = []
            display_order = 0
            
            for li in ol_tag.find_all('li'):
                ex_text = li.get_text(separator=" ", strip=True)
                ex_name, sets = parse_line(ex_text)
                
                if ex_name and len(sets) > 0:
                    formatted_sets = []
                    for i, s in enumerate(sets):
                        formatted_sets.append({
                            "weight": s["weight"],
                            "reps": s["reps"],
                            "setNumber": i + 1
                        })
                    
                    backup_exercises.append({
                        "exerciseName": ex_name.capitalize(),
                        "displayOrder": display_order,
                        "sets": formatted_sets
                    })
                    display_order += 1
            
            if len(backup_exercises) > 0:
                backup_workouts.append({
                    "date": workout_date.isoformat() + "Z",
                    "startedAt": workout_date.isoformat() + "Z",
                    "finishedAt": workout_date.replace(hour=min(workout_date.hour + 1, 23)).isoformat() + "Z",
                    "programName": "Import",
                    "workoutName": workout_name,
                    "exercises": backup_exercises
                })

backup_workouts.sort(key=lambda x: x["date"])

backup_data = {
    "version": 1,
    "exportDate": datetime.now().isoformat() + "Z",
    "workouts": backup_workouts
}

with open(output_file, 'w', encoding='utf-8') as f:
    json.dump(backup_data, f, indent=2, ensure_ascii=False)

print(f"Extraction V2 terminée proprement. {len(backup_workouts)} séances trouvées.")
