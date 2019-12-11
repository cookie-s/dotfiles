#!/bin/bash

git submodule init
git submodule sync
git submodule update

mkdir -p ~/.vim ~/.vimbackup

ln -s ~/dotfiles/.bashrc \
    ~/dotfiles/.gdbinit \
    ~/dotfiles/.gitconfig \
    ~/dotfiles/.gitignore_global \
    ~/dotfiles/.tmux.conf \
    ~/dotfiles/.vimrc \
    ~/dotfiles/.zshenv \
    ~/dotfiles/.zprofile \
    ~/dotfiles/.zshrc \
    ~/dotfiles/.zlogin \
    ~/dotfiles/.latexmkrc \
    ~/dotfiles/.Xresources \
    ~/dotfiles/.xprofile \
    ~/dotfiles/.gemrc \
    ~
mkdir -p ~/.config
ln -s ~/dotfiles/.config/nvim ~/.config
ln -s ~/dotfiles/.vim/indent \
    ~/dotfiles/.vim/syntax \
    ~/dotfiles/.vim/ftplugin \
    ~/dotfiles/.vim/rc \
    ~/.vim/

echo "don't forget to set your GPG key id in .gitconfig!"
