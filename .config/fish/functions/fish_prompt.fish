# =============================================================================
# PROMPT CONFIGURATION
# =============================================================================
function fish_prompt
    set -l __last_command_exit_status $status

    set -l cyan (set_color -o cyan)
    set -l yellow (set_color -o yellow)
    set -l red (set_color -o red)
    set -l green (set_color -o green)
    set -l blue (set_color -o blue)
    set -l magenta (set_color -o magenta)
    set -l normal (set_color normal)

    set -l arrow_color "$green"
    set -l root_color "$magenta"
    set -l ssh_color "$yellow"

    if test $__last_command_exit_status -ne 0
        set arrow_color "$red"
        set root_color "$red"
        set ssh_color "$red"
    end

    set -l arrow "$arrow_color "
    if test "$SSH_CLIENT"
        set arrow "$ssh_color󰒋 "
    else if fish_is_root_user
        set arrow "$root_color# "
    end

    # Git prompt settings
    set -q __fish_git_prompt_showdirtystate
    or set -g __fish_git_prompt_showdirtystate 1
    set -q __fish_git_prompt_color_stagedstate
    or set -g __fish_git_prompt_color_stagedstate green
    set -q __fish_git_prompt_char_stagedstate
    or set -g __fish_git_prompt_char_stagedstate ' ●'
    set -q __fish_git_prompt_color_dirtystate
    or set -g __fish_git_prompt_color_dirtystate yellow
    set -q __fish_git_prompt_char_dirtystate
    or set -g __fish_git_prompt_char_dirtystate ' ✘'
    set -q __fish_git_prompt_color_branch
    or set -g __fish_git_prompt_color_branch red
    set -q __fish_git_prompt_char_stateseparator
    or set -g __fish_git_prompt_char_stateseparator ''

    set -l gitter $(fish_git_prompt $blue'  git:%s')

    # Disable virtualenv's
    set -q VIRTUAL_ENV_DISABLE_PROMPT; or set -g VIRTUAL_ENV_DISABLE_PROMPT true
    set -q VIRTUAL_ENV; and set -l venv $yellow'  '(path basename $VIRTUAL_ENV)
    # set -l color_host (set_color $fish_color_host)
    set -l host $green(string sub -l 5 (prompt_hostname))

    set -l vicolor
    if test "$fish_key_bindings" = fish_vi_key_bindings
        or test "$fish_key_bindings" = fish_hybrid_key_bindings
        switch $fish_bind_mode
            case default
                set vicolor $blue
            case insert
                set vicolor $green
            case replace replace_one
                set vicolor $red
            case visual
                set vicolor $magenta
            case '*'
                set vicolor $yellow
        end
        set vicolor $vicolor' '; or ''
    end
    set -l mode "$vicolor"
    # set -g modex "$vicolor "$normal

    # set -l cwd "$cyan "(prompt_pwd)
    # set -l color_cwd (set_color $fish_color_cwd)
    set -l cwd "$cyan  "(prompt_pwd | path basename)

    echo -n -s $mode $arrow $host $venv $cwd $gitter $normal ' '
end

function fish_right_prompt
    set -l white (set_color -o brwhite)
    set -l yellow (set_color -o yellow)
    set -l normal (set_color -o normal)

    # set -l __last_exec_time $grey(date "+%H:%M:%S")
    set -l python_version ""
    type -q python; and set python_version "$yellow "(command python -V | cut -d' ' -f2)$normal

    set -l private_mode
    set -q fish_private_mode; and set private_mode $white" "$normal

    set -l duration
    if set -q CMD_DURATION; and test $CMD_DURATION -gt 3000
        set -l hours (math -s0 "$CMD_DURATION/3600000")
        set -l mins (math -s0 "($CMD_DURATION/60000)%60")
        set -l secs (math -s0 "($CMD_DURATION/1000)%60")

        if test $hours -ne 0
            set duration $hours'h' $mins'm' $secs's'
        else if test $mins -ne 0
            set duration $mins'm' $secs's'
        else
            set duration $secs's'
        end
        set duration "$normal $duration"
    else
        set duration ''
    end

    echo -n -s $duration ' '$python_version $private_mode
end
