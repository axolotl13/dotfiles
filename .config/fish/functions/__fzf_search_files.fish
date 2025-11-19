function __fzf_search_files --description "Search the current file"
  type -q find; and type -q cat; or return 1

  set -l FIND_CMD find * -type f
  set -l FZF_PREVIEW "cat {}"

  type -q fd; and set FIND_CMD fd --hidden --type f --strip-cwd-prefix --follow --color=always
  type -q bat; and set FZF_PREVIEW "bat --color=always --theme=\"$BAT_THEME\" --style=numbers {}"

  set -l FZF_OPTS --style minimal --height 50% --layout=reverse \
    --multi --ansi \
    --marker "▏" \
    --pointer "█" \
    --preview-window "50%,<50(down,50%,border-top)" \
    --bind "ctrl-d:preview-down" \
    --bind "ctrl-u:preview-up" \
    --bind "ctrl-o:execute(xdg-open {+})+cancel+cancel" \
    --bind "ctrl-q:change-preview-window(hidden|down)" \
    --with-shell "bash -c" \
    --bind "ctrl-h:transform:[[ ! \$FZF_PROMPT =~ \"ignore\" ]] &&
      echo \"change-prompt( Files(ignore)> )+reload($FIND_CMD --no-ignore)\" ||
      echo \"change-prompt( Files> )+reload($FIND_CMD)\" " \
    --footer "[󰌑]  edit [c-q]  position [c-o] 󰣆 open file [c-h]  no ignore [c-r] 󰑓 reload"

  set -l TOKEN (commandline --current-token)
  set --prepend FZF_OPTS --prompt=" Files> " --query="$TOKEN" --preview=$FZF_PREVIEW
  set -l RESULT ($FIND_CMD 2>/dev/null | fzf $FZF_OPTS)

  test $status -eq 0; and $EDITOR $RESULT

  commandline --function repaint
end
