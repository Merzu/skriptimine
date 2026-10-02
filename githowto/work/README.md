# 🚀 GitHowTo: Git & Versioonihaldus A-st Ü-ni

![Git Banner](https://raw.githubusercontent.com/git/git-scm.com/main/app/assets/images/logos/downloads/Git-Logo-2Color.png)

[![Git Status](https://img.shields.io/badge/GitHowTo-L%C3%A4bitud-brightgreen?style=for-the-badge&logo=git)](https://githowto.com)
[![Versioonihaldus](https://img.shields.io/badge/Versioonihaldus-Git-orange?style=for-the-badge&logo=git)](https://git-scm.com)
[![Õppeaste](https://img.shields.io/badge/Tase-Algaja_kuni_Kesktase-blue?style=for-the-badge)](#)

See hoidla sisaldab minu praktilisi harjutusi, märkmeid ja käsurea katsetusi, mis on läbitud interaktiivse [GitHowTo](https://githowto.com) juhendi põhjal. Projekt dokumenteerib tee Giti installimisest ja esimestest muudatustest kuni keerulisemate harude liitmiste ning konflikti lahendamiseni.

---

## 📚 Mida ma selle projekti käigus õppisin?

Läbitud juhendi käigus omandasin järgmised põhioskused ja kontseptsioonid:

### 1. Vundament ja esmased toimingud
* **Hoidla alustamine ja seadistamine (`git init`, `git config`):** Kuidas luua uut projektihoidlat ning seadistada kasutaja andmeid (nimi ja e-post).
* **Muudatuste jälgimine (`git status`, `git add`):** Erinevuse mõistmine jälgimata (*untracked*), muudetud (*modified*) ja puhverdatud (*staged*) failide vahel.
* **Muudatuste fikseerimine (`git commit`):** Tähendusrikaste commit-sõnumite kirjutamine ning projekti ajaloo salvestamine.

### 2. Ajalugu ja võrdlemine
* **Ajaloo sirvimine (`git log`):** Logide vaatamine lühikujul (`--oneline`), graafina (`--graph`) ning muudatuste analüüsimine.
* **Erinevuste tuvastamine (`git diff`):** Tööruumi, puhverala ja eelmiste commit'ide erinevuste võrdlemine.

### 3. Ajas tagasi liikumine ja veaparandused
* **Muudatuste tühistamine (`git checkout`, `git restore`):** Failide taastamine eelmise commiti seisu.
* **Commiti tühistamine (`git revert` vs `git reset`):** Vahe tegemine turvalisel tühistamisel (`revert`, mis loob uue commiti) ja ajaloo ümberkirjutamisel (`reset`).
* **Sildistamine (`git tag`):** Versiooninumbrite (nt `v1.0`) omistamine konkreetsetele punktidele ajaloos.

### 4. Harudega töötamine (Branching & Merging)
* **Harude loomine ja vahetamine (`git branch`, `git checkout -b` / `git switch`):** Iseseisvate töövoogude loomine uute funktsionaalsuste jaoks.
* **Harude liitmine (`git merge`):** Muudatuste toomine lisaharust põhiharru (*main* / *master*).
* **Konfliktide lahendamine (*Merge Conflicts*):** Oskus tuvastada ja käsitsi lahendada olukordi, kus kaks haru on muutnud sama koodirida.
* **Ajaloo silumine (`git rebase`):** Harude sirgjooneliseks muutmine puhta ajaloo tagamiseks.

---

## 🛠️ Olulisemate käskude spikker

| Käsk | Kirjeldus |
| :--- | :--- |
| `git status` | Kuvab tööruumi ja puhverala hetkeseisu. |
| `git add .` | Lisab kõik muudetud failid puhveralale (*staging area*). |
| `git commit -m "sõnum"` | Salvestab puhverdatud muudatused kohalikku ajalukku. |
| `git log --oneline --graph` | Kuvab ajaloo tihendatud graafilisel kujul. |
| `git branch -a` | Kuvab kõik kohalikud ja kaughoidla harud. |
| `git checkout -b <haru-nimi>` | Luuakse uus haru ja liigutakse sellele. |
| `git merge <haru-nimi>` | Liidab märgitud haru hetkel aktiivsesse harru. |
| `git reset --hard HEAD~1` | Eemaldab viimase commiti ja viib tööruumi eelmisesse seisu. |

---

## 📸 Praktilised näited ja ekraanipildid

### 1. Harude puu (Git Graph)
*(Siia saad lisada ekraanipildi oma terminalist või VS Code Git Graph laiendusest)*

![Git Graph näidis](https://via.placeholder.com/800x400/24292e/ffffff?text=Lisa+siia+ekraanipilt+oma+git+log+--graph+tulemusest)

### 2. Konflikti lahendamine
*(Näide sellest, kuidas kooditööriist kuvab konflikte)*

![Merge Conflict näidis](https://via.placeholder.com/800x300/1e1e1e/00ff00?text=Lisa+siia+pilt+konflikti+lahendamisest)
