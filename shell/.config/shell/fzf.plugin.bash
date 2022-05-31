#!/usr/bin/env bash

# shellcheck disable=SC1090
utils_is_bash && [[ -f ~/.fzf.bash ]] && source ~/.fzf.bash
# shellcheck disable=SC1090
utils_is_zsh && [[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

if os_command_is_installed fdfind; then
    export FZF_DEFAULT_COMMAND='fdfind --hidden --follow --type f --exclude .git'
    export FZF_CTRL_T_COMMAND='fdfind --hidden --follow --exclude .git'
    export FZF_ALT_C_COMMAND='fdfind --hidden --follow --exclude .git --type d'
else
    export FZF_DEFAULT_COMMAND='find --type f -L'
    export FZF_CTRL_T_COMMAND='find --L'
    export FZF_CTRL_T_COMMAND='find --L --type d'
fi

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline'
os_command_is_installed bat && {
    export FZF_CTRL_T_OPTS=" --preview='bat --color=always --style=numbers --line-range=:500 {}'"
}


# copy and modify from https://github.com/junegunn/fzf/wiki/Examples#git
# or other sources
os_command_is_installed tmux && {
    # tm - create new tmux session, or switch to existing one. Works from within tmux too. (@bag-man)
    # `tm` will allow you to select your tmux session via fzf.
    # `tm irc` will attach to the irc session (if it exists), else it will create it.

    tm() {
        [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
        if [ "$1" ]; then
            tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s "$1" && tmux $change -t "$1")
            return
        fi
        session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) && tmux $change -t "$session" || echo "No sessions found."
    }
    # specify my default tmux-session name
    alias tmm='tm m'

    # fs [FUZZY PATTERN] - Select selected tmux session
    #   - Bypass fuzzy finder if there's only one match (--select-1)
    #   - Exit if there's no match (--exit-0)
    fs() {
        local session
        session=$(tmux list-sessions -F "#{session_name}" |
            fzf --query="$1" --select-1 --exit-0) &&
            tmux switch-client -t "$session"
    }

    # ftpane - switch pane (@george-b)
    ftpane() {
        local panes current_window current_pane target target_window target_pane
        panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
        current_pane=$(tmux display-message -p '#I:#P')
        current_window=$(tmux display-message -p '#I')

        target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

        target_window=$(echo "$target" | awk 'BEGIN{FS=":|-"} {print$1}')
        target_pane=$(echo "$target" | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

        if [[ $current_window -eq $target_window ]]; then
            tmux select-pane -t "${target_window}"."${target_pane}"
        else
            tmux select-pane -t "${target_window}"."${target_pane}" &&
                tmux select-window -t "$target_window"
        fi
    }

    # In tmux.conf
    # bind-key 0 run "tmux split-window -l 12 'bash -ci ftpane'"
}

# config fzf-marks https://github.com/urbainvaes/fzf-marks
FZF_MARKS_FILE="${HOME}/.cache/fzf-marks" && export FZF_MARKS_FILE
# mkdir -p $(dirname $FZF_MARKS_FILE) && touch $FZF_MARKS_FILE
# ctrl-g 打开 mark 的条目选择列表
fzf_marks_path=$(ghq list -p fzf-marks)
[[ -n $fzf_marks_path ]] && {
    utils_is_bash && source "${fzf_marks_path}/fzf-marks.plugin.bash"
    utils_is_zsh && source "${fzf_marks_path}/fzf-marks.plugin.bash"
}
