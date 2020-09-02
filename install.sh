#!/usr/bin/env bash

echo "Installing dotfiles..."

DIR=$PWD

read -p "Replace ~/.bashrc? " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]];
then
    ln -sf $DIR/.bashrc ~/.bashrc
fi

read -p "Replace ~/.vimrc? " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]];
then
    ln -sf $DIR/.vimrc ~/.vimrc
fi

read -p "Replace ~/.gitconfig? " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]];
then
    ln -sf $DIR/.gitconfig ~/.gitconfig
fi

read -p "Replace ~/.tmux.conf? " -n 1 -r; echo
if [[ $REPLY =~ ^[Yy]$ ]];
then
    ln -sf $DIR/.tmux.conf ~/.tmux.conf
fi

echo "Installation complete! Relogin please"
