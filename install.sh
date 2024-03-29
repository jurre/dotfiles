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
mkdir -p "$HOME/.config/nvim/"
ln -s "$(pwd)/nvim/init.vim" "$HOME/.config/nvim/init.vim"
git submodule update --init
curl -fLo "$HOME/.local/share/nvim/site/autoload/plug.vim" --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/68488fd7a388d31704643a3257eb97920bcdd54a/plug.vim
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
