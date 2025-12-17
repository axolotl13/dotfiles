function __fzf_search_podman -d "Search podman"
  type -q podman;
  or return 1

  set PODMAN_CMD podman
  set FZF_PREVIEW "podman logs -f --tail=100 {1}"

  set FZF_OPTS \
    --style minimal \
    --height 60% \
    --layout reverse \
    --multi \
    --preview-window=cycle,follow,65%:down \
    --bind "ctrl-q:change-preview-window(up|hidden)" \
    --bind "ctrl-d:preview-down" \
    --bind "ctrl-u:preview-up" \
    --bind "start:reload:$PODMAN_CMD ps -a" \
    --bind "ctrl-t:execute:$PODMAN_CMD exec -it {1} sh" \
    --bind "del:execute-silent($PODMAN_CMD stop {1})+execute-silent($PODMAN_CMD rm {1})+reload:$PODMAN_CMD ps -a" \
    --bind "enter:execute-silent($PODMAN_CMD start {1})+reload:$PODMAN_CMD ps -a" \
    --bind "ctrl-d:execute-silent($PODMAN_CMD stop {1})+reload:$PODMAN_CMD ps -a" \
    --header-lines=1 \
    --footer "[󰌑]  start pod [c+q] 󱂪 position [c+d]  stop pod  [c+t]  exec pod [del] 󰆴 delete pod"
  
  set TOKEN (commandline --current-token)
  set --prepend FZF_OPTS --prompt=" Podman> " --query="$TOKEN" --preview $FZF_PREVIEW
  $PODMAN_CMD ps -a | fzf $FZF_OPTS | awk '{print $1}'

  commandline --function repaint
end
