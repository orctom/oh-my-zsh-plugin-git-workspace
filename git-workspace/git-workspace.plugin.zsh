function ws() {
    for file in $(ls); do
        if [ -d $file ]
        then
            cd $file
            _git_info $file
            cd ..
        else
            echo "$file"
        fi
    done
}

function _git_info() {
    if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
        echo -n " $fg[white]$1"
        _print_spaces $1
        dirty=$(parse_git_dirty)
        if [[ $dirty == $ZSH_THEME_GIT_PROMPT_DIRTY ]]; then
            echo -n "$fg[black]$bg[blue]$SEGMENT_SEPARATOR"
            echo -n "$fg[white]$bg[blue] $1 $fg[blue]$bg[white]$SEGMENT_SEPARATOR"
            echo -n "$fg[blue]$bg[white]"
        else
            echo -n "$fg[black]$bg[green]$SEGMENT_SEPARATOR"
        fi
        echo -n "$(git_prompt_info)$(git_prompt_status)"
        if [[ $dirty == $ZSH_THEME_GIT_PROMPT_DIRTY ]]; then
            echo "  $fg[white]$bg[black]$SEGMENT_SEPARATOR"
        else
            echo "  $fg[green]$bg[black]$SEGMENT_SEPARATOR"
        fi
    else
        echo " $fg[blue]$1"
    fi
}

function _print_spaces() {
    local len=$1
    ((len = 50 - ${#len}))

    local spacing=""
    for i in {1..$len}; do
        spacing="${spacing} "
    done
    echo -n $fg[white]$spacing
}