# GitHowTo Harjutusprojekt (`work`)

See repositoorium on loodud õppeaine raames Git-versioonihaldussüsteemi õppimiseks ja praktiseerimiseks, kasutades [GitHowTo](https://githowto.com/) juhendit. Projekti eesmärk on mõista Git-i tööpõhimõtteid ning omandada põhilised käsud igapäevaseks arendustööks.

## Õpitud teemad ja käsud

Projekti käigus õppisin haldama koodi versioone, töötama harudega ning lahendama lihtsamaid konflikte.

### Kasutatud Git käsud:

- `git status` — kontrollib tööfailide ja muudatuste staatust (mis on muudetud, lisatud või jälgimisel).
- `git add` — lisab muudatused vahealasse (*staging area*), et need oleksid valmis salvestamiseks.
- `git commit` — salvestab vahealas olevad muudatused repositooriumi ajalukku koos selgitava sõnumiga.
- `git log` — kuvab projekti commit'ide ajalugu.
- `git branch` — näitab olemasolevaid harusid või loob uue haru.
- `git switch` — võimaldab harude vahel kiiresti lülituda.
- `git merge` — liidab teise haru muudatused aktiivsesse harusse.

---

## Kuidas Git'i põhitöövoog toimib

Git-i tavapärane töövoog koosneb järgmistest sammudest:

1. **Muudatuste tegemine:** Muuda või loo faile oma töökaustas.
2. **Staging (vaheala):** Lisa soovitud muudatused vahealasse käsuga `git add <failinimi>`.
3. **Commit:** Salvesta muudatused versioonihaldusse käsuga `git commit -m "Sõnum"`.
4. **Harudega töötamine:** Loo uue funktsionaalsuse jaoks eraldi haru, teosta muudatused ning liida see hiljem põhiharuga (`main`).

### Näide tüüpilisest töövoost harudega:

```bash
# Loo uus haru ja lülitu sellele
git switch -c uus-funktsioon

# Tee muudatused ja lisa need staging alasse
git add .

# Salvesta muudatused
git commit -m "Lisa uus funktsionaalsus"

# Lülitu tagasi peaotsa ja liida uus haru
git switch main
git merge uus-funktsioon
