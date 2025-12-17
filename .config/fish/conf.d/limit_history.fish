set -q fish_private_mode; and return 1

function fish_postexec --on-event fish_postexec
  if test $status -eq 0
    history merge
  else
    set last_command $argv[1]
     if test -n "$last_command"
        builtin history delete --exact --case-sensitive "$last_command"
      end
  end
end
