function __fzf_search_grep --description "Search with ripgrep"
  type -q rg; and type -q bat; or return 1

  set -l TEMP (mktemp -u)

  set -l RG_PREFIX rg --column --line-number --no-heading --color=always --smart-case
  set -l FZF_PREVIEW "bat --color=always --theme=\"$BAT_THEME\" {1} --highlight-line {2}"

  set -l FZF_OPTS --style minimal --height 60% --layout=reverse \
    --ansi --disabled \
    --marker "▏" \
    --pointer "█" \
    --color "hl:-1:underline,hl+:-1:underline:reverse" \
    --delimiter ":" \
    --preview-window "up,60%,border-bottom,+{2}+3/3,~3" \
    --bind "ctrl-d:preview-down" \
    --bind "ctrl-u:preview-up" \
  --with-shell "bash -c" \
    --bind "start,change:transform:
        rg_pat={q:1}
        fzf_pat={q:2..}

        if ! test -r \"$TEMP\"  || test \"\$rg_pat\" != \"\$(cat \"$TEMP\")\"; then
          echo \"\$rg_pat\" > \"$TEMP\"
          printf \"reload:sleep 0.1; $RG_PREFIX %q || true\" \"\$rg_pat\"
        fi

        echo \"+search:\$fzf_pat\"
      " \
    --bind "enter:execute($EDITOR {1} +{2})+abort" \
    --bind "ctrl-q:change-preview-window(down,border-top|up,border-bottom)" \
    --footer "[󰌑]  edit [c-q]  position [󱊷] exit"

  set -l TOKEN (commandline --current-token)
  set --prepend FZF_OPTS --prompt=" Grep> " --query="$TOKEN" --preview=$FZF_PREVIEW

  fzf $FZF_OPTS 2>/dev/null

  rm -f "$TEMP"

  commandline --function repaint
end
