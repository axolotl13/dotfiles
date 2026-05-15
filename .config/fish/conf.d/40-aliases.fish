# color output in console
alias diff="diff --color=auto"
alias grep="grep --color=auto"
alias ip="ip --color=auto"
alias ls='ls --color=auto'
# less
set -x LESS "--RAW-CONTROL-CHARS --use-color -Dd+r -Du+b"
set -x MANPAGER "less --use-color -Dd+r -Du+b"

type -q curl; and alias ipp="curl https://ipinfo.io/ip"
type -q bat; and alias cat="bat -pp"
type -q zoxide; and alias cd="z"
type -q rsync; and alias cpr="rsync -avh --progress"
type -q podman; and ! type -q docker; and alias docker="podman"
type -q nvim; and ! type -q vim; and alias vim="nvim --noplugin"

# NOTE: Add alias for git that allows you to use git commands in your home directory without affecting the actual home directory
type -q git

and test -e $HOME/.dotfiles

and alias dot='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

if type -q kitty; or test -e $HOME/.local/share/kitty-ssh-kitten
    alias kxd="kitten diff"
    alias kxi="kitten icat"
    alias kxr="kitten hyperlinked_grep"
    alias kxs="kitten ssh"
    alias kxp="kitten transfer"
    alias edit="kitten edit-in-kitty"
end

if type -q eza
    alias l="eza -lagh --icons --hyperlink"
    alias l0="eza -lo --icons"
    alias ls="eza"
    alias lsl="eza -Tl --icons"
end

type -q kubectl; and type -q kubecolor; and alias kubectl="kubecolor"

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

type -q paru; and alias pxc="paru -Scc"
