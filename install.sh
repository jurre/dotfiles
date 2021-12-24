#!/usr/bin/env bash

exec > >(tee -i "$HOME/dotfiles_install.log")
exec 2>&1
set -x

if [ -n "$CODESPACES" ]; then
  ./setup-codespaces.sh
fi

export EDITOR=/usr/local/bin/nvim

# git
ln -s "$(pwd)/gitconfig" "$HOME/.gitconfig"
ln -s "$(pwd)/githelpers" "$HOME/.githelpers"
ln -s "$(pwd)/gitignore" "$HOME/.gitignore"
ln -s "$(pwd)/gitmessage" "$HOME/.gitmessage"

# zsh
ln -s "$(pwd)/zsh" "$HOME/.zsh"
ln -s "$(pwd)/zshrc" "$HOME/.zshrc"
ln -s "$(pwd)/zshenv" "$HOME/.zshenv"

# vim
ln -s "$(pwd)/vimrc" "$HOME/.vimrc"
ln -s "$(pwd)/vim" "$HOME/.vim"
lb
git submodule update --init
nvim +'PlugInstall' +qa

# ag
ln -s "$(pwd)/agignore" "$HOME/.agignore"

if [ -n "$CODESPACES" ]; then
  git config --global url."https://github.com/".insteadOf git@github.com:
else
  git config --global url."git@github.com:".insteadOf https://github.com/
fi

# use zsh
sudo chsh -s "$(which zsh)" "$(whoami)"
