#!/usr/bin/env bash

top() {
  local -r SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]-$0}")" && pwd)"
  PATH="$SCRIPT_DIR/../shell/.local/lib/bash:$PATH"

  # shellcheck disable=SC1091
  source os.bash
  # shellcheck disable=SC1091
  source utils.bash
}

top

read -r -n1 -p "prefer apt-get install with root [Y/N]" apt_with_root
case "$apt_with_root" in
Y | y)
  { sudo -s sh -c "exit"; } && apt_with_root=true
  ;;
N | n)
  apt_with_root=false
  ;;
esac

install_package() {
  # apt-get > brew > conda
  local -r bin="$1"
  local -r package_names="${2:-$1}"

  os_command_is_installed "$bin" ||
    {
      $apt_with_root && sudo apt install "$package_names" ||
        os_command_is_installed brew && brew install "$package_names" ||
        os_command_is_installed conda && conda install "$package_names"
    }
}

add_by_ghq() {
  [[ $# -lt 1 ]] && return 1
  repo=$1
  ghq get --shallow -p -u "$repo"
  repo_local_path=$(ghq list --full-path "$repo" 2>/dev/null)
  echo "$repo" install into "$repo_local_path"
}
