#!/bin/bash

# remove existing files
rm -f "$HOME/.zshrc"
rm -f "$HOME/.gitconfig"

PACKAGES_NEEDED="\
  shellcheck \
  zsh-autosuggestions \
  rubocop \
  ruby-dev \
  silversearcher-ag"

if ! dpkg -s "${PACKAGES_NEEDED}" > /dev/null 2>&1; then
  sudo apt update --fix-missing
  sudo apt -y -q install ${PACKAGES_NEEDED} --fix-missing
fi

# install latest neovim
wget https://github.com/github/copilot.vim/releases/download/neovim-nightlies/appimage.zip
unzip appimage.zip
sudo chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
