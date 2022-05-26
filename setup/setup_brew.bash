#!/usr/bin/env bash

set -eu
# source files {{{
source setup/setup_source.bash
# shellcheck disable=SC1091
source utils.bash
# shellcheck disable=SC1091
source os.bash
# shellcheck disable=SC1091
source file.bash
# shellcheck disable=SC1091
source log.bash
# }}}

# 首次安装 homebrew/linuxbrew {{{
os_command_is_installed brew || {
    # linux 安装基础依赖

    os_is_apt && run_as_root apt-get install build-essential os_is_yum &&
      run_as_root yum install make automake gcc gcc-c++ kernel-devel


    # 第一步，安装brew
    export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"
    export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
    export HOMEBREW_BOTTLE_DOMAIN="https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles"

    read -n1 -p "install homebrew/linuxbrew from tsinghua mirror [Y/N]" by_mirror
    case $by_mirror in
    Y|y)
        git clone --depth=1 https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/install.git /tmp/brew-install
        /bin/bash /tmp/brew-install/install.sh
        rm -rf /tmp/brew-install
        ;;
    N|n)
        # 或者直接使用官方的脚本安装
        command -v brew >/dev/null 2>&1 || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        ;;
    *)
        log_error fail install homebrew/linuxbrew
        ;;
    esac
}
#}}}

# 首次安装之后，将 brew 程序的相关路径加入到环境变量中 {{{
os_command_is_installed brew && {
    # 将 homebrew、linuxbrew、库、二进制包的安装源设置
    os_is_linux && eval "$(~/.linuxbrew/bin/brew shellenv)"
    os_is_darwin && eval "$(~/.homebrew/bin/brew shellenv)"

    _eval="eval \"\$($(brew --prefix)/bin/brew shellenv)\""
    eval "$_eval"
    _eval_brew_git='export HOMEBREW_BREW_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git"'
    eval "$_eval_brew_git"
    _eval_core_git='export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"'
    eval "$_eval_core_git"

    for filepath in ~/.bashrc ~/.zshrc; do
    test -r "$filepath" \
        && file_add_text "$_eval" "$filepath" \
        && file_add_text "$_eval_brew_git" "$filepath" \
        && file_add_text "$_eval_core_git" "$filepath"
    done

    # 更新homebrew、linuxbrew程序
    # linux
    os_is_linux && {
        export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
        brew tap --custom-remote --force-auto-update homebrew/core https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git
        brew tap --custom-remote --force-auto-update homebrew/command-not-found https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-command-not-found.git
        brew update
    }
    # mac
    os_is_darwin && {
        export HOMEBREW_CORE_GIT_REMOTE="https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git"
        for tap in core cask{,-fonts,-drivers,-versions} command-not-found; do
            brew tap --custom-remote --force-auto-update "homebrew/${tap}" "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-${tap}.git"
        done
        brew update
    }

    # 使用tsinghua 源来替换homebrew的二进制库
    _eval_bottles="export HOMEBREW_BOTTLE_DOMAIN=\"https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles\""
    eval "$_eval_bottles"
    for filepath in ~/.bashrc ~/.zshrc ; do
    test -f "$filepath" && file_add_text "$_eval_bottles" "$filepath"
    done

    # 推荐
    brew install gcc
}
#}}}
