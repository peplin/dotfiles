#!/usr/bin/env bash

set -ex


# Wait for me to log in and unlock my keychain
for i in 1 2 3 4 5; do
eval $(keychain --eval --agents ssh -Q --quiet id_rsa) && break || sleep 30
done

TARGET_HOSTNAME=192.168.1.105

SYSTEM_DIRS=(
    "/etc"
)

SYSTEM_EXCLUDES="""
- ssl
- ca-certificates
- ssh/ssh_host*
- vpnc
- wireguard
- libvirt
- *shadow*
- sudoers*
- samba
- cni
- audit
- pacman.d/gnupg
- polkit-1
- docker
- named.conf
- crypttab
- useradd
- libaudit.conf
- *.lock
"""

HOME_DIRS=(
    "/home/peplin"
)

HOME_EXCLUDES="""
- .config/google-chrome
- .config/Signal
- .config/aacs
- .config/syncthing
- .local
- .cache
- .cargo
- .dvdcss
- .npm
- .gem
- .bundle
- .java
- .nv
- go
- downloads
- .tox
- .__pycache__
- .cddb
- .aqbanking
- .vimswap
- .vimundo
"""

AUDIO_PRODUCTION_ACTIVE=(
    "/mnt/windows-system/Scratch/Audio Active"
    "/mnt/windows-system/Scratch/Audio Incoming"
)

PHOTOS_ACTIVE=(
    "/mnt/windows-system/Scratch/Pictures"
    "/mnt/windows-system/Scratch/Incoming"
    "/mnt/windows-system/Scratch/LightroomCatalog"
)

PHOTOS_EXCLUDES="""
- *Previews.lrdata
- *Sync.lrdata
- *Helper.lrdata
"""

echo "Backing up home..."
echo "$HOME_EXCLUDES" | rsync -av --delete --exclude-from=- --chmod=ugo=rwX \
    "${HOME_DIRS[@]}" \
    $TARGET_HOSTNAME:/volume1/system-backup/curve/home/

echo "Backing up system config..."
echo "$SYSTEM_EXCLUDES" | rsync -av --delete --exclude-from=- --chmod=ugo=rwX \
    "${SYSTEM_DIRS[@]}" \
    $TARGET_HOSTNAME:/volume1/system-backup/curve/etc/

echo "Backing up active audio production..."
rsync -av --delete --chmod=ugo=rwX \
    "${AUDIO_PRODUCTION_ACTIVE[@]}" \
    $TARGET_HOSTNAME:/volume1/audio-production-active-backup/

echo "Backing up active photos..."
echo "$PHOTOS_EXCLUDES" | rsync -av --delete --exclude-from=- --chmod=ugo=rwX \
    "${PHOTOS_ACTIVE[@]}"  \
    $TARGET_HOSTNAME:/volume1/photos-active-backup/
