#!/usr/bin/env bash

# configure z.lua
zlua_path=$(ghq list --full-path z.lua 2>/dev/null)
[[ -n $zlua_path ]] && {

  # enhanced search mode
  # match the last segment of the path
  # cd to the existent path if there is no match
  # Skip the current directory
  export _ZL_MATCH_MODE=1
  # default is adding current directory to database each time before display command prompt
  export _ZL_ADD_ONCE=1
  # jump into dir and echo $PWD
  # export _ZL_ECHO=1

  # export _ZL_DATA="$HOME/.cache/zlua"

  zlua_bin_path="${zlua_path}/z.lua"

  utils_is_bash && eval "$(lua "$zlua_bin_path" --init bash)"
  utils_is_zsh && eval "$(lua "$zlua_bin_path" --init zsh)"

  # cd with interactive selection
  alias zi="z -i"
  # cd with interactive selection using fzf
  alias zf="z -I ."

  # cd to the parent directory starting with foo
  alias zb="z -b"
  # same as zb but with interactive selection
  alias zbi="z -b -i"
  # same as zb but with interactive selection using fzf
  alias zbf="z -b -I"

  # most RECENTLY (not FRECENCY, the default in z.lua)
  alias zt="z -t"
  alias zt.="z -t ."
  # same as zt but with interactive selection using fzf
  alias zh="z -I -t ."
  # goto most RECENTLY (not FRECENCY, the default in z.lua)
  alias z-="z -"
  # show most RECENTLY position list
  alias z--="z --"

  # export FZ_HISTORY_CD_CMD="_zlua" && source ~/.local/bin/fz.sh
}
