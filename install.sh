#!/bin/bash

git submodule init
git submodule sync
git submodule update

ln -s --backup=off \
    ~/dotfiles/.bashrc \
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
ln -s \
    ~/dotfiles/.config/nvim \
    ~/dotfiles/.config/mako \
    ~/dotfiles/.config/zed \
    ~/dotfiles/.config/lazygit \
    ~/dotfiles/.config/starship.toml \
    ~/.config

mkdir -p ~/.vim ~/.vimbackup
ln -s \
    ~/dotfiles/.vim/indent \
    ~/dotfiles/.vim/syntax \
    ~/dotfiles/.vim/ftplugin \
    ~/dotfiles/.vim/rc \
    ~/.vim/

mkdir -p ~/.gnupg
ln -s \
    ~/dotfiles/.gnupg/gpg.conf \
    ~/dotfiles/.gnupg/gpg-agent.conf \
    ~/.gnupg/

mkdir -p ~/.cargo
ln -s \
    ~/dotfiles/.cargo/config.toml \
    ~/.cargo/

mkdir -p ~/.local/bin
ln -s ~/dotfiles/.local/bin/* \
    ~/.local/bin/

echo "Don't forget to set your GPG key id in ~/.gitconfig.local!"
