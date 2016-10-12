#!/bin/bash
ln -s dotfiles/.bashrc \
    dotfiles/.gdbinit \
    dotfiles/.gitconfig \
    dotfiles/.tmux.conf \
    dotfiles/.vimrc \
    dotfiles/.zshenv \
    dotfiles/.zshrc \
    dotfiles/ .zlogin \
    ~ -f
