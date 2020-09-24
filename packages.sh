#!/usr/bin/env bash

echo "Installing dotfiles..."

DIR=$PWD

read -p "Install git? " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]];
then
    sudo apt-get install git
fi

read -p "Install vim? " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]];
then
    sudo apt-get install vim
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi

read -p "Install python? " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]];
then
    sudo apt-get install python3 python3-pip python3-venv
fi

read -p "Install macro? " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]];
then
    sudo wget -qcO /usr/local/bin/macro https://raw.githubusercontent.com/cuamckuu/macro/venv-fix/macro
fi

read -p "Install nnn? " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]];
then
    sudo apt-get install nnn
fi

read -p "Install moreutils? " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]];
then
    sudo apt-get install moreutils
fi

echo "Installation complete! Relogin please"
