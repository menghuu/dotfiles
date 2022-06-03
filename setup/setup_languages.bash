#!/usr/bin/env bash
# 配置各种编程语言
# 配置各种编程语言的 lsp，尽量全局安装，
# 一些情况下，vim 的 lsp plugin 可能会有自动安装 lsp-server 的功能，但是有可能安装到虚拟环境中

# shellcheck disable=SC1091
source ./setup/setup_source.bash

function npm_install() {
  os_command_is_installed cnpm && cnpm install --location=global --force "$@" || {
    os_command_is_installed npm && npm install --location=global --force "$@"
  }
}

# setup typescript
npm_install typescript

# setup some python language server and linter/formatter
_packages="pyright python-lsp-server[all] jedi-language-server autopep8 pylint flake8 black yapf isort"
os_command_is_installed pipx && {
  for package in $_packages; do
    pipx install $package
  done
} || os_command_is_installed pip && {
  pip install $_packages
}

# for python and docker
npm_install pyright dockerfile-language-server-nodejs markdownlint markdownlint-cli markdownlint-cli2 \
  htmlhint prettier sql-formatter node-sql-parser vim-language-server stylelint-lsp

# for go
go install golang.org/x/tools/gopls@latest

# A shell parser, formatter, and interpreter. Supports POSIX Shell, Bash, and mksh. Requires Go 1.17 or later.
brew install shfmt lua-language-server stylua
