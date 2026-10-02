# 🚀 GitHowTo Harjutusprojekt (`work`)

See repositoorium on loodud Tartu Rakendusliku Kolledži (VOCO) eriala "Skriptimise alused" raames, et õppida ja praktiseerida versioonihaldussüsteemi Git kasutamist. Projekti raames läbiti interaktiivne [GitHowTo](https://githowto.com/) õpijuhend, mille eesmärk oli omandada praktilised oskused koodi versioonide haldamiseks, harudega töötamiseks ning repositooriumi sünkroniseerimiseks GitHubiga.

---

## 📌 Sisukord
1. [Projekti ülevaade](#projekti-ülevaade)
2. [Õpitud teemad ja kontseptsioonid](#õpitud-teemad-ja-kontseptsioonid)
3. [Kasutatud Git-käsud ja nende selgitused](#kasutatud-git-käsud-ja-nende-selgitused)
4. [Kuidas Git'i põhitöövoog toimib](#kuidas-giti-põhitöövoog-toimib)
5. [Konfliktide lahendamine ja harude liitmine](#konfliktide-lahendamine-ja-harude-liitmine)
6. [Tehtud ülesannete kontrollnimekiri](#tehtud-ülesannete-kontrollnimekiri)

---

## Projekti ülevaade

Arendustöös on versioonihaldus hädavajalik tööriist, mis võimaldab jälgida failide muutmise ajalugu, liikuda vajadusel varasemate seisude juurde ning töötada turvaliselt erinevate funktsionaalsuste kallal ilma põhikoodeksit lõhkumata. Selles projektis harjutati kohaliku varamu seadistamist, muudatuste vahealasse ehk *staging area*'sse lisamist, commit'ide tegemist ning tööd harudega (*branches*).

---

## Õpitud teemad ja kontseptsioonid

Õppeprotsessi käigus läbiti järgmised peamised versioonihalduse teemad:

### 1. Seadistamine ja repositooriumi loomine
- Kasutaja identiteedi seadistamine globaalselt ja lokaalselt
- Uue kohaliku Git varamu algatamine koodikaustas
- Failide olekute mõistmine (*untracked*, *staged*, *committed*, *modified*)

### 2. Ajalugu ja muudatuste jälgimine
- Muudatuste lisamine puhveralale enne salvestamist
- Tähendusrikaste ja struktureeritud commit-sõnumite koostamine
- Projekti muudatuste ajaloo ja harude puu visualiseerimine

### 3. Harudega töötamine (*Branching*)
- Põhiharu (*main* / *master*) kaitsmine ja eraldiseisvate funktsiooni-harude loomine
- Ohutu üleminek ühest harust teise ilma pooleliolevat tööd kaotamata
- Muudatuste koondamine ja liitmine põhiharru

### 4. Kaugaramud ja turvaline ühendus (*Remote Repositories*)
- Kohaliku varamu sidumine GitHubi kaugvaramuga
- SSH-võtmete kasutamine turvaliseks autentimiseks ja andmevahetuseks
- Muudatuste laadimine serverisse ning koodi uuendamine serverist

---

## Kasutatud Git-käsud ja nende selgitused

Alljärgnevalt on välja toodud projekti käigus kõige enam kasutatud käsud koos lühikirjeldusega:

* `git config` — seadistab kasutaja nime ja e-posti aadressi (nt `git config --global user.name "Sinu Nimi"`).
* `git init` — algatab praeguses kaustas uue tühja Git repositooriumi.
* `git status` — kuvab töökausta ja vaheala (*staging area*) hetkeseisu ning teavitab muudetud või jälgimata failidest.
* `git add` — lisab muudetud või uued failid vahealasse (nt `git add README.md` või `git add .` kõigi failide jaoks).
* `git commit` — salvestab vahealas olevad muudatused püsivalt repositooriumi ajalukku koos selgitava sõnumiga (`git commit -m "Sõnum"`).
* `git log` — kuvab sooritatud commit'ide ajalugu, autorit, kuupäeva ja sõnumit (tihendatud vaate jaoks kasutusel `git log --oneline`).
* `git branch` — kuvab olemasolevaid harusid või loob uue haru (`git branch uue-haru-nimi`).
* `git switch` — võimaldab mugavalt harude vahel lülituda (nt `git switch main`) või luua uue haru ja sellele kohe üle minna (`git switch -c uus-haru`).
* `git checkout` — vanem käsk harude vahel lülitumiseks või failide varasema seisu taastamiseks.
* `git merge` — liidab valitud haru muudatused hetkel aktiivsesse harusse (`git merge funktsiooni-haru`).
* `git remote` — haldab ühendatud kaugvaramuid (nt `git remote add origin git@github.com:kasutaja/repo.git`).
* `git push` — saadab kohaliku haru muudatused kaugserverisse (`git push -u origin main`).
* `git pull` — tõmbab kaughoidlast viimased muudatused ja liidab need kohaliku haruga.

---

## Kuidas Git'i põhitöövoog toimib

Tavapärane ja soovitatav igapäevane töövoog uue funktsionaalsuse või paranduse lisamisel koosneb järgmistest sammudest:

1. **Värskeima koodi tõmbamine:** Enne uue töö alustamist veendutakse, et kohalik `main` haru on serveriga samal seisul.
2. **Uue haru loomine:** Kõik muudatused tehakse eraldi haruses, et mitte segada teiste tööd ega rikkuda toimivat koodi.
3. **Muudatuste tegemine ja testimine:** Failide redigeerimine või uute failide lisamine.
4. **Muudatuste puhverdamine (*Staging*):** Valitud muudatuste lisamine vahealasse käsuga `git add`.
5. **Muudatuste salvestamine (*Committing*):** Puhverdatud seisu fikseerimine selgitava sõnumiga käsuga `git commit`.
6. **Liitmine ja laadimine serverisse:** Muudatuste liitmine peaotsa ning laadimine GitHubi repository'sse.

### Näide täielikust koodi töövoost:

```bash
# 1. Veendu, et oled põhiharus ja kood on uuendatud
git switch main
git pull origin main

# 2. Loo uus haru uue funktsiooni jaoks ja lülitu sellele
git switch -c lisa-dokumentatsioon

# 3. Tee vajalikud muudatused failides (nt README.md)
# 4. Kontrolli muudetud failide staatust
git status

# 5. Lisa muudetud failid vahealasse
git add README.md

# 6. Fikseeri muudatused kohalikus ajaloos
git commit -m "Täienda projekti README.md dokumentatsiooni"

# 7. Lülitu tagasi põhiharru ja liida tehtud muudatused
git switch main
git merge lisa-dokumentatsioon

# 8. Saada uuendatud põhiharu GitHubi kaugvaramusse
git push origin main
