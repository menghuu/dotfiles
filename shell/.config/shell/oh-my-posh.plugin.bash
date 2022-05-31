#!/usr/bin/env bash

os_command_is_installed oh-my-posh && {
  posh_theme_file_path="$HOME/.config/shell/poshtheme.json"
  posh_theme_file_path='https://github.com/JanDeDobbeleer/oh-my-posh/blob/main/themes/pure.omp.json'
  posh_theme_file_path="$HOME/.poshthemes/pure.omp.json"

  # As the standard terminal has issues displaying the ANSI characters correctly
  # disable oh-my-posh when running within apple-terminal
  [[ $TERM_PROGRAM != "Apple_Terminal" ]] && {
    eval "$(oh-my-posh init $(oh-my-posh get shell) --config "$posh_theme_file_path")"
  }
}
