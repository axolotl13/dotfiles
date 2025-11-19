set -q fish_private_mode; and return 1

# set -l _skip_history_cmds ls clear htop nvim rg grep l lsl su

# function fish_postexec --on-event fish_postexec
#     if contains -- (commandline -opc)[1] $__skip_history_cmds
#         history delete --exact (history | head -n1)
#         return
#     end
#
#     if test $status -ne 0
#         history delete --exact (history | head -n1)
#     end
# end

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
