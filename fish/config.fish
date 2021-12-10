# Disable greeting message
set fish_greeting

if test -e /usr/share/autojump/autojump.fish
	source /usr/share/autojump/autojump.fish
end

# fzf plugin
fzf_configure_bindings --variable=\ce

# This solves the issue that fish is slow to respond if the command not exists
# https://unix.stackexchange.com/questions/239245/fish-shell-slow-to-respond-when-command-does-not-exist
function __fish_command_not_found_handler --on-event fish_command_not_found
    echo "fish: Unknown command '$argv'"
end


alias docker="sudo docker"
alias ssh="TERM=xterm-256color /usr/bin/ssh"
