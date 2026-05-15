# vi-mode
# NOTE: Use hybrid key bindings that inherit emacs-style bindings in all modes
if status --is-interactive
    # NOTE: Disable custom key bindings when running in neovim or linux console to avoid
    # conflicts with neovim's built-in terminal and linux console's limited key support
    set -q NVIM; and return 1
    test "$TERM" = linux; and return 1

    function fish_hybrid_key_bindings --description \
        "Vi-style bindings that inherit emacs-style bindings in all modes"
        for mode in default insert visual
            fish_default_key_bindings -M $mode
        end
        fish_vi_key_bindings --no-erase
    end
    set -g fish_key_bindings fish_hybrid_key_bindings

    # NOTE: Private mode is a feature that allows you to start a new shell session with a clean environment
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

    bind --mode insert ctrl-e suppress-autosuggestion

    bind --mode insert shift-tab complete-and-search
    bind shift-tab complete-and-search

    # NOTE: Custom fish cursor
    set fish_cursor_default block blink
    set fish_cursor_insert line blink
    set fish_cursor_replace_one underscore blink
    set fish_cursor_replace underscore blink
    set fish_cursor_external line
    set fish_cursor_visual block
end
