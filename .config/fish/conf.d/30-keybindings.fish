# ==============================================================================
# Keybindings and cursor shapes
# fish/conf.d/30-keybindings.fish
# ==============================================================================

# ------------------------------------------------------------------------------
# vi-mode — hybrid key bindings
# Enables vi-style modal editing while preserving emacs-style bindings
# ------------------------------------------------------------------------------
if status --is-interactive
    # Do not load vi bindings inside Neovim terminal
    set -q NVIM; and return
    # Do not load vi bindings in the raw Linux console (tty)
    test "$TERM" = linux; and return

    # Hybrid key bindings
    function fish_hybrid_key_bindings --description \
        "Vi-style bindings that inherit emacs-style bindings in all modes"
        for mode in default insert visual
            fish_default_key_bindings -M $mode
        end
        fish_vi_key_bindings --no-erase
    end
    set -U fish_key_bindings fish_hybrid_key_bindings

     # Private mode toggle (Ctrl-Delete)
    function __toggle_private_mode
        if set -q fish_private_mode
            exit
        else
            fish --private
            commandline -f repaint
        end
    end

    bind --mode insert ctrl-delete __toggle_private_mode
    bind ctrl-delete __toggle_private_mode

    # Ctrl-E in insert mode — dismiss the current autosuggestion
    bind --mode insert ctrl-e suppress-autosuggestion

    # Shift-Tab — open the interactive completion search menu
    # Works in both insert and normal mode
    bind --mode insert shift-tab complete-and-search
    bind shift-tab complete-and-search

    # Cursor shapes per vi mode
    #   default (normal) → blinking block      (classic vi normal mode look)
    #   insert           → blinking line       (thin line signals insert mode)
    #   replace_one      → blinking underscore (single char replacement)
    #   replace          → blinking underscore (multi char replacement)
    #   external         → line                (used by external commands)
    #   visual           → block               (selection mode)
    set fish_cursor_default block blink
    set fish_cursor_insert line blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_replace underscore blink
    set fish_cursor_external line
    set fish_cursor_visual block
end
