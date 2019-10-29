#!/bin/bash

PWD=$(pwd)

# Miscelanneous packages
sudo apt install cowsay aa bb cmatrix lolcat

#Remove old files
rm ~/.emacs
rm ~/.bashrc

#Link new files
ln -s $PWD/.emacs ~/.emacs
ln -s $PWD/.bashrc ~/.bashrc
ls -s $PWD/bin ~/bin


#Install packages
sudo apt install linuxbrew-wrapper

brew tap cantino/mcfly https://github.com/cantino/mcfly
brew install mcfly
