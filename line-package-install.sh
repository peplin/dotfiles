INSTALL_CMD="pacaur --noconfirm -S"

# Desktop

function install_packages(pkgs) {
    for $PKG in $pkgs; do
        $INSTALL_CMD $PKG
    done
}

PACKAGES=(
    xclip
    pwgen
    ncmpcpp
    mpc
    irsii
    ncdu
    iotop
    iftop
    evince
    vpnc
    gnucash
    gparted
    preload
    trayer
    keychain
    pm-utils
    acpi
    gnome-themes-standard
    lxappearance
    gtk3
    wireshark-gtk
    readline
    openssl
    libxslt
    libxml2
    sqlite
    gnumeric
    libreoffice
    hunspell
    hunspell-en
    librsvg
    android-udev
    vim
    dropbox
    dropbox-cli
    rxvt-unicode
    urxvt-perls
    urxvt-vtwheel
    urxvt-font-size-git
)

install_packages($PACKAGES)

# audio

PACKAGES=(pulseaudio
pavucontrol
pulseaudio-alsa
flac
lame)

# backup

$INSTALL_CMD getmail

# printing

libcups
cups
cups-filters
ghostscript
gsfonts
avahi

systemctl enable cupsd
systemctl enable avahi-daemon

# fonts

cairo-ubuntu
freetype2-ubuntu
fontconfig-ubuntu
ttf-ubuntu-font-family
ttf-ubuntu-mono-powerline-git
ttf-dejavu

# Xmonad

xmonad
xmobar
gmrun
xmonad-contrib
libnotify
dunst
dmenu-xft
gnome-themes-standard
xautolock
slock

# Xorg

xorg-server
xorg-xinit
xorg-utils
xorg-server-utils
xorg-xsetroot
xorg-xmodmap
mesa
xf86-input-keyboard
xf86-input-mouse
libtool
xf86-input-synaptics
xclip

# Base

grub

openssh
systemctl enable sshd

sshguard
systemctl enable sshbuard

screen
zsh
python
python-pip
python2
python2-pip
ruby
openjdk6
ack
ln -fs /usr/lib/jvm/java-6-openjdk /usr/lib/jvm/default-java
htop
dstat
smartmontools
ethtool
unzip
autoconf
automake
lsof
wol
screen-profiles
glances

git
perl-term-readkey

postfix
rsync
sudo

ntp
systemctl enable ntp

# arch

inetutils
fakeroot
dnsutils
cdrkit
nmap
keychain

# media

gstreamer0.10-base-plugins
gstreamer0.10-ffmpeg gstreamer0.10-good-plugins
gstreamer0.10-ugly-plugins
vlc
morituri
alsa-utils

libdvdcss

google-chrome
virtualbox
firefox

zlib

# mpd

mpd
mpdscribble

systemctl enable mpd
systemctl enable mpdscribble


#nfs

# TODO only line
#nfs-kernel-server
nfs-utils
rpcbind
systemctl enable nfs-common
systemctl enable portmap
systemctl enable nfs-server

# samba

samba

# asterisk

asterisk
systemctl enable asterisk

cbatticon
wpa_actiond
thunar
gthumb
google-talkplugin
gdb
valgrind
picocom
vlc
vim

# add startup service to run --auto-tune
powertop
