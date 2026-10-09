# Arvestustöö raport

* **Nimi:** Joonas Mägi
* **Variant:** A
* **Kuupäev:** 09.10.2026

---

## Leitud probleemid

### Probleem 1

* **Skript:** `scripts/backup.sh`
* **Mida skript näiliselt tegi:** Lõi failidest tihendatud `.tar.gz` varukoopia arhiivi.
* **Mis oli tegelikult vale:** Käsk `find "$BACKUP_SOURCE" -type f > "$ARCHIVE"` kirjutas arhiivifaili nimega `backup_*.tar.gz` hoopis lihtsa tekstilise failinimekirja, mitte tegeliku pakkfaili. Kontroll `[ -s "$ARCHIVE" ]` oli tõene üksnes seepärast, et tekstifail polnud tühi.
* **Kuidas vea avastasin:** Kontrollisin loodud arhiivifaili tegelikku tüüpi.
* **Millise käsuga kontrollisin:** `file backups/backup_*.tar.gz` ja `tar -tzf backups/backup_*.tar.gz`
* **Parandus:** Asendasin pakkimise reaga `tar -czf "$ARCHIVE" -C "$BACKUP_SOURCE" .` ning lisasin arhiivi loetavuse kontrolli `tar -tzf "$ARCHIVE" >/dev/null 2>&1`.
* **Kuidas kontrollisin pärast parandust:** Käivitasin `file backups/backup_*.tar.gz` (tulemus: gzip compressed data) ning `tar -tzf` kuvas tegelikud arhiivis olevad failid.

### Probleem 2

* **Skript:** `scripts/disk_check.sh`
* **Mida skript näiliselt tegi:** Mõõtis juurpartitsiooni kettakasutuse protsenti ja võrdles seda limiidiga.
* **Mis oli tegelikult vale:** Käsk `df -h / | awk 'NR==2 {print $4}'` võttis väljundist 4. veeru `Available` (vaba ruum gigabaitides, nt 15G), mitte 5. veeru `Use%`. Käsk `tr -dc '0-9'` eemaldas tähe G ning tõlgendas vabu gigabaite kasutusprotsendina.
* **Kuidas vea avastasin:** Võrdlesin käsu `df -h /` väljundi veerge skripti poolt loetud väärtusega.
* **Millise käsuga kontrollisin:** `df -h /` ja `df -P / | awk 'NR==2 {print $5}'`
* **Parandus:** Muutsin päringu kasutusprotsendi lugemiseks POSIX vormingus: `usage=$(df -P / | awk 'NR==2 {print $5}' | tr -d '%')`.
* **Kuidas kontrollisin pärast parandust:** Käsk `bash -x scripts/disk_check.sh` näitas, et muutuja `$usage` sai tegeliku kettakasutuse protsendi.

### Probleem 3

* **Skript:** `scripts/service_check.sh`
* **Mida skript näiliselt tegi:** Kontrollis, kas määratud süsteemiteenus töötab.
* **Mis oli tegelikult vale:** Käsk `systemctl list-unit-files` kontrollis vaid seda, kas teenuse seadistusfail on süsteemis olemas, mitte seda, kas teenus hetkel reaalselt töötab. Seisva teenuse puhul väitis skript ikkagi, et teenus töötab.
* **Kuidas vea avastasin:** Peatasin katseks teenuse ja käivitasin skripti seiskunud teenusega.
* **Millise käsuga kontrollisin:** `./scripts/service_check.sh <seisev_teenus>` ja `echo $?`
* **Parandus:** Asendasin tingimuse käsuga `systemctl is-active --quiet "$service"` ning lisasin algusesse puuduva argument-parameetri kontrolli.
* **Kuidas kontrollisin pärast parandust:** Seisatud teenuse puhul väljastas skript "Teenus ei tööta" ning exit status oli 1.
* **Vajadusel exit code enne / pärast:** Enne: `0`, Pärast: `1`.

### Probleem 4

* **Skript:** `scripts/system_info.sh`
* **Mida skript näiliselt tegi:** Kuvas süsteemi koondinfot (hostname, kasutaja, kernel, uptime, RAM).
* **Mis oli tegelikult vale:** Väljad olid valed ja omavahel vahetuses: `Hostname` kuvati `whoami` väärtusena ja `Kasutaja` kui `hostname`. `Kernel` kuvas arhitektuuri (`uname -m`), `Uptime` kellaaega (`date`) ning `Mälu kokku` loeti Swap mälust (`/Swap:/`).
* **Kuidas vea avastasin:** Võrdlesin skripti väljundit reaalsete Linuxi süsteemikäskudega.
* **Millise käsuga kontrollisin:** `bash scripts/system_info.sh`
* **Parandus:** Parandasin käsud: Hostname -> `hostname`, Kasutaja -> `whoami`, Kernel -> `uname -r`, Uptime -> `uptime -p`, Mälu -> `free -m` (rida `/Mem:/ {print $2}`).
* **Kuidas kontrollisin pärast parandust:** Käivitasin `bash scripts/system_info.sh` ja veendusin, et kõik 5 välja väljastavad õigeid andmeid.

### Probleem 5

* **Skript:** `scripts/user_check.sh`
* **Mida skript näiliselt tegi:** Kontrollis, kas kasutajakonto on süsteemis olemas.
* **Mis oli tegelikult vale:** Kasutas kontrolliks `/etc/group` faili (`grep -c "$username" /etc/group`), mis ei sisalda kasutajakontosid. Lisaks oli tingimus `[ "$matches" -ge 0 ]` alati tõene (kuna `grep -c` annab tulemusi >= 0), mille tõttu kuvati igasuguse sisendi korral "Kasutaja eksisteerib" ja exit status oli 0.
* **Kuidas vea avastasin:** Käivitasin skripti olematu kasutajanimega.
* **Millise käsuga kontrollisin:** `./scripts/user_check.sh olematu_kasutaja_999` ja `echo $?`
* **Parandus:** Asendasin grupikontrolli käsuga `getent passwd "$username" >/dev/null 2>&1`.
* **Kuidas kontrollisin pärast parandust:** Olematu kasutaja puhul kuvati teade "Kasutajat ei leitud" ja exit status oli 1, eksisteeriva kasutaja puhul exit 0.
* **Vajadusel exit code enne / pärast:** Enne: `0`, Pärast: `1`.

### Probleem 6

* **Skript:** `scripts/user_check.sh`
* **Mida skript näiliselt tegi:** Töötles sisendargumenti kasutajanime otsimiseks.
* **Mis oli tegelikult vale:** Puudus kontroll puuduva või tühja argumendi (`""`) suhtes. Tühja sisendi korral väitis skript ikkagi, et kasutaja eksisteerib.
* **Kuidas vea avastasin:** Käivitasin skripti tühja parameetriga.
* **Millise käsuga kontrollisin:** `./scripts/user_check.sh ""` ja `echo $?`
* **Parandus:** Lisasin kontrolli: `if [ -z "$username" ]; then echo "Viga: Kasutajanimi puudub!"; exit 1; fi`.
* **Kuidas kontrollisin pärast parandust:** Käivitasin `./scripts/user_check.sh ""`, skript kuvas veateate ning väljus exit koodiga 1.
* **Vajadusel exit code enne / pärast:** Enne: `0`, Pärast: `1`.

---

## Uus funktsionaalsus

* **Mida lisasin:** Lõin uue skripti `scripts/network_check.sh`, mis kontrollib võrguühenduse toimimist määratud hostiga (vaikimisi `google.com`) kasutades käsku `ping`.
* **Kuidas käivitada:** `bash scripts/network_check.sh` või `bash scripts/network_check.sh voco.ee`
* **Kuidas kontrollisin, et tulemus on õige:** Testisin toimiva aadressiga (`google.com`, tagastas OK ja exit 0) ning mittevahetatava/olematu aadressiga (`bash scripts/network_check.sh 192.0.2.1`, tagastas veateate ja exit 1; kontrollitud `echo $?`).
