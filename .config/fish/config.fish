# Set PATH, MANPATH, etc., for Homebrew.
/opt/homebrew/bin/brew shellenv | source

# Setup fnm
fnm env --use-on-cd | source

# This is something that zsh could do that I don't want to forget about.
# In zsh it is called "push-line-or-edit" and it allows you to push the current
# line to the buffer and start a new line. This is useful for when you are
# typing a command and realize you need to do something else first. You can
# push the current line to the buffer and then start a new line to do something
# else. Once this something else is done, the pushed command is added back to
# the current line.
# This is the fish equivalent of that based on:
# https://github.com/fish-shell/fish-shell/issues/6973#issuecomment-624649522
function push-line
    set -g __fish_pushed_line (commandline)
    commandline ""
    function on-next-prompt --on-event fish_prompt
        commandline $__fish_pushed_line
        functions --erase on-next-prompt
    end
end

# bind \cu push-line
