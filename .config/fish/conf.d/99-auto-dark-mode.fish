# NOTE: Automatically switch between light and dark themes based on the system color scheme.
if status is-interactive
    set -g __last_color_mode
    type -q gsettings; or return 1
    function __auto_theme --on-event fish_prompt
        set mode (gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null)

        test "$mode" = "$__last_color_mode"; and return 1
        set -g __last_color_mode "$mode"

        if string match -q "*dark*" "$mode"
            fish_config theme choose mocha
            set -x FZF_DEFAULT_OPTS $FZF_THEME_DARK
            set -x BAT_THEME $BAT_THEME_DARK
        else
            fish_config theme choose latte
            set -x FZF_DEFAULT_OPTS $FZF_THEME_LIGHT
            set -x BAT_THEME $BAT_THEME_LIGHT
        end
    end
end
