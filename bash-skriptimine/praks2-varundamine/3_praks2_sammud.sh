#!/bin/bash
sudo apt-get update -y && sudo apt-get install -y zstd xz-utils
mkdir -p ~/praks2/src/{docs,imgs,bin} ~/praks2/backup ~/praks2/logs
echo "Kasutusjuhend" > ~/praks2/src/docs/juhend.txt
echo "Testpilt" > ~/praks2/src/imgs/b.jpg
printf '#!/bin/bash\necho Tere\n' > ~/praks2/src/bin/run.sh
printf "imgs/\n*.tmp\n" > ~/praks2/src/.backupignore

tar -I 'zstd -19 -T0' -cf ~/praks2/backup/src_$(date +%Y%m%d_%H%M%S).tar.zst -C ~/praks2 src
tar -I 'zstd -d' -tf ~/praks2/backup/src_*.tar.zst | head -n 5
du -h ~/praks2/backup/src_*.tar.zst | awk '{print $1}'
ls -1t ~/praks2/backup/*.tar.zst | tail -n +4 | xargs -r rm -f
tar -I 'zstd -19 -T0' --exclude='*.jpg' --exclude='bin' -cf ~/praks2/backup/src_excl_$(date +%Y%m%d_%H%M%S).tar.zst -C ~/praks2 src
tar -cf - -C ~/praks2 src | tar -tvf -
echo "[$(date '+%F %T')] BACKUP START" >> ~/praks2/logs/backup.log
cat ~/praks2/logs/backup.log
VAJA=$(du -sb ~/praks2/src | awk '{print $1}')
VABA=$(df -B1 ~/praks2/backup | awk 'NR==2 {print $4}')
echo "Vaja: $VAJA B, Vaba: $VABA B"
cd ~/praks2/backup
FAIL=$(ls -t src_*.tar.zst | head -n 1)
sha256sum "$FAIL" > "${FAIL}.sha256"
sha256sum -c "${FAIL}.sha256"
tar -I 'zstd' -cf ~/praks2/backup/test.tar.zst -C ~/praks2 src
tar -czf ~/praks2/backup/test.tar.gz -C ~/praks2 src
tar -cJf ~/praks2/backup/test.tar.xz -C ~/praks2 src
ls -lh ~/praks2/backup/
tar -I 'zstd -19 -T0' --exclude-from="$HOME/praks2/src/.backupignore" -cf ~/praks2/backup/src_ign_$(date +%Y%m%d_%H%M%S).tar.zst -C ~/praks2 src
