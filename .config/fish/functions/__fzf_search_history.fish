# =============================================================================
# __fzf_search_history — fuzzy search command history
# =============================================================================
function __fzf_search_history --description "Search command history"
    set -l FZF_HISTORY_TIME_FORMAT "%m-%d %H:%M:%S"
    set -l TIME_PREFIX_REGEX '^.*? │ '

    set -l HISTORY history --null --show-time="$FZF_HISTORY_TIME_FORMAT │ "
    set -l FZF_PREVIEW "string replace --regex '$TIME_PREFIX_REGEX' '' -- {} | fish_indent --ansi"

    type -q xclip; and set -l CLIP "xclip -sel clip"

    # -e +m --tiebreak=index --sort \
    set -l FZF_OPTS \
        --style minimal \
        --height 50% \
        --layout reverse \
        --print0 \
        --read0 \
        --scheme history \
        --bind "ctrl-d:preview-down" \
        --bind "ctrl-u:preview-up" \
        --preview $FZF_PREVIEW \
        --preview-window "bottom:3:wrap" \
        --bind "ctrl-y:execute(printf {} | $CLIP)+bell+abort" \
        $FZF_MENU "󰌑 |  c+y copy"

    set -l TOKEN (commandline --current-token)
    set --prepend FZF_OPTS --prompt=" History> " --query="$TOKEN"
    set -l RESULT (builtin $HISTORY | fzf $FZF_OPTS | string split0 | string replace --regex $TIME_PREFIX_REGEX '')

    test $status -eq 0; and commandline --replace -- $RESULT

    commandline --function repaint
end
