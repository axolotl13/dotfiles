function __fzf_search_man -d 'Search manpage'
  set -l MANPAGE "echo {} | sed 's/\([[:alnum:][:punct:]]*\) (\([[:alnum:]]*\)).*/\2 \1/'"
  type -q bat; and set FZF_PREVIEW 'pacman -Si {1} | bat --color=always -p'
  set -l BATMAN "$MANPAGE | xargs -r man | col -bx | bat --language=man --plain --color always"

  set -l FZF_OPTS --style minimal --height 50% --layout=reverse \
    -q "$argv[1]" \
    --ansi \
    --tiebreak=begin \
    --preview $BATMAN \
    --preview-window "50%,rounded,<50(up,85%,border-bottom)" \
    --bind "ctrl-d:preview-down" \
    --bind "ctrl-u:preview-up" \
    --bind "ctrl-q:change-preview-window(|down|up|hidden)" \
    --header "[󰌑] install [c+q] 󱂪 position [c+e] 󰮯 installed [c+a] 󰇚 download [del] 󰆴 delete"
  
  set -l TOKEN (commandline --current-token)
  set --prepend FZF_OPTS --prompt="📄 Man> " --query="$TOKEN"
  man -k . | sort \
  | awk \
    -v cyan=(tput setaf 7) \
    -v blue=(tput setaf 0) \
    -v res=(tput sgr0) \
    -v bld=(tput bold) \
    '{ $1=cyan bld $1; $2=res blue $2; } 1' \
  | fzf $FZF_OPTS

  commandline --function repaint
end


# fzf-man-widget() {
#    | fzf  \
#       -q "$1" \
#       --ansi \
#       --tiebreak=begin \
#       --prompt=' Man > '  \
#       --preview-window '50%,rounded,<50(up,85%,border-bottom)' \
#       --preview "${batman}" \
#       --bind "enter:execute(${manpage} | xargs -r man)" \
#       --bind "alt-c:+change-preview(cht.sh {1})+change-prompt(ﯽ Cheat > )" \
#       --bind "alt-m:+change-preview(${batman})+change-prompt( Man > )" \
#       --bind "alt-t:+change-preview(tldr --color=always {1})+change-prompt(ﳁ TLDR > )"
# }
