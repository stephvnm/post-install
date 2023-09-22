#!/bin/bash

sudo apt install network-manager network-manager-gnome --no-install-recommends 

sudo apt install dialog mtools dosfstools gvfs gvfs-backends
sudo apt install policykit-1-gnome 

sudo apt install pulseaudio alsa-utils pavucontrol volumeicon-alsa --no-install-recommends --no-install-suggests 

sudo apt install fonts-recommended fonts-roboto 

cd
mkdir -pv .icons
cd ~/Downloads
wget -cO- https://github.com/phisch/phinger-cursors/releases/latest/download/phinger-cursors-variants.tar.bz2 | tar xfj - -C ~/.icons

sudo apt install feh rofi qimgv thunar thunar-volman thunar-archive-plugin xarchiver micro neofetch lxappearance dunst libnotify-bin numlockx mpv inkscape zip unzip --no-install-recommends