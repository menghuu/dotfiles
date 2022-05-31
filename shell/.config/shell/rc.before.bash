#!/usr/bin/env bash

# shellcheck disable=SC1091
source "$HOME/.local/lib/bash/utils.bash"

utils_add_path "$HOME/.local/lib/bash"

# shellcheck disable=SC1091
source array.bash
# shellcheck disable=SC1091
source assert.bash
# shellcheck disable=SC1091
source file.bash
# shellcheck disable=SC1091
source log.bash
# shellcheck disable=SC1091
source os.bash
# shellcheck disable=SC1091
source proxy.bash
# shellcheck disable=SC1091
source script.source.bash
# shellcheck disable=SC1091
source string.bash
# shellcheck disable=SC1091
source utils.bash

if ! (utils_is_bash || utils_is_zsh); then
  exit 1
fi

utils_add_path "$HOME/bin"
utils_add_path "$HOME/.local/bin"
utils_add_manpath "$HOME/.local/share/man"
utils_so_dir "$HOME/.bash_completion.d"
