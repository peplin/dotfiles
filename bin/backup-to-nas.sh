#!/usr/bin/env bash

set -ex

TARGET_HOSTNAME=pentagon-backup

SYSTEM_DIRS=(
    "/etc/"
)

SYSTEM_EXCLUDES="""
- audit
- ca-certificates
- cni
- credstore*
- crypttab
- docker
- libaudit.conf
- libvirt
- *.lock
- named.conf
- pacman.d/gnupg
- polkit-1
- samba
- *shadow*
- ssh/ssh_host*
- ssl
- sudoers*
- useradd
- vpnc
- wireguard
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
- .1password/
- .config/BraveSoftware/Brave-Browser/NativeMessagingHosts/com.1password.1password.json
- .config/Cadence
- .config/chromium/NativeMessagingHosts/com.1password.1password.json
- .config/dconf/
- .config/dconf/user
- .config/ghb/EncodeLogs
- .config/google-chrome
- .config/google-chrome-beta
- .config/google-chrome-unstable
- .config/menus
- .config/microsoft-edge-dev
- .config/Signal
- .config/Slack
- .config/syncthing
- .config/vivaldi
- .config/vivaldi-snapshot
- .config/xfce4
- .config/xfce4
- .dotfiles/vim/vim.symlink/bundle
- .dotfiles/xmonad/xmonad.symlink/*.errors
- .dotfiles/xmonad/xmonad.symlink/*.o
- .dotfiles/xmonad/xmonad.symlink/prompt-history
- .dotfiles/xmonad/xmonad.symlink/xmonad-x86_64-linux
- downloads
- .dvdcss
- .fzf
- .gem
- .getmail
- go
- .gnome
- .java
- .keychain
- .local
- .log
- .MakeMKV
- .mozilla
- .mpd
- .nodenv
- .npm
- .nv
- .nvm
- *.o
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
