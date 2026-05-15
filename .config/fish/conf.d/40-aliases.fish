# =============================================================================
# ALIASES
# fish/conf.d/40-aliases.fish
# =============================================================================

# -----------------------------------------------------------------------------
# Colorized output — force color support for common tools in the console
# -----------------------------------------------------------------------------
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias ip="ip --color=auto"
alias ls='ls --color=auto'

type -q curl; and alias ipp="curl https://ipinfo.io/ip"
type -q bat; and alias cat="bat -pp"
type -q zoxide; and alias cd="z"
type -q rsync; and alias cpr="rsync -avh --progress"
type -q podman; and not type -q docker; and alias docker="podman"
type -q nvim; and not type -q vim; and alias vim="nvim --noplugin"

# -----------------------------------------------------------------------------
# dotfiles — bare git repository management
# Allows running git commands against the dotfiles repo from anywhere,
# without affecting the actual $HOME git state
# Usage: dot status, dot add, dot commit, etc
# -----------------------------------------------------------------------------
type -q git
and test -e $HOME/.dotfiles
and alias dot='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

# -----------------------------------------------------------------------------
# kitty terminal extras — kitten subcommands
# -----------------------------------------------------------------------------
if type -q kitty; or test -e $HOME/.local/share/kitty-ssh-kitten
    alias kxd="kitten diff"
    alias kxi="kitten icat"
    alias kxr="kitten hyperlinked_grep"
    alias kxs="kitten ssh"
    alias kxp="kitten transfer"
    alias edit="kitten edit-in-kitty"
end

# -----------------------------------------------------------------------------
# eza — modern ls replacement with icons and hyperlinks
# -----------------------------------------------------------------------------
if type -q eza
    alias l="eza -lagh --icons --hyperlink"
    alias l0="eza -lo --icons"
    alias ls="eza"
    alias lsl="eza -Tl --icons"
end

# -----------------------------------------------------------------------------
# kubecolor — colorized kubectl output
# -----------------------------------------------------------------------------
type -q kubectl; and type -q kubecolor; and alias kubectl="kubecolor"

# -----------------------------------------------------------------------------
# pacman — Arch Linux package manager shortcuts
#   pxa → show package information (pacman -Si)
#   pxs → search for a package (pacman -Ss)
#   pxi → install a package (sudo pacman -Sy)
#   pxu → full system upgrade (sudo pacman -Syu)
#   pxd → remove package and its unneeded dependencies (sudo pacman -Rs)
#   pxe → remove all orphaned packages (sudo pacman -Rsdn <orphans>)
#   pxc → clean the package cache (sudo pacman -Scc)
# -----------------------------------------------------------------------------
if type -q pacman
    alias pxa="pacman -Si"
    alias pxs="pacman -Ss"
    if type -q sudo
        alias pxi="sudo pacman -Sy"
        alias pxu="sudo pacman -Syu"
        alias pxd="sudo pacman -Rs"
        alias pxe="sudo pacman -Rsdn (pacman -Qqdt)"
        alias pxc="sudo pacman -Scc"
    end
end

# -----------------------------------------------------------------------------
# paru — AUR helper cache cleanup
# -----------------------------------------------------------------------------
type -q paru; and alias pxc="paru -Scc"
