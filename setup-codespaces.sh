#!/bin/bash

# remove existing files
rm -f "$HOME/.zshrc"
rm -f "$HOME/.gitconfig"

PACKAGES_NEEDED="\
  tmux \
  grc \
  shellcheck \
  zsh-autosuggestions \
  fuse \
  npm \
  rubocop \
  fzf \
  fasd \
  ruby-dev \
  silversearcher-ag \
  bat \
  libfuse2"

if ! dpkg -s "${PACKAGES_NEEDED}" > /dev/null 2>&1; then
  sudo apt-get update --fix-missing
  sudo apt-get -y -q install "${PACKAGES_NEEDED}" --fix-missing
fi

# install latest neovim
sudo modprobe fuse
sudo groupadd fuse
sudo usermod -a -G fuse "$(whoami)"
wget https://github.com/github/copilot.vim/releases/download/neovim-nightlies/appimage.zip
unzip appimage.zip
sudo chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim
