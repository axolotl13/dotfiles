alias ip="ip -color=auto"

type -q curl; and alias ipp="curl https://ipinfo.io/ip"
type -q bat; and alias cat="bat -pp"
type -q zoxide; and alias cd="z"
type -q nvim; and alias vim="nvim --noplugin"
type -q podman; and alias docker="podman"
type -q rsync; and alias cpr="rsync -avh --progress"
type -q git; and test -e $HOME/.dotfiles; and alias dot='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'

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
    alias pxi="sudo pacman -S"
    alias pxu="sudo pacman -Syu"
    alias pxd="sudo pacman -Rs"
    alias pxe="sudo pacman -Rsdn (pacman -Qqdt)"
    alias pxc="sudo pacman -Scc"
  end
end

type -q paru; and alias pxc="paru -Scc"
