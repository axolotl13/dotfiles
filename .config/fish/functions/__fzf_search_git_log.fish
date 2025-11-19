function __fzf_search_git_log --description "Search the output of git log and preview commits. Replace the current token with the selected commit hash."
  if not git rev-parse --git-dir >/dev/null 2>&1
      echo '_fzf_search_git_log: Not in a git repository.' >&2
    return
  end
  set -l fzf_git_log_format '%C(bold blue)%h%C(reset) - %C(cyan)%ad%C(reset) %C(yellow)%d%C(reset) %C(normal)%s%C(reset)  %C(dim normal)[%an]%C(reset)'

  set -l preview_cmd 'git show --color=always --stat --patch {1}'
  set -l fzf_diff_highlighter delta --paging=never
  set -l preview_cmd "$preview_cmd | $fzf_diff_highlighter"
  set -l fzf_git_log_format "%H %s"

  set -l selected_log_lines (
    git log --no-show-signature --color=always --format=format:$fzf_git_log_format --date=short | \
    __fzf_wrapper --ansi \
        --multi \
        --scheme=history \
        --prompt="Git Log> " \
        --preview=$preview_cmd \
        --query=(commandline --current-token) \
        $fzf_git_log_opts
  )
  if test $status -eq 0
    for line in $selected_log_lines
        set -l abbreviated_commit_hash (string split --field 1 " " $line)
        set -l full_commit_hash (git rev-parse $abbreviated_commit_hash)
        set -l --append commit_hashes $full_commit_hash
    end
    commandline --current-token --replace (string join ' ' $commit_hashes)
  end

    commandline --function repaint
end
