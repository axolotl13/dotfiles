# ==============================================================================
# Tools
# fish/conf.d/20-tools.fish
# ==============================================================================

# ------------------------------------------------------------------------------
# zoxide - Smart directory jumper
# Replaces `cd` with a frecency-based navigation system
# ------------------------------------------------------------------------------
if type -q zoxide
    set -Ux _ZO_ECHO 0
    set -Ux _ZO_MAXAGE 5000
    set -Ux _ZO_EXCLUDE_DIRS $HOME $HOME/.cache/*
    zoxide init fish | source
end

# ------------------------------------------------------------------------------
# kubectl — kubernetes cli
# ------------------------------------------------------------------------------
type -q kubectl; and kubectl completion fish | source

# ------------------------------------------------------------------------------
# fzf — fuzzy finder
# ------------------------------------------------------------------------------
if type -q fzf && status --is-interactive
    # Do not load fzf bindings inside Neovim terminal
    set -q NVIM; and return
    # Do not load fzf bindings in the raw Linux console (tty)
    test "$TERM" = linux; and return

    # fzf --fish | source
    # Initialize fzf shell integration
    # Disable default key bindings.
    fzf --fish | FZF_CTRL_T_COMMAND= FZF_CTRL_R_COMMAND= FZF_ALT_C_COMMAND= source

    # FZF version detection
    # Used to conditionally enable features added in specific versions
    set -l FZF_VERSION (fzf --version | cut -d. -f2)
    set -gx FZF_MENU --header
    test $FZF_VERSION -ge 67; and set -gx FZF_MENU --footer

    # FZF Catppuccin Latte theme (light)
    set -gx FZF_THEME_LIGHT "\
  --color=bg+:#CCD0DA,bg:#EFF1F5,spinner:#DC8A78,hl:#D20F39 \
  --color=fg:#4C4F69,header:#D20F39,info:#8839EF,pointer:#DC8A78 \
  --color=marker:#7287FD,fg+:#4C4F69,prompt:#8839EF,hl+:#D20F39 \
  --color=selected-bg:#BCC0CC \
  --color=border:#9CA0B0,label:#4C4F69"

    # FZF Catppuccin Mocha theme (dark)
    set -gx FZF_THEME_DARK "\
  --color=bg+:#313244,bg:#1E1E2E,spinner:#F5E0DC,hl:#F38BA8 \
  --color=fg:#CDD6F4,header:#F38BA8,info:#CBA6F7,pointer:#F5E0DC \
  --color=marker:#B4BEFE,fg+:#CDD6F4,prompt:#CBA6F7,hl+:#F38BA8 \
  --color=selected-bg:#45475A \
  --color=border:#6C7086,label:#CDD6F4"

    # Custom keybindings for fzf
    # Each binding is registered for both insert mode and normal mode
    # to work correctly with fish_vi_key_bindings

    # Ctrl-F → search directories (replaces default Alt-C)
    bind --mode insert ctrl-f __fzf_search_directory
    bind ctrl-f __fzf_search_directory
    # Ctrl-T → search files (replaces default Ctrl-T)
    bind --mode insert ctrl-t __fzf_search_files
    bind ctrl-t __fzf_search_files
    # Ctrl-R → search history (replaces default Ctrl-R)
    bind --mode insert ctrl-r __fzf_search_history
    bind ctrl-r __fzf_search_history
    # Ctrl-S → search with grep
    bind --mode insert ctrl-s __fzf_search_grep
    bind ctrl-s __fzf_search_grep
    # Ctrl-P → search pacman packages
    bind --mode insert ctrl-p __fzf_search_pacman
    bind ctrl-p __fzf_search_pacman
    # Ctrl-X → search podman containers/images
    bind --mode insert ctrl-x __fzf_search_podman
    bind ctrl-x __fzf_search_podman
end
