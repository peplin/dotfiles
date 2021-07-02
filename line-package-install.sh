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
wget
grub
go
ncdu
tmux
vim
rxvt-unicode
ripgrep
the_silver_searcher
zsh
ripgrep
git
htop
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
ntfs-3g # for NTFS write support
ntfs-3g-system-compression
openssl
hunspell
keychain
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
pulseaudio
pavucontrol
pulseaudio-alsa
pulseaudio-zeroconf
pasystray
flac
jack2 pulseaudio-jack cadence alsa-tools alsa-utils reaper-bin realtime
)

BACKUP_PACKAGES=(
getmail6
msmtp
)

BASE_GUI_DESKTOP_PACKAGES=(
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
dunst
dmenu
xautolock
slock
trayer
lxappearance

# May only be required on ubuntu, this makes select+paste from urxvt work like
# you would expect, no middle mouse nonsense
xsel

# apps
thunar
tumbler # for thumbnails
google-chrome
urxvt-perls
urxvt-vtwheel
syncthing
pwgen
gparted
)

FULL_DESKTOP_GUI_PACKAGES=(
#compositing and screen recordings
peek
gifski
picom
arc-gtk-theme

vlc
libdvdcss

ncmpcpp
mpd
mpc # for keyboard control
mpdscribble
easytag
abcde

gnucash
libdbi-drivers # for gnucash sqlite backend

# scanner
simple-scan
iscan
iscan-plugin-gt-x820
)

#install_packages "${BASE_PACKAGES[@]}"
if [[ $HOSTNAME == "tangent" ]]; then
    #install_packages "${AUDIO_PACKAGES[@]}"
    install_packages "${BASE_GUI_DESKTOP_PACKAGES[@]}"
elif [[ $HOSTNAME == "curve" ]]; then
    install_packages "${AUDIO_PACKAGES[@]}"
    install_packages "${BASE_GUI_DESKTOP_PACKAGES[@]}"
    install_packages "${DEVELOPMENT_MACHINE[@]}"
    install_packages "${BACKUP_PACKAGES[@]}"
    install_packages "${FULL_DESKTOP_GUI_PACKAGES[@]}"
fi

# Reminders of system services to enable
#systemctl enable NetworkManager
#systemctl enable systemd-networkd
#systemctl enable systemd-resolved
#systemctl enable systemd-timesyncd
#systemctl enable cupsd
#
## disable password authentication
#systemctl enable sshd
#
#systemctl --user enable mpd
#systemctl --user enable mpdscribble
