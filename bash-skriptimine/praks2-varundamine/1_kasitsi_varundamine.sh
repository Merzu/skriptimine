#!/bin/bash
sudo mkdir -p /home_bcp
ls -ld /home_bcp
cd /home
kuupaev=$(date +'%d.%m.%Y')
sudo tar -cf "user.${kuupaev}.tar" user/
sudo gzip "user.${kuupaev}.tar"
sudo mv "user.${kuupaev}.tar.gz" /home_bcp/
ls -lh /home_bcp/
tar -tzf /home_bcp/user.${kuupaev}.tar.gz | head -n 10
