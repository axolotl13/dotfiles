# zoxide
if type -q zoxide
  set -gx _ZO_ECHO "0"
  set -gx _ZO_MAXAGE "5000"
  set -gx _ZO_EXCLUDE_DIRS $HOME $HOME/.cache/*
  # set -gx -a --path _ZO_EXCLUDE_DIRS $HOME $HOME/.cache /tmp /var/tmp
  zoxide init fish | source
end

# kubectl
type -q kubectl; and kubectl completion fish | source

# fzf
if status --is-interactive
  set -q NVIM; and return 1
  test "$TERM" = "linux"; and return 1
  type -q fzf; or return 1

  # fzf --fish | source
  # NOTE: Disable default keybinds
  fzf --fish | FZF_CTRL_T_COMMAND= FZF_CTRL_R_COMMAND= FZF_ALT_C_COMMAND= source

  set -x FZF_THEME_LIGHT "\
  --color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
  --color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
  --color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
  --color=selected-bg:#BCC0CC \
  --color=border:#9CA0B0,label:#4C4F69"

  set -x FZF_THEME_DARK "\
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
  --color=selected-bg:#45475A \
  --color=border:#6C7086,label:#CDD6F4"

  bind --mode insert ctrl-f '__fzf_search_directory'
  bind ctrl-f '__fzf_search_directory'
  bind --mode insert ctrl-t '__fzf_search_files'
  bind ctrl-t '__fzf_search_files'
  bind --mode insert ctrl-r '__fzf_search_history'
  bind ctrl-r '__fzf_search_history'
  bind --mode insert ctrl-s '__fzf_search_grep'
  bind ctrl-s '__fzf_search_grep'
  bind --mode insert ctrl-p '__fzf_search_pacman'
  bind ctrl-p '__fzf_search_pacman'
  bind --mode insert ctrl-x '__fzf_search_podman'
  bind ctrl-x '__fzf_search_pacman'
end
