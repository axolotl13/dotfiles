function __fzf_search_history --description "Search command history. Replace the command line with the selected command."
  set -l FZF_HISTORY_TIME_FORMAT "%m-%d %H:%M:%S"
  set -l TIME_PREFIX_REGEX '^.*? │ '

  set -l HISTORY history --null --show-time="$FZF_HISTORY_TIME_FORMAT │ "
  set -l FZF_PREVIEW "string replace --regex '$TIME_PREFIX_REGEX' '' -- {} | fish_indent --ansi"

  type -q xclip;
  and set -l CLIP "xclip -sel clip"

  # --bind "del:execute(history delete %q {})" \
  # -e +m --tiebreak=index --sort \
  set -l FZF_OPTS --style minimal --height 50% --layout=reverse \
    --print0 --read0  \
    --scheme "history" \
    --bind "ctrl-d:preview-down" \
    --bind "ctrl-u:preview-up" \
    --preview $FZF_PREVIEW \
    --preview-window "bottom:3:wrap" \
    --bind "ctrl-y:execute(printf {} | $CLIP)+bell+cancel+cancel" \
    --footer "[󰌑] [c+y]  copy"

  set -l TOKEN (commandline --current-token)
  set --prepend FZF_OPTS --prompt=" History> " --query="$TOKEN"

  set -l RESULT (builtin $HISTORY | fzf $FZF_OPTS | string split0 | string replace --regex $TIME_PREFIX_REGEX '')

  if test $status -eq 0
    commandline --replace -- $RESULT
  end

  commandline --function repaint
end
