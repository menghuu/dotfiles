#!/usr/bin/env bash

# shellcheck disable=SC1091
source ./setup/setup_source.bash

brew install neovim || {
    # 假设是linux吧，只在ubuntu(wsl2)中测试过
    neovim_url="https://github.com/neovim/neovim/releases/latest/download/nvim.appimage" &&
        curl -L -s $neovim_url -o nvim.appimage &&
        install -m 0755 nvim.appimage $HOME/.local/bin/nvim
}

curl -fLo nvim/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim



cd nvim/.config/nvim
make clean && make install
