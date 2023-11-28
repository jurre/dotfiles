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
  rubocop \
  fzf \
  fasd \
  ruby-dev \
  silversearcher-ag \
  bat \
  libfuse2"

if ! dpkg -s ${PACKAGES_NEEDED} > /dev/null 2>&1; then
  sudo apt-get update --fix-missing
  sudo apt-get -y -q install ${PACKAGES_NEEDED} --fix-missing
fi

# install latest neovim
sudo modprobe fuse
sudo groupadd fuse
sudo usermod -a -G fuse "$(whoami)"
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# install nodenv
git clone https://github.com/nodenv/nodenv.git ~/.nodenv
~/.nodenv/bin/nodenv init
mkdir -p "$(nodenv root)"/plugins
git clone https://github.com/nodenv/node-build.git "$(nodenv root)"/plugins/node-build
nodenv install 16.20.0
nodenv global 16.20.0
