# vi-mode
if status --is-interactive
  set -q NVIM; and return 1
  test "$TERM" = "linux"; and return 1

  function fish_hybrid_key_bindings --description \
    "Vi-style bindings that inherit emacs-style bindings in all modes"
    for mode in default insert visual
      fish_default_key_bindings -M $mode
    end
    fish_vi_key_bindings --no-erase
  end
  set -g fish_key_bindings fish_hybrid_key_bindings

  function __toggle_private_mode
    if set -q fish_private_mode
      exit
    else
      fish --private
      commandline -f repaint
    end
  end

  bind --mode insert ctrl-delete '__toggle_private_mode'
  bind ctrl-delete '__toggle_private_mode'

  bind --mode insert ctrl-e 'suppress-autosuggestion'

  set fish_cursor_default block blink
  set fish_cursor_insert line blink
  set fish_cursor_replace_one underscore blink
  set fish_cursor_replace underscore blink
  set fish_cursor_external line
  set fish_cursor_visual block
end
