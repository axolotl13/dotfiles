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

  # bind enter accept-autosuggestion execute
  # bind --mode insert ctrl-enter accept-autosuggestion execute
  # bind --mode insert ctrl-space suppress-autosuggestion
  # bind ctrl-g 'if [ "$fish_autosuggestion_enabled" = 0 ]; set -g fish_autosuggestion_enabled 1; else; set -g fish_autosuggestion_enabled 0; end'
  # bind --mode insert \t complete
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

  # bind --mode insert enter '
  #   if commandline -f accept-autosuggestion
  #     commandline -f accept-autosuggestion execute
  #   else
  #     commandline -f execute
  #   end
  # '
  bind --mode insert ctrl-e 'suppress-autosuggestion'

  set fish_cursor_default block blink
  set fish_cursor_insert line blink
  set fish_cursor_replace_one underscore blink
  set fish_cursor_replace underscore blink
  set fish_cursor_external line
  set fish_cursor_visual block
end
