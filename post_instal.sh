#!/bin/bash

cd ~/Downloads

echo
echo 'Updating system...'
echo
sudo apt update && sudo apt upgrade -y

echo
echo "Building Awesome..."
echo
sudo apt build-dep awesome
git clone https://github.com/awesomewm/awesome
cd awesome
make package
cd build
sudo apt install ./*.deb

cd ~/Downloads
echo
echo "Installing Google chrome..."
echo
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt install ./google-chrome-stable_current_amd64.deb 

echo
echo "Installing Alacritty..."
echo
sudo add-apt-repository ppa:aslatter/ppa -y
sudo apt update 
sudo apt install alacritty -y

echo
echo "Installing fonts..."
echo
sudo apt install ttf-mscorefonts-installer fonts-roboto fonts-inter -y

echo
echo "Installing Qbittorrent, micro, qimgv, rofi, git ..."
echo
sudo apt install qbittorrent micro qimgv rofi --no-install-recommends --no-install-suggests -y

echo
echo "Pulling network driver - https://github.com/Mange/rtl8192eu-linux-driver ..."
echo
git clone https://github.com/Mange/rtl8192eu-linux-driver

sudo apt-get install linux-headers-generic build-essential dkms
cd rtl8192eu-linux-driver/
cd include/
micro autoconf.h
sudo dkms add .
cd ../
sudo dkms add .
sudo dkms install rtl8192eu/1.0
echo "blacklist rtl8xxxu" | sudo tee /etc/modprobe.d/rtl8xxxu.conf
echo -e "8192eu\n\nloop" | sudo tee /etc/modules
echo "options 8192eu rtw_power_mgnt=0 rtw_enusbss=0" | sudo tee /etc/modprobe.d/8192eu.conf
sudo update-grub; sudo update-initramfs -u

echo
echo "Installing picom..."
echo
sudo apt install libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-dpms0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl-dev libegl-dev libpcre2-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson
sudo apt install  libpcre3-dev python3-pip libxcb-xinerama0-dev
sudo pip3 install meson ninja
git clone https://github.com/yshui/picom.git
cd picom/
git submodule update --init --recursive
meson setup --buildtype=release . build
ninja -C build
ninja -C build install
echo
echo "Copying config"
echo
mkdir ~/.config/picom
cd ~/Downloads/picom
cp -iv picom.sample.conf ~/.config/picom/picom.conf
cp -iv picom.desktop ~/.config/picom/

echo
echo "Building DDCUTIL..."
echo

cd ~/Downloads
git clone https://github.com/rockowitz/ddcutil.git -b 1.2.2-release
cd ~/Downloads/ddcutil
echo 'Uncommenting deb-src...'
sudo sed -i '/deb-src/s/^# //' /etc/apt/sources.list && sudo apt update

echo
echo 'Building dependencies...'
echo

sudo apt build-dep ddcutil
./configure 
make
sudo make install
echo
echo 'Installation done! Configuring post-install...'
echo
sudo modprobe i2c-dev
echo "i2c-dev" | sudo tee /etc/modules-load.d/i2c-dev.conf
sudo groupadd --system i2c
sudo usermod stephvnm -aG  i2c
sudo cp -iv /usr/local/share/ddcutil/data/45-ddcutil-i2c.rules /etc/udev/rules.d
sudo chmod a+rw /dev/i2c-*

echo
echo "Testing..."
echo
ddcutil detect

echo
echo "ALL DONE!"
echo
