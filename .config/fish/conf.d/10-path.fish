# node
type -q npm

and set -gx npm_config_prefix $HOME/.local
and fish_add_path $HOME/.local/bin

# go
type -q go

and set -gx GOPATH $HOME/.go
and fish_add_path $GOPATH/bin

# ruby
type -q ruby

and set -gx GEM_HOME (gem env user_gemhome)
and fish_add_path $GEM_HOME/bin

# java
# NOTE: Manually configuring the Java version
type -q java

and set -x JAVA_HOME /usr/lib/jvm/java-26-openjdk/

# neovim bin
test -e $HOME/.neovim/bin

and fish_add_path $HOME/.neovim/bin
