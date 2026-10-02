# 🚀 GitHowTo Harjutusprojekt (`work`)

[![Git](https://img.shields.io/badge/Git-F05032?style=for-the-badge&logo=git&logoColor=white)](https://git-scm.com/)
[![GitHub](https://img.shields.io/badge/GitHub-181717?style=for-the-badge&logo=github&logoColor=white)](https://github.com/)
[![VOCO](https://img.shields.io/badge/Õppeasutus-VOCO-blue?style=for-the-badge)](https://voco.ee/)

*Interaktiivse GitHowTo juhendi läbimine ja praktilised harjutused versioonihalduses.*

---

## 📌 Projekti ülevaade

See repositoorium on loodud Tartu Rakendusliku Kolledži (VOCO) eriala **Skriptimise alused** raames. Projekti eesmärk on omandada praktilised oskused versioonihaldussüsteemi **Git** ja platvormi **GitHub** kasutamisel, läbides interaktiivse [GitHowTo](https://githowto.com/) õpijuhendi sammud.

### 🎯 Kursuse raamistik
- **Sihtrühm:** Tarkvaraarenduse ja skriptimise aluste õppurid.
- **Peamine eesmärk:** Õppida koodi versioneerimist, harudega töötamist (`branching`) ning liitmiskonfliktide lahendamist.
- **Tulemus:** Täielikult dokumenteeritud harjutusprojekt koos puhta koodi ja versiooniajalooga.
- **Õppematerjal:** [GitHowTo interaktiivne juhend](https://githowto.com/)

---

## 🖼️ Töövoo ja harude visualiseerimine

Arendusprotsessi ja harude liitmise visuaalne ülevaade:

![Git töövood ja harud](./images/git-workflow.png)

---

## 📚 Õpitud teemad ja kontseptsioonid

Projekti käigus läbiti ja praktiseeriti järgmisi põhilisi versioonihalduse teemasid:

### 1. Seadistamine ja hoidla algatamine
* Kasutaja identiteedi määratlemine käsuga `git config`.
* Uue kohaliku hoidla algatamine käsuga `git init`.
* Failide oleku kontrollimine ja jälgimine käsuga `git status`.

### 2. Muudatuste salvestamine ja ajalugu
* Muudatuste suunamine vahealasse (*staging area*) käsuga `git add`.
* Muudatuste püsiv fikseerimine selgitava sõnumiga käsuga `git commit -m "sõnum"`.
* Projekti tegevuste ajaloo sirvimine ja analüüsimine käsuga `git log`.

### 3. Harudega töötamine (Branching & Merging)
* Uute harude loomine isoleeritud arenduseks käsuga `git branch`.
* Harude vahel lülitumine käsuga `git switch`.
* Tehtud muudatuste kokkuliitmine põhiharru käsuga `git merge`.
* Liitmiskonfliktide (*merge conflicts*) tuvastamine ja käsitsi parandamine.

---

## 🛠️ Olulisemate Git-käskude spikker

| Käsk | Kirjeldus | Näide |
| :--- | :--- | :--- |
| `git status` | Kuvab tööruumi ja vaheala hetkeseisu | `git status` |
| `git add` | Lisab faili(d) vahealasse | `git add README.md` |
| `git commit` | Salvestab vaheala muudatused ajalukku | `git commit -m "Lisa funktsioon"` |
| `git log` | Kuvab tihendatud commit'ide ajaloo | `git log --oneline --graph` |
| `git switch` | Lülitub teisele harusse või loob uue | `git switch -c uus-haru` |
| `git merge` | Liidab valitud haru aktiivsesse harusse | `git merge uus-haru` |

---

## 💻 Kuidas Git'i põhitöövoog toimib

Tüüpiline igapäevane töövoog uue funktsionaalsuse ehitamisel ja serverisse saatmisel:

```bash
# 1. Veendu, et oled põhiharus ning laadi viimased muudatused
git switch main
git pull origin main

# 2. Loo uus haru funktsiooni jaoks ja lülitu sellele
git switch -c funktsioon/uus-leht

# 3. Tee koodimuudatused, lisa need vahealasse ja tee commit
git add .
git commit -m "Lisa uue lehe dokumentatsioon"

# 4. Lülitu tagasi põhiharru ja liida tehtud töö
git switch main
git merge funktsioon/uus-leht

# 5. Saada uuendatud põhiharu GitHubi kaughoidlasse
git push origin main
