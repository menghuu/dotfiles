#!/usr/bin/env bash

# shellcheck disable=SC1091
source setup/setup_source.bash

install_package tldr
os_command_is_installed duf || brew install duf
os_command_is_installed lsd || brew install lsd
os_command_is_installed broot || brew install broot

os_command_is_installed dust || {
  os_is_linux && brew tap tgotwig/linux-dust && brew install dust
  os_is_darwin && brew install dust
}

# afx
os_command_is_installed afx || {
  if ! { os_command_is_installed go && go install github.com/b4b4r07/afx@latest; }; then
    os_is_darwin && _os=darwin || _os=linux
    _arch=$(os_uname_cpu)

    filename="afx_${_os}_${_arch}.tar.gz"
    filepath="/tmp/${filename}"

    URL="https://github.com/b4b4r07/afx/releases/latest/download/${filename}"
    wget "$URL" -O "$filepath"
    (
      cd "$(dirname "$filepath")" || exit
      tar xvf "$filepath"
      chmod +x afx
      mv afx "$HOME/.local/bin/"
    )
  fi
}
