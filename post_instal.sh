#!/bin/bash

cd ~/Downloads

echo 'Updating system...'
sudo apt update && sudo apt upgrade -y

echo "Installing Google chrome..."
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb 

echo "Installing Alacritty..."
sudo add-apt-repository ppa:aslatter/ppa -y
sudo apt update 
sudo apt install alacritty

echo "Installing fonts..."
sudo apt install ttf-mscorefonts-installer fonts-roboto fonts-inter

echo "Installing Qbittorrent, micro, qimgv, rofi, git ..."
sudo apt install micro qbittorrent qimgv rofi git --no-install-recommends --no-install-suggests

echo "Pulling network driver - https://github.com/Mange/rtl8192eu-linux-driver ..."
git clone https://github.com/Mange/rtl8192eu-linux-driver

# sudo apt-get install linux-headers-generic build-essential dkms
# cd rtl8192eu-linux-driver/
# cd include/
# micro autoconf.h
# sudo dkms add .
# cd ../
# sudo dkms add .
# sudo dkms install rtl8192eu/1.0
# echo "blacklist rtl8xxxu" | sudo tee /etc/modprobe.d/rtl8xxxu.conf
# echo -e "8192eu\n\nloop" | sudo tee /etc/modules
# echo "options 8192eu rtw_power_mgnt=0 rtw_enusbss=0" | sudo tee /etc/modprobe.d/8192eu.conf
# sudo update-grub; sudo update-initramfs -u

echo "Installing picom..."
sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson
sudo apt install  libpcre3-dev python3-pip libxcb-xinerama0-dev
sudo pip3 install meson ninja
git clone https://github.com/jonaburg/picom.git
cd picom/
git submodule update --init --recursive
meson setup --buildtype=release . build
ninja -C build
ninja -C build install

echo "Building DDCUTIL..."
cd ~/Downloads
git clone https://github.com/rockowitz/ddcutil.git -b 1.2.2-release
cd ~/Downloads/ddcutil
echo 'Uncommenting deb-src...'
sudo sed -i '/deb-src/s/^# //' /etc/apt/sources.list && sudo apt update
echo 'Building dependencies...'
sudo apt build-dep ddcutil
./configure 
make
sudo make install
echo 'Installation done! Configuring post-install...'
sudo modprobe i2c-dev
echo "i2c-dev" | sudo tee /etc/modules-load.d/i2c-dev.conf
sudo usermod stephvnm -aG  i2c
sudo cp -iv /usr/share/ddcutil/data/45-ddcutil-i2c.rules /etc/udev/rules.d
sudo chmod a+rw /dev/i2c-*

echo "ALL DONE!"
