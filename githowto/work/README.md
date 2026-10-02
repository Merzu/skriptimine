# GitHowTo harjutusprojekt (`work`)

*Õpi ja praktiseeri Git versioonihaldust ning GitHubi kasutusoskusi.*

## Tere tulemast!

See repositoorium on loodud Tartu Rakendusliku Kolledži (VOCO) kursuse "Skriptimise alused" raames. Projekti raames läbiti interaktiivne [GitHowTo](https://githowto.com/) juhend, mille eesmärk on anda praktilised oskused Giti ja GitHubi kasutamiseks igapäevases tarkvaraarenduses.

- **Kellele mõeldud:** VOCO õppuritele ja alustavatele tarkvaraarendajatele.
- **Mida õpid:** Repositooriumide haldamist, harudega töötamist (`branches`), commit'ide tegemist ja liitmisel tekkivate konfliktide lahendamist.
- **Mida ehitad:** Praktiliselt dokumenteeritud repositooriumi koos korrekti Markdown-vormingus `README.md` failiga.
- **Eeldused:** Puuduvad. Sobib suurepäraselt esimeseks sissejuhatuseks Giti maailma.
- **Kestus:** Selle harjutuse läbimiseks kulub umbes 1–2 tundi.

In selle harjutuse käigus teed järgmist:
1. Algatad kohaliku repositooriumi käsuga `git init`
2. Lood uue haru ja lülitud sellele käsuga `git switch`
3. Lisad muudatused vahealasse ning teed commit'i
4. Liidad harud kokku (`git merge`) ja saadav koodi serverisse (`git push`)

---

## 📚 Õpitud teemad ja käsud

Selle projekti käigus omandati järgmised põhilised versioonihalduse kontseptsioonid ja käsud.

### 1. Seadistamine ja põhikäsud
* **Kasutaja seadistamine:** Nime ja e-posti määramine käsuga `git config`.
* **Oleku kontroll:** Failide staatuse jälgimine käsuga `git status`.
* **Puhverala (Staging Area):** Muudatuste lisamine vahealasse käsuga `git add`.
* **Commit'i tegemine:** Muudatuste püsiv salvestamine käsuga `git commit -m "Sõnum"`.

### 2. Harudega töötamine ja liitmine
* **Harude haldus:** Uue haru loomine käsuga `git branch <haru-nimi>`.
* **Haru vahetamine:** Harude vahel lülitumine käsuga `git switch <haru-nimi>`.
* **Muudatuste liitmine:** Haru muudatuste koondamine põhiharru käsuga `git merge <haru-nimi>`.

---

## 💻 Kuidas Git'i põhitöövoog toimib

Tüüpiline igapäevane töövoog uue funktsionaalsuse ehitamisel:

```bash
# 1. Loo uus haru ja lülitu sellele
git switch -c uus-funktsioon

# 2. Tee muudatused ning lisa need vahealasse
git add .

# 3. Salvesta muudatused kohalikku ajalukku
git commit -m "Lisa uus funktsionaalsus"

# 4. Lülitu tagasi põhiharru ja liida muudatused
git switch main
git merge uus-funktsioon

# 5. Saada muudatused GitHubi kaugserverisse
git push origin main
