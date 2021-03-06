ws() {
    for file in $(ls); do
        if [ -d $file ]
        then
            (cd $file; _git_info $file)
        else
            echo "  $fg[white]$file"
        fi
    done
}

_git_info() {
    local dirty
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        echo -n "  $fg[white]$1/"
        _print_spaces $1
        dirty=$(parse_git_dirty)
        if [[ $dirty == $ZSH_THEME_GIT_PROMPT_DIRTY ]]; then
            echo -n "$fg[white]$bg[black] git $fg[black]$bg[blue]$SEGMENT_SEPARATOR"
            echo -n "$fg[white]$bg[blue] $1 $fg[blue]$bg[white]$SEGMENT_SEPARATOR"
            echo -n "$fg[black]$bg[white]"
        else
            echo -n "$fg[white]$bg[black] git $fg[black]$bg[green]$SEGMENT_SEPARATOR"
        fi
        echo -n `print -P -- "$(git_prompt_info)$(git_prompt_status)"`
        if [[ $dirty == $ZSH_THEME_GIT_PROMPT_DIRTY ]]; then
            print -P -- "  $fg[white]$bg[default]$SEGMENT_SEPARATOR%{$reset_color%}"
        else
            print -P -- "  $fg[green]$bg[default]$SEGMENT_SEPARATOR%{$reset_color%}"
        fi
        
    else
        echo "  $fg[blue]$1/"
    fi
}

_print_spaces() {
    local len=$1
    ((len = 50 - ${#len}))

    local spacing=""
    for i in {1..$len}; do
        spacing="${spacing}\U0020"
    done
    echo -n $fg[white]$spacing
}