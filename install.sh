#!/bin/bash

git submodule init
git submodule sync
git submodule update

mkdir -p ~/.vim ~/.vimbackup

ln -s ~/dotfiles/.bashrc \
    ~/dotfiles/.gdbinit \
    ~/dotfiles/.gitconfig \
    ~/dotfiles/.tmux.conf \
    ~/dotfiles/.vimrc \
    ~/dotfiles/.zshenv \
    ~/dotfiles/.zshrc \
    ~/dotfiles/.zlogin \
    ~
ln -s ~/dotfiles/.vim/indent ~/.vim/
