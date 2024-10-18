#!/bin/bash
# Sauvegarde du répertoire /data vers /mnt/storage
rsync -av --delete /data/ /mnt/storage/
