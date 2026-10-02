# 🚀 GitHowTo Harjutusprojekt (`work`)

[![Git Status](https://img.shields.io/badge/GitHowTo-L%C3%A4bitud-brightgreen?style=for-the-badge&logo=git)](https://githowto.com)
[![Versioonihaldus](https://img.shields.io/badge/Versioonihaldus-Git-orange?style=for-the-badge&logo=git)](https://git-scm.com)

See hoidla on loodud Tartu Rakendusliku Kolledži (VOCO) kursuse "Skriptimise alused" raames, et õppida ja praktiseerida Git-versioonihaldussüsteemi, läbides interaktiivse [GitHowTo](https://githowto.com/) juhendi punktid 2–29. Projekti eesmärk on mõista Git-i tööpõhimõtteid ning omandada põhilised käsud igapäevaseks tarkvaraarenduseks.

---

## 📚 Õpitud teemad ja kontseptsioonid

Projekti käigus õppisin haldama koodi versioone, töötama harudega ning lahendama liitmisel tekkivaid konfliktiolukordi.

### 1. Seadistamine ja esmased käsud
* **Kasutaja seadistamine:** Nime ja e-posti määramine käsuga `git config`.
* **Hoidla algatamine:** Uue versioonihalduse loomine kaustas käsuga `git init`.
* **Oleku kontroll:** Failide staatuse jälgimine käsuga `git status`.

### 2. Muudatuste salvestamine ja ajalugu
* **Puhverala (Staging Area):** Muudatuste lisamine jälgimisse käsuga `git add <failinimi>`.
* **Kinnitamine (Commit):** Muudatuste salvestamine ajalukku selgitava sõnumiga käsuga `git commit -m "Sõnum"`.
* **Ajaloo sirvimine:** Teostatud commit'ide vaatamine käsuga `git log` ja `git log --oneline --graph`.

### 3. Harudega töötamine (Branching & Merging)
* **Harude haldus:** Uue haru loomine ja vaatamine käsuga `git branch`.
* **Haru vahetamine:** Harude vahel lülitumine käsuga `git switch <haru_nimi>` või `git checkout <haru_nimi>`.
* **Harude liitmine:** Kõrvalharu muudatuste toomine põhiharru käsuga `git merge <haru_nimi>`.
* **Konfliktide lahendamine:** Käsitsi vastuoluliste koodiridade parandamine ja uue commit'i tegemine.

---

## 🛠️ Olulisemate Git-käskude spikker

| Käsk | Kirjeldus |
| :--- | :--- |
| `git status` | Kuvab tööruumi ja puhverala hetkeseisu |
| `git add .` | Lisab kõik muudetud failid puhveralale (*staging area*) |
| `git commit -m "sõnum"` | Salvestab puhverdatud muudatused kohalikku ajalukku |
| `git log --oneline` | Kuvab ajaloo tihendatud kujul |
| `git branch -a` | Kuvab kõik kohalikud ja kaughoidla harud |
| `git switch <haru>` | Lülitub valitud harule |
| `git merge <haru>` | Liidab märgitud haru aktiivsesse harru |

---

## 🔄 Git'i põhitöövoog näitega

Tüüpiline igapäevane töövoog uue funktsionaalsuse lisamisel ja liitmisel:

```bash
# 1. Loo uus haru ja lülitu sellele
git switch -c uue-funktsiooni-haru

# 2. Tee koodis muudatused ja lisa need puhveralale
git add .

# 3. Salvesta muudatused kohalikku ajalukku
git commit -m "Lisa uue funktsiooni kood"

# 4. Lülitu tagasi peaotsa ja liida uus haru
git switch main
git merge uue-funktsiooni-haru

# 5. Saada muudatused kaughoidlasse
git push origin main
