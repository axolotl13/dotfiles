function __fzf_search_pacman -d 'Search pacman packages'
  type -q pacman;
  and type -q sudo;
  and type -q kitty;
  or return 1

  set PACMAN_PKG pacman -Slq

  set FZF_PREVIEW "pacman -Si {1}"

  type -q paru;
  and set FZF_PREVIEW "paru -Si {1}"

  set FZF_OPTS \
    --style minimal \
    --height 50% \
    --layout reverse \
    --multi \
    --ansi \
    --marker "▏" \
    --pointer "█" \
    --with-shell "bash -c" \
    --preview-window "right,65%,<55(down,50%,border-top)" \
    --bind "ctrl-q:change-preview-window(down|up|hidden)" \
    --bind "ctrl-d:preview-down" \
    --bind "ctrl-u:preview-up" \
    --bind "?:preview:echo 'Keybindings:
󱂪 ctrl+q      change preview position
󰌑 enter       install package
󰇚 ctrl+t      download package
 ctrl+/      installed package
󰁡 ctrl+x      update system
 ctrl+p      paru package / pacman package
 ctrl+e      information package
󱂩 ctrl+d      page-down
󱔓 ctrl+u      page-up
󰆴 del         delete package
󰋖 help        help
    '" \
    --bind "ctrl-x:execute(kitty sh -c 'pkexec pacman -Syu')+abort" \
    --bind "enter:execute(kitty sh -c 'pkexec pacman -S {+}')+abort" \
    --bind "del:execute(kitty sh -c 'pkexec pacman -Rsn {+}')+abort" \
    --bind "ctrl-t:execute(kitty sh -c 'pkexec pacman -Sw {+}')" \
    --bind "ctrl-e:execute(pacman -Qil {+} | less)" \
    --bind "ctrl-/:transform:[[ ! \$FZF_PROMPT =~ \"installed\" ]] &&
      echo \"change-prompt( Package(installed)> )+reload(pacman -Qsq)\" ||
      echo \"change-prompt( Package(pacman)> )+reload($PACMAN_PKG)\" " \
    --bind "ctrl-p:transform:[[ ! \$FZF_PROMPT =~ \"paru\" ]] &&
      echo \"change-prompt( Package(paru)> )+reload(paru -Slq)\" ||
      echo \"change-prompt( Package(pacman)> )+reload($PACMAN_PKG)\" " \
    --footer "[󰌑] install [c+q] 󱂪 position [c+x] 󰁡 update [del] 󰆴 delete [󰋖] help"
  
  set TOKEN (commandline --current-token)
  set --prepend FZF_OPTS --prompt=" Package(pacman)> " --query="$TOKEN" --preview $FZF_PREVIEW
  $PACMAN_PKG | fzf $FZF_OPTS

  commandline --function repaint
end
