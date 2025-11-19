function su --description "Switch user using run0 with Fish shell"
  # if not type -q run0
  #   return
  # end

  # command run0 --shell=/usr/bin/fish $argv
  command su --shell=/usr/bin/fish $argv
end
