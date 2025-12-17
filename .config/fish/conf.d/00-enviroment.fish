# env
if not test -e $HOME/.config/environment.d/envvars.conf
  type -q nvim; and set -gx EDITOR nvim
  # BUG: disable - resession plugin
  # set -x MANPAGER "nvim +Man!"
  set -gx XDG_CACHE_HOME $HOME/.cache
  set -gx XDG_CONFIG_HOME $HOME/.config
  set -gx XDG_DATA_HOME $HOME/.local/share
  set -gx XDG_STATE_HOME $HOME/.local/state

  set -q XDG_RUNTIME_DIR; and set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh
end

# xmlint
type -q xmllint; and set -x XMLLINT_INDENT "    "

# bat
if type -q bat
  set -x BAT_THEME_LIGHT "Catppuccin Latte"
  set -x BAT_THEME_DARK "Catppuccin Macchiato"
  ## man
  # set -x MANPAGER "sh -c 'col -bx | bat --paging=always -l man --plain'"

  ## abbreviation
  # WARNING: This modifies ALL -h and --help declarations.
  # abbr -a --position anywhere -- -h "-h | bat -pplhelp"
  # abbr -a --position anywhere -- --help "--help | bat -pplhelp"
end

# sudo
type -q sudo;
and set -xg SUDO_PROMPT (printf "%s" (tput bold setaf 7)"[sudo]"(tput sgr0)" "(tput setaf 6)"password for"(tput sgr0)" "(tput setaf 5)"%p"(tput sgr0)": ")
