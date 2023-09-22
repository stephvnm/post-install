#!/bin/bash

echo
echo "Building dependencies..."
echo

sudo apt build-dep awesome
sudo apt install libxcb-xfixes0-dev librsvg2-dev 

echo
echo "Cloning repo..."
echo
cd ~/Downloads
git clone https://github.com/awesomewm/awesome


echo
echo "Installing..."
echo
cd awesome/
make package
cd build/
sudo apt install ./*.deb

echo
echo "Setting up xsession..."
echo
sudo mkdir -pv /usr/share/xsessions
sudo cp -iv /usr/local/share/xsessions/awesome.desktop /usr/share/xsessions/