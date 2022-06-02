#!/usr/bin/env bash

# 正确设置 term 变量
# 复制自 https://vim.fandom.com/wiki/256_colors_in_vim
SCREEN_COLORS=$(tput colors)
if [ -z "$SCREEN_COLORS" ]; then
  case "$TERM" in
  screen-*color-bce)
    echo "Unknown terminal $TERM. Falling back to 'screen-bce'."
    export TERM=screen-bce
    ;;
  *-88color)
    echo "Unknown terminal $TERM. Falling back to 'xterm-88color'."
    export TERM=xterm-88color
    ;;
  *-256color)
    echo "Unknown terminal $TERM. Falling back to 'xterm-256color'."
    export TERM=xterm-256color
    export COLORTERM=truecolor # 参考 https://github.com/termstandard/colors
    ;;
  esac
  SCREEN_COLORS=$(tput colors)
fi
if [ -z "$SCREEN_COLORS" ]; then
  case "$TERM" in
  gnome* | xterm* | konsole* | aterm | [Ee]term)
    echo "Unknown terminal $TERM. Falling back to 'xterm'."
    export TERM=xterm
    ;;
  rxvt*)
    echo "Unknown terminal $TERM. Falling back to 'rxvt'."
    export TERM=rxvt
    ;;
  screen*)
    echo "Unknown terminal $TERM. Falling back to 'screen'."
    export TERM=screen
    ;;
  esac
  SCREEN_COLORS=$(tput colors)
fi
