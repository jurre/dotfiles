#!/usr/bin/env bash

exec > >(tee -i $HOME/dotfiles_install.log)
exec 2>&1
set -x

# git
ln -s $(pwd)/gitconfig $HOME/.gitconfig
ln -s $(pwd)/githelpers $HOME/.githelpers
ln -s $(pwd)/gitignore $HOME/.gitignore
ln -s $(pwd)/gitmessage $HOME/.gitmessage

# vim
ln -s $(pwd)/vimrc $HOME/.vimrc
ln -s $(pwd)/vim $HOME/.vim
lb
git submodule update --init
vim +'PlugInstall' +qa

# zsh
ln -s $(pwd)/zsh $HOME/.zsh
ln -s $(pwd)/zshrc $HOME/.zshrc

# ag
ln -s $(pwd)/agignore $HOME/.agignore

# homebrew
if [ "$(uname)" = 'Darwin' ]; then
  if [ -n "$(command -v brew 2> /dev/null)" ]; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/fc8acb0828f89f8aa83162000db1b49de71fa5d8/install.sh)"
  fi
elif [ "$CODESPACES" = "true" ]; then
  if [ -n "$(command -v brew 2> /dev/null)" ]; then
    curl -fsSL https://raw.githubusercontent.com/Homebrew/install/fc8acb0828f89f8aa83162000db1b49de71fa5d8/install.sh -o /tmp/install_homebrew.sh
    /bin/bash < /tmp/install_homebrew.sh
    (echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> "$HOME/.profile"
  fi

  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

brew bundle

if [ ! -z "$CODESPACES" ]; then
  ./setup-codespaces.sh
fi
