#!/usr/bin/env bash

source_plugins() {
  local -r SHELL_CONFIG_DIR="$(cd "$(dirname "${BASH_SOURCE[0]-$0}")" && pwd)"
  for plugin_name in "$@"; do
    filepath="$SHELL_CONFIG_DIR/$plugin_name"
    source "$filepath"
  done
}


source_plugins \
  aliases.bash \
  fzf.plugin.bash \
  oh-my-posh.plugin.bash \
  less.plugin.bash \
  term.plugin.bash \
  tldr.plugin.bash \
  zlua.plugin.bash


# https://unix.stackexchange.com/questions/332791/how-to-permanently-disable-ctrl-s-in-terminal
# disable ctrl-s ctrl-q in bash
[[ -t 0 && $- = *i* ]] && stty -ixon


os_command_is_installed git && {
  alias g="git"
}


os_command_is_installed lazygit && {
  alias lg='lazygit'
}


# fd is alternative find
os_command_is_installed fdfind && alias fd='fdfind'


# config the tmux
os_command_is_installed tmux && {
  alias t='tmux'
}
[[ -n $TMUX ]] && {
  toclip() {
    os_is_wsl2 && tmux save-buffer - | clip.exe
  }
}

# configure default editor
os_command_is_installed vim && export EDITOR=vim && export VISUAL=vim && alias vi='vim' && alias v='vim'
os_command_is_installed nvim && export EDITOR=nvim && export VISUAL=nvim && {
  alias vim='nvim'
  alias vi='nvim'
  alias v='nvim'
  alias nv='nvim'
}

# https://github.com/sharkdp/vivid
# better ls color
os_command_is_installed vivid && LS_COLORS="$(vivid generate snazzy)" && export LS_COLORS

# configure using sources from ghq
os_command_is_installed ghq && {
  bashit_repo_path=$(ghq list --full-path bash-it)
  [[ -n "$bashit_repo_path" ]] && {
    completion_dir_path="${bashit_repo_path}/completion/available"

        # TODO
        # add tmux completion
        # echo $completion_dir_path
        # source "$completion_dir_path/tmux.completion.bash"
        :
      }

      tmux_completion_path=$(ghq list --full-path imomaliev/tmux-bash-completion)
      # shellcheck disable=SC1090
      [[ -n "$tmux_completion_path" ]] &&
        tmux_completion_path="$tmux_completion_path/completions/tmux" && source "$tmux_completion_path"
      }

# wls 中共享 windows 的 ssh-agent 设置，
# 不同的设备中 npiperelay.exe 路径可能不同，但好在我没有这么多的电脑
# https://docs.github.com/cn/developers/overview/using-ssh-agent-forwarding
# 可以配置 ssh-agent 转发，可以在使用 wsl 中的 ssh 登录到其他设备后，然后该设备无需保存 id_rsa 等私钥，直接使用 wsl 中的 ssh-agent 私钥
os_is_wsl2 && {
  export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
  if ! { ss -a | grep -q "$SSH_AUTH_SOCK"; }; then
    rm -f "$SSH_AUTH_SOCK"
    (setsid socat UNIX-LISTEN:"$SSH_AUTH_SOCK",fork EXEC:"/mnt/c/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork &) >/dev/null 2>&1
  fi
} || {
  # copy from https://web.archive.org/web/20210506080335/https://mah.everybody.org/docs/ssh
  SSH_ENV="$HOME/.ssh/environment"
  function start_agent {
    # echo "Initialising new SSH agent..."
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    # echo succeeded
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add;
  }

    # Source SSH settings, if applicable

    if [ -f "${SSH_ENV}" ]; then
      . "${SSH_ENV}" > /dev/null
      #ps ${SSH_AGENT_PID} doesn't work under cywgin
      ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
        start_agent;
      }
    else
      start_agent;
    fi
  }

  os_command_is_installed rg && {
    export RIPGREP_CONFIG_PATH=$HOME/.config/ripgreprc
  }

# configure brew
os_command_is_installed brew && {
  export HOMEBREW_NO_AUTO_UPDATE=1

os_is_darwin && add_path "$(brew --prefix)/opt/coreutils/libexec/gnubin"

utils_is_bash && utils_so "$(brew --prefix)/etc/profile.d/bash_completion.sh"

utils_so "$(brew --prefix)/opt/asdf/libexec/asdf.sh"
utils_so_dir "$(brew --prefix)/etc/bash_completion.d"
}

# configure pipx
os_command_is_installed pipx && {
  # pipx completions
  :
}

# configure go
os_command_is_installed go && {
  export GOPROXY=https://proxy.golang.com.cn,direct
  utils_add_path "$HOME/go/bin"
}

# trash
os_command_is_installed trash && {
  alias rm='trash'
  alias rrm='\rm'
}


# npm
os_command_is_installed npm && {
  alias cnpm="npm --registry=https://registry.npmmirror.com \
  --cache=$HOME/.npm/.cache/cnpm \
  --disturl=https://npmmirror.com/mirrors/node \
  --userconfig=$HOME/.cnpmrc"
}
os_command_is_installed yarn && {
  utils_add_path "$HOME/.yarn/bin" "$HOME/.config/yarn/global/node_modules/.bin"
  export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
}


# ranger
os_command_is_installed ranger && {
  alias rr='\ranger --cmd "set show_hidden=true"'
}
