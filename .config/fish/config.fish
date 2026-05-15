test -f $__fish_config_dir/.env.fish; and source $__fish_config_dir/.env.fish

test "$TERM" = linux; and fish_config prompt choose default

# source /etc/profile with bash
# if status is-login
#     test -e /etc/profile && source /etc/profile
#     test -e $HOME/.bash_profile && source $HOME/.bash_profile
# end
#
# if set -q SSH_CLIENT
#     set ip (echo $SSH_CLIENT | awk '{print $1}')
#     set last_ssh (last -F | grep -E "ssh|pts" | grep -v "still logged in" | awk 'NR==1{print}')
#     echo "$ip"
#     echo "$last"
#     set_color normal
# end
