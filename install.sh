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
    ~/dotfiles/.zprofile \
    ~/dotfiles/.zshrc \
    ~/dotfiles/.zlogin \
    ~/dotfiles/.latexmkrc \
    ~
ln -s ~/dotfiles/.vim/indent ~/.vim/
ln -s ~/dotfiles/.vim/syntax ~/.vim/
