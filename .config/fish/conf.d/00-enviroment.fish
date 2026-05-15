# ==============================================================================
# Environment variables
# fish/conf.d/00-enviroment.fish
# ==============================================================================

# ------------------------------------------------------------------------------
# Core environment — only set if not provided by systemd environment.d
# NOTE: If ~/config/environment.d/envvars.conf exists, systemd should have
#       already exported these via the login session
# ------------------------------------------------------------------------------
if not test -e $HOME/.config/environment.d/envvars.conf
    type -q vim; and set -gx EDITOR vim
    type -q nvim; and set -gx EDITOR nvim

    # XDG base directories
    set -gx XDG_CACHE_HOME $HOME/.cache
    set -gx XDG_CONFIG_HOME $HOME/.config
    set -gx XDG_DATA_HOME $HOME/.local/share
    set -gx XDG_STATE_HOME $HOME/.local/state

    # SSH agent socket (only when XDG_RUNTIME_DIR is set and non-empty)
    set -q XDG_RUNTIME_DIR; and set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh
end

# ------------------------------------------------------------------------------
# manpager
# BUG: nvim resession plugin conflicts with MANPAGER; kept disabled
# ------------------------------------------------------------------------------
# if test "$EDITOR" = "nvim"
#     set -gx MANPAGER "nvim +Man!"
# else
#     set -gx MANPAGER "less --use-color -Dd+r -Du+b"
# end

# ------------------------------------------------------------------------------
# less
# ------------------------------------------------------------------------------
set -gx LESS "--RAW-CONTROL-CHARS --use-color -Dd+r -Du+b"
set -gx MANPAGER "less --use-color -Dd+r -Du+b"

# ------------------------------------------------------------------------------
# xmllint
# ------------------------------------------------------------------------------
type -q xmllint; and set -gx XMLLINT_INDENT "    "

# ------------------------------------------------------------------------------
# bat
# ------------------------------------------------------------------------------
if type -q bat
    set -gx BAT_THEME_LIGHT "Catppuccin Latte"
    set -gx BAT_THEME_DARK "Catppuccin Macchiato"

    # man
    # BUG: This causes a "col: illegal option -- b" error when running
    # set -gx MANPAGER "sh -c 'col -bx | bat --paging=always -l man --plain'"

    # abbreviation
    # WARNING: Breaks commands that use -h / --help as a non-help flag
    # abbr -a --position anywhere -- -h "-h | bat -pplhelp"
    # abbr -a --position anywhere -- --help "--help | bat -pplhelp"
end

# ------------------------------------------------------------------------------
# sudo
# ------------------------------------------------------------------------------
type -q sudo
and set -gx SUDO_PROMPT (printf "%s" (tput bold setaf 7)"[sudo]"(tput sgr0)" "(tput setaf 6)"password for"(tput sgr0)" "(tput setaf 5)"%p"(tput sgr0)": ")
