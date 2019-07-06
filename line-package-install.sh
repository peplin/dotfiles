INSTALL_CMD="yay -S"

# Desktop

function install_packages(pkgs) {
    for $PKG in $pkgs; do
        $INSTALL_CMD $PKG
    done
}

PACKAGES=(
    pwgen
    ncmpcpp
    mpd
    mpc # for keyboard control
    mpdscribble
    ncdu
    easytag
    abcde
    ntfs-3g # for NTFS write support
    iotop
    iftop
    gnucash
    gparted
    preload
    trayer
    keychain
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
    hunspell
    librsvg
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

PACKAGES=(
pulseaudio
pavucontrol
pulseaudio-alsa
pulseaudio-zeroconf
flac
lame)

# backup

$INSTALL_CMD getmail

# printing

libcups
cups
cups-filters
gtk3-print-backends
ghostscript
gsfonts
avahi

systemctl enable cupsd
systemctl enable avahi-daemon

# fonts

cairo
freetype2
fontconfig
ttf-ubuntu-font-family
powerline-fonts
ttf-dejavu

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

# Xorg

xorg-server
xorg-xinit
xorg-xsetroot
xorg-xmodmap
mesa
xf86-input-keyboard
xf86-input-mouse
libtool
xf86-input-synaptics
xclip

# Base

grub / systemd-boot

openssh
systemctl enable sshd
# disable password authentication

tmux
zsh
python
python-pip
python2
python2-pip
ruby
jre-openjdk-headless
the_silver_searcher
ripgrep
htop
dstat
smartmontools
ethtool
unzip
lsof
wol
glances

git
perl-term-readkey

rsync
sudo

ntp
systemctl enable ntpd

# arch

nmap

# media

vlc

libdvdcss

google-chrome
virtualbox

# mpd

systemctl --user enable mpd
systemctl --user enable mpdscribble

thunar
gdb

#console-tdm

# May only be required on ubuntu, this makes select+paste from urxvt work like
# you would expect, no middle mouse nonsense
xsel

flake8
arc-gtk-theme


cpupower
sudo systemctl enable cpupower
# set to performance on desktop

thermald
sudo systemctl enable thermald

# Laptop only

# add startup service to run --auto-tune
powertop

nm-applet
openvpn-update-resolv-conf
systemctl enable NetworkManager

openconnect

