function __fzf_search_directory --description "Search the current directory"
  type -q find;
  or return 1

  set FIND_CMD find * -type d
  set FIND_CMD_ROOT find / -type d
  set FZF_PREVIEW "ls -la --color=always {}"

  type -q fd;
  and set FIND_CMD fd --hidden --type d --color=always
  and set FIND_CMD_ROOT $FIND_CMD . /

  type -q eza;
  and set FZF_PREVIEW "eza --tree --level=2 --icons --color=always {}"

  type -q xclip;
  and set CLIP "xclip -sel clip"

  set FZF_OPTS \
    --style minimal \
    --height 50% \
    --layout reverse \
    --multi \
    --ansi \
    --marker "▏" \
    --pointer "█" \
    --with-shell "bash -c" \
    --preview-window "55%,<45(down,50%,border-top)" \
    --bind "ctrl-q:change-preview-window(hidden|down)" \
    --bind "del:execute(rm -r {+})+reload($FIND_CMD)+bell" \
    --bind "ctrl-d:preview-down" \
    --bind "ctrl-u:preview-up" \
    --bind "ctrl-o:execute(xdg-open {})+abort" \
    --bind "ctrl-y:execute(printf $PWD/{} | $CLIP)+bell+abort" \
    --bind "ctrl-/:transform:[[ ! \$FZF_PROMPT =~ \"root\" ]] &&
      echo \"change-prompt(# Directory(root)> )+reload($FIND_CMD_ROOT)\" ||
      echo \"change-prompt( Directory(.)> )+reload($FIND_CMD)\" " \
    --bind "ctrl-h:transform:[[ ! \$FZF_PROMPT =~ \"ignore\" ]] &&
      echo \"change-prompt( Directory(no ignore)> )+reload($FIND_CMD --no-ignore)\" ||
      echo \"change-prompt( Directory> )+reload($FIND_CMD)\" " \
    --bind "?:preview:echo 'Keybindings:
󱂪 ctrl+q      change preview position
 ctrl+d      preview_down
 ctrl+u      preview_up
 ctrl+o      open directory
 ctrl+/      search directory in /
󰑓 ctrl+r      search reload
 ctrl+y      copy path
 ctrl+h      search no-ignore
󰆴 del         delete
󰋖 help        help
     '" \
    $FZF_MENU "[󰌑] [c+q]  position [c-o]  open [c-h]  no ignore [del] 󰆴 delete [󰋖] help"

  set TOKEN (commandline --current-token)
  set --prepend FZF_OPTS --prompt=" Directory(.)> " --query="$TOKEN" --preview $FZF_PREVIEW
  set RESULT ($FIND_CMD 2>/dev/null | fzf $FZF_OPTS)

  test $status -eq 0; and builtin cd $RESULT

  commandline --function repaint
end
