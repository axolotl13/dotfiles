# =============================================================================
# AUTO THEME — Automatically switch between light and dark themes
#
# Listens to the GNOME color-scheme setting and applies the matching theme
# to fish, fzf, and bat on every prompt redraw
#
# Detection is event-driven (fish_prompt), so there is no polling loop or
# background process — the check runs only when a new prompt is drawn
# =============================================================================
if status is-interactive
    not type -q gsettings; and return
    set -g __last_color_mode ""
    function __auto_theme --on-event fish_prompt
        # Read the current GNOME color scheme preference
        set -l mode (gsettings get org.gnome.desktop.interface color-scheme 2>/dev/null)

        # Skip if the color scheme hasn't changed since the last prompt
        test "$mode" = "$__last_color_mode"; and return
        # Persist the new value for comparison on the next prompt
        set -g __last_color_mode "$mode"

        if string match -q "*dark*" "$mode"
             # --- Dark mode ---
            fish_config theme choose mocha
            # Apply fzf dark theme only if the variable is defined
            set -q FZF_THEME_DARK
            and set -gx FZF_DEFAULT_OPTS $FZF_THEME_DARK
            # Apply bat dark theme only if the variable is defined
            set -q BAT_THEME_DARK
            and set -gx BAT_THEME $BAT_THEME_DARK
        else
            # --- Light mode ---
            fish_config theme choose latte
            # Apply fzf light theme only if the variable is defined
            set -q FZF_THEME_LIGHT
            and set -gx FZF_DEFAULT_OPTS $FZF_THEME_LIGHT
            # Apply bat light theme only if the variable is defined
            set -q BAT_THEME_LIGHT
            and set -gx BAT_THEME $BAT_THEME_LIGHT
        end
    end
end
