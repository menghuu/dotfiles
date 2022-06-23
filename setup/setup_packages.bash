#!/usr/bin/env bash

# shellcheck disable=SC1091
source ./setup/setup_source.bash

# misc
install_package jq
install_package direnv
install_package unzip
install_package vim
install_package nvim neovim
install_package pipx
install_package shellcheck
install_package fdfind fd-find || brew install fd
install_package ag ripgrep || brew install ripgrep
install_package go
install_package tig

os_command_is_installed delta || brew install delta
os_command_is_installed cheat || brew install cheat
os_command_is_installed bat || brew install bat

os_command_is_installed trash || os_command_is_installed pipx && pipx install trash-cli || brew install trash-cli

# install nodejs and npm
# should install before stow! 因为通过非brew安装nodejs的时候，可能会往 ~/.local/lib 中放入一些东西
os_command_is_installed brew && {
  brew install node
} || {
  curl -sL install-node.vercel.app/lts | bash -s -- --prefix=$HOME/.local --verbose
  export PATH="$HOME/.local/bin:$PATH"
  curl -qL https://www.npmjs.com/install.sh | sh
  curl --compressed -o- -L https://yarnpkg.com/install.sh | bash
}

# stow
install_package stow
command stow -t ~ main shell nvim git

# u-ctags and global(gtags)
install_package ctags
install_package global

install_package fzf
# new shortcut `ctrl-g` to jump to positions which made by `mark` command (backend by fzf)
add_by_ghq urbainvaes/fzf-marks

# tmux
install_package tmux
# tpm
os_command_is_installed tmux && {
  mkdir -p ~/.tmux/plugins && rm -fr ~/.tmux/plugins/tpm &&
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
}

# ghq
os_command_is_installed ghq ||
  brew install ghq ||
  conda install -c conda-forge go-ghq ||
  (cd /tmp && git clone https://github.com/x-motemen/ghq && make install)

# lazygit
os_command_is_installed lazygit ||
  brew install jesseduffield/lazygit/lazygit || brew install lazygit ||
  conda install -c conda-forge lazygit ||
  pretty_print "没有成功安装lazygit"

# https://github.com/sharkdp/vivid
# set ls color theme
brew install vivid

# pre-commit
os_command_is_installed pre-commit || {
  os_command_is_installed pipx && pipx install pre-commit ||
    os_command_is_installed brew && brew install pre-commit ||
    os_command_is_installed conda && conda install -c conda-forge pre-commit
} || pretty_print "没有成功安装pre-commit"

# editorconfig-checker maybe not-useful
os_command_is_installed ec || {
  os_command_is_installed pipx && pipx install editorconfig-checker
}

# fd with as-tree
install_package fd fd-find || brew install fd || pretty_print "未能成功安装fd"
os_command_is_installed as-tree || brew install as-tree || pretty_print "参考 https://github.com/jez/as-tree 来使用二进制安装"

# lua and z.lua
install_package lua lua5.3 && ghq get --shallow -p skywind3000/z.lua
install_package luarocks

# oh-my-posh
{
  os_command_is_installed brew && brew install jandedobbeleer/oh-my-posh/oh-my-posh ||
    mkdir -p ~/.local/bin/ &&
    wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O ~/.local/bin/oh-my-posh &&
    chmod +x ~/.local/bin/oh-my-posh
} && {
  mkdir ~/.poshthemes
  wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/themes.zip -O ~/.poshthemes/themes.zip
  unzip ~/.poshthemes/themes.zip -d ~/.poshthemes
  chmod u+rw ~/.poshthemes/*.json
  rm ~/.poshthemes/themes.zip
}

# v2fly
# [[ -n "$WSL_DISTRO_NAME" ]] && os_command_is_installed brew && brew install v2ray

# bashit
# use some source not whole
add_by_ghq Bash-it/bash-it

# tmux bash completion
add_by_ghq imomaliev/tmux-bash-completion
