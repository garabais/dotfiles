# Disable greeting message
set fish_greeting

if test -e /usr/share/autojump/autojump.fish
	source /usr/share/autojump/autojump.fish
end

# fzf plugin
bind \cf '__fzf_search_current_dir'
bind \cr '__fzf_search_history'
# bind \cv '__fzf_search_shell_variables'
# The following two key binding use Alt as an additional modifier key to avoid conflicts
bind \e\cl '__fzf_search_git_log'
bind \e\cs '__fzf_search_git_status'


# This solves the issue that fish is slow to respond if the command not exists
# https://unix.stackexchange.com/questions/239245/fish-shell-slow-to-respond-when-command-does-not-exist
function __fish_command_not_found_handler --on-event fish_command_not_found
    echo "fish: Unknown command '$argv'"
end


alias docker="sudo docker"
#alias cat="bat -Pp"
