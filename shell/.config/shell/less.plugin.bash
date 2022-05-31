#!/usr/bin/env bash

# better pager
os_command_is_installed less && {
  # 颜色 0黑色 1红色 2绿色 3黄色 4蓝色 5紫色 6青色（蓝绿） 7白色
  # 对应于这个链接中的regular color https://gist.github.com/JBlond/2fea43a3049b38287e5e9cefc87b2124
  # setaf 前景 frontground-color
  # setbf 背景 background-color

  # https://www.man7.org/linux/man-pages/man5/termcap.5.html
  # https://www.man7.org/linux/man-pages/man5/terminfo.5.html
  # 这两个很有用，下面的内容都是拷贝自这两个里面的
  # 注意: 对于less来说，只有部分的有用

  # 有关于突出显示的 about standout
  # so   Start standout mode
  # enter_standout_mode         smso      so     begin standout mode
  LESS_TERMCAP_so=$(
    tput smso
    tput setab 7
    tput setaf 1
  ) && export LESS_TERMCAP_so
  # se   End standout mode
  # exit_standout_mode          rmso      se     exit standout mode
  LESS_TERMCAP_se=$(
    tput rmso
    tput sgr0 # you must `tput sgr0`` !
  ) && export LESS_TERMCAP_se
  # 有关于下划线的 about underlining
  # us   Start underlining
  # enter_underline_mode        smul      us     begin underline mode
  LESS_TERMCAP_us=$(
    tput smul
    tput setaf 3 #黄色
  ) && export LESS_TERMCAP_us

  # ue   End underlining
  # exit_underline_mode         rmul      ue     exit underline mode
  LESS_TERMCAP_ue=$(
    tput rmul
    tput sgr0
  ) && export LESS_TERMCAP_ue
  # uc   Underline character under cursor and move cursor right
  # underline_char              uc        uc     underline char and move past it
  # this is useless for less, because the vertical line of mouse is not shown in less
  # maybe usefull when you edit with less, but we are now using less as man-pager

  # 有关于 加粗 闪烁 reverse-mode   about blinking bold and reverse-mode
  # mb   Start blinking
  # enter_blink_mode            blink     mb     turn on blinking
  LESS_TERMCAP_mb=$(
    tput blink
    tput setaf 3 # 蓝色
  ) && export LESS_TERMCAP_mb
  # md   Start bold mode
  # enter_bold_mode             bold      md     turn on bold (extra bright) mode
  LESS_TERMCAP_md=$(
    tput bold
    tput setaf 2 # 绿色
  ) && export LESS_TERMCAP_md
  # mr   Start reverse mode
  # enter_reverse_mode          rev       mr     turn on reverse video mode
  # I actually donot know what is reverse-mode
  LESS_TERMCAP_mr=$(tput rev) && export LESS_TERMCAP_mr

  # me   End all mode like so, us, mb, md, and mr
  # exit_attribute_mode         sgr0      me     turn off all attributes
  LESS_TERMCAP_me=$(tput sgr0) && export LESS_TERMCAP_me

  # enter_dim_mode              dim       mh     turn on half-bright mode
  LESS_TERMCAP_mh=$(tput dim) && export LESS_TERMCAP_mh
  # enter_subscript_mode        ssubm     ZN     Enter subscript mode
  LESS_TERMCAP_ZN=$(tput ssubm) && export LESS_TERMCAP_ZN
  # exit_subscript_mode         rsubm     ZV     End subscript mode
  LESS_TERMCAP_ZV=$(tput rsubm) && export LESS_TERMCAP_ZV
  # enter_superscript_mode      ssupm     ZO     Enter superscript mode
  LESS_TERMCAP_ZO=$(tput ssupm) && export LESS_TERMCAP_ZO
  # exit_superscript_mode       rsupm     ZW     End superscript mode
  LESS_TERMCAP_ZW=$(tput rsupm) && export LESS_TERMCAP_ZW

  export PAGER='less --mouse -s -M +Gg'

  # more links
  # https://github.com/Valloric/dotfiles/blob/master/less/LESS_TERMCAP
  # https://en.wikipedia.org/wiki/ANSI_escape_code#8-bit
  # https://unix.stackexchange.com/questions/119/colors-in-man-pages/147#147
  # https://unix.stackexchange.com/questions/108699/documentation-on-less-termcap-variables/108840#108840
}
