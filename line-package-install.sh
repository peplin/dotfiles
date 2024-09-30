#!/usr/bin/env bash
set -ex
# install yay manually from Arch AUR
INSTALL_CMD="yay --noconfirm -S"

function install_packages {
    packages="$@"
    for PKG in ${packages[@]}; do
        $INSTALL_CMD $PKG
    done
}

BASE_PACKAGES=(
base-devel
shellcheck
tailscale
wget
grub
inetutils
go
rbenv
ruby-build
ncdu
tmux
vim
rxvt-unicode
ripgrep
fd-find
the_silver_searcher
zsh
git
htop
btop
dstat
smartmontools
unzip
lsof
nmap
rsync
sudo
openssh
readline
fzf
iotop
iftop
openssl
hunspell
)

DEVELOPMENT_MACHINE=(
perl-term-readkey
flake8
gdb
bat
python
python-pip
)

AUDIO_PACKAGES=(
pavucontrol
pipewire-pulse
wireplumber
playerctl
pasystray
flac
alsa-tools alsa-utils reaper-bin realtime
)

BACKUP_PACKAGES=(
getmail6
msmtp
)

WINDOWS_DUAL_BOOT_PACKAGES=(
ntfs-3g # for NTFS write support
ntfs-3g-system-compression
)

BASE_GUI_PACKAGES=(
# screenshots
maim

#xorg
xorg-server
xorg-xinit
xorg-xsetroot
xorg-xmodmap
xorg-fonts-misc
mesa
libtool
xf86-input-synaptics
xclip
acpi

# fonts
cairo
freetype2
fontconfig
ttf-ubuntu-font-family
powerline-fonts
ttf-dejavu
noto-fonts-emoji
# Mandarin font
wqy-zenhei

# Xmonad

xmonad
xmobar
gmrun
xmonad-contrib
libnotify
lxsession
dunst
dmenu
xss-lock
slock
trayer
lxappearance

# May only be required on ubuntu, this makes select+paste from urxvt work like
# you would expect, no middle mouse nonsense
xsel

# apps
thunar
thunar-volman
thunar-archive-plugin
xarchiver
gvfs
tumbler # for thumbnails
google-chrome
rxvt-unicode-256color
urxvt-perls
urxvt-vtwheel
urxvt-font-size-git
syncthing
pwgen
gparted
)

FULL_GUI_PACKAGES=(
#compositing and screen recordings
peek
gifski
picom
arc-gtk-theme

vlc

gnucash
libdbi-drivers # for gnucash sqlite backend
)


LAPTOP_PACKAGES=(
light
)

DESKTOP_PACKAGES=(
# scanner
simple-scan
iscan
iscan-plugin-gt-x820

libdvdcss

easytag
abcde
whipper
)

install_packages "${BASE_PACKAGES[@]}"
if [[ $HOSTNAME == "tangent" ]]; then
    install_packages "${AUDIO_PACKAGES[@]}"
    install_packages "${BASE_GUI_PACKAGES[@]}"
    install_packages "${WINDOWS_DUAL_BOOT_PACKAGES[@]}"
    install_packages "${DEVELOPMENT_MACHINE[@]}"
    install_packages "${FULL_GUI_PACKAGES[@]}"
elif [[ $HOSTNAME == "curve" ]]; then
    install_packages "${AUDIO_PACKAGES[@]}"
    install_packages "${BASE_GUI_PACKAGES[@]}"
    install_packages "${DEVELOPMENT_MACHINE[@]}"
    install_packages "${BACKUP_PACKAGES[@]}"
    install_packages "${WINDOWS_DUAL_BOOT_PACKAGES[@]}"
    install_packages "${FULL_GUI_PACKAGES[@]}"
    install_packages "${DESKTOP_PACKAGES[@]}"
fi

# Reminders of system services to enable
#systemctl enable NetworkManager (tangent only)
#systemctl enable systemd-networkd (curve only)
#systemctl enable systemd-resolved
#systemctl enable systemd-timesyncd
#systemctl enable cupsd
#systemctl enable pipewire
#systemctl enable --user dunst
#
## disable password authentication
#systemctl enable sshd
# /etc/modprobe.d/nobeep.conf -> blacklist pcspkr

# Ubuntu specific packages
#
# libdbd-sqlite3 # for sqlite3 on ubuntu
# libterm-readkey-perl
# rxvt-unicode-256color
# isort
# black
# mypy
# pip install autoflake ipython
