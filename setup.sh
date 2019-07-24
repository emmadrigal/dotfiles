#!/bin/bash

PWD=$(pwd)

#Remove old files
rm ~/.emacs
rm ~/.bashrc

#Link new files
ln -s $PWD/.emacs ~/.emacs
ln -s $PWD/.bashrc ~/.bashrc
ls -s $PWD/bin ~/bin
