function __fzf_search_directory --description "Search the current directory"
  type -q find; and type -q cat; or return 1

  set -l FIND_CMD find * -type d
  set -l FIND_CMD_ROOT find / -type d
  set -l FZF_PREVIEW "ls -la --color=always {}"

  type -q fd;
  and set FIND_CMD fd --hidden --type d --color=always --follow
  and set FIND_CMD_ROOT $FIND_CMD . /

  type -q eza;
  and set FZF_PREVIEW "eza -la --tree --level=2 --icons --color=always {}"

  type -q xclip;
  and set -l CLIP "xclip -sel clip"

  set -l FZF_OPTS --style minimal --height 50% --layout=reverse \
    --multi --ansi \
    --marker "▏" \
    --pointer "█" \
    # --preview-window "hidden" \
    --bind "ctrl-q:change-preview-window(right|down|hidden)" \
    --bind "del:execute(rm -r {+})+reload($FIND_CMD)" \
    --bind "ctrl-d:page-down" \
    --bind "ctrl-u:page-up" \
    --bind "ctrl-o:execute(xdg-open {})+abort" \
    --with-shell "bash -c" \
    --bind "ctrl-/:transform:[[ ! \$FZF_PROMPT =~ \"root\" ]] &&
      echo \"change-prompt(# Directory(root)> )+reload($FIND_CMD_ROOT)\" ||
      echo \"change-prompt( Directory(.)> )+reload($FIND_CMD)\" " \
    --bind "ctrl-h:transform:[[ ! \$FZF_PROMPT =~ \"ignore\" ]] &&
      echo \"change-prompt( Directory(no ignore)> )+reload($FIND_CMD --no-ignore)\" ||
      echo \"change-prompt( Directory> )+reload($FIND_CMD)\" " \
    --bind "ctrl-y:execute(printf $PWD/{} | $CLIP)+bell+abort" \
    --bind "?:preview:echo 'Keybindings:
󱂪 ctrl+q      change preview position
󱂩 ctrl+d      page-down
󱔓 ctrl+u      page-up
 ctrl+o      open directory
 ctrl+/      search directory in /
󰑓 ctrl+r      search reload
 ctrl+y      copy path
 ctrl+h      search no-ignore
󰆴 del         delete
󰋖 help        help
     '" \
    --footer "[󰌑] [c+q]  position [c-o]  open [c-h]  no ignore [del] 󰆴 delete [󰋖] help"

  set -l TOKEN (commandline --current-token)
  set --prepend FZF_OPTS --prompt=" Directory(.)> " --query="$TOKEN" --preview $FZF_PREVIEW
  set -l RESULT ($FIND_CMD 2>/dev/null | fzf $FZF_OPTS)

  test $status -eq 0; and builtin cd $RESULT

  commandline --function repaint
end
