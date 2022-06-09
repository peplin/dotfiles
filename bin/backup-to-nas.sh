#!/usr/bin/env bash

set -ex


# Wait for me to log in and unlock my keychain
for i in 1 2 3 4 5; do
eval $(keychain --eval --agents ssh -Q --quiet id_rsa) && break || sleep 30
done

TARGET_HOSTNAME=192.168.1.105

SYSTEM_DIRS=(
    "/etc/"
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
- .aqbanking
- .bundle
- .cache
- .cargo
- .cddb
- .config/1Password
- .config/aacs
- .config/Cadence
- .config/ghb/EncodeLogs
- .config/google-chrome
- .config/Signal
- .config/Slack
- .config/syncthing
- dev/atob
- .dotfiles/vim/vim.symlink/bundle
- .dotfiles/xmonad/xmonad.symlink/prompt-history
- .dotfiles/xmonad/xmonad.symlink/xmonad-x86_64-linux
- .dotfiles/xmonad/xmonad.symlink/*.errors
- .dotfiles/xmonad/xmonad.symlink/*.o
- downloads
- .dvdcss
- .gem
- .getmail
- go
- .java
- .keychain
- .local
- .log
- .mpd
- .nodenv
- .nvm
- .npm
- .nv
- .pnpm-store
- .pulse
- .__pycache__
- .pyenv
- .rbenv
- .ssh/ssh_auth_sock
- .steam
- .terraform
- .thunderbird
- *tmp/*
- .tox
- .viminfo
- .vimswap
- .vimundo
- .zcalc_history
- .zoom
- .zsh_history
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
echo "$HOME_EXCLUDES" | rsync -av --delete --delete-excluded --exclude-from=- --chmod=ugo=rwX \
    "${HOME_DIRS[@]}" \
    $TARGET_HOSTNAME:/volume2/system-backup/curve/home/

echo "Backing up system config..."
echo "$SYSTEM_EXCLUDES" | rsync -av --delete --delete-excluded --exclude-from=- --chmod=ugo=rwX \
    "${SYSTEM_DIRS[@]}" \
    $TARGET_HOSTNAME:/volume2/system-backup/curve/etc/

echo "Backing up active audio production..."
rsync -av --delete --delete-excluded --chmod=ugo=rwX \
    "${AUDIO_PRODUCTION_ACTIVE[@]}" \
    $TARGET_HOSTNAME:/volume2/audio-production-active-backup/

echo "Backing up active photos..."
echo "$PHOTOS_EXCLUDES" | rsync -av --delete --delete-excluded --exclude-from=- --chmod=ugo=rwX \
    "${PHOTOS_ACTIVE[@]}"  \
    $TARGET_HOSTNAME:/volume2/photos-active-backup/
