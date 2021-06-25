#!/usr/bin/env fish

abbr -a vim nvim
abbr -a cat bat
abbr -a ls exa
abbr -a ll "exa -lh"
abbr -a la "exa -lah"

set -U fish_color_cancel red --bold
set -u fish_color_autosuggestion brblack
set -u fish_color_command blue
set -u fish_color_comment brblack
set -u fish_color_end yellow
set -u fish_color_error red
set -u fish_color_escape magenta
set -U fish_color_search_match magenta --background=brblack
set -u fish_color_operator magenta
set -u fish_color_param cyan
set -u fish_color_quote green
set -u fish_color_redirection magenta
set -U fish_color_search_match magenta --background=brblack
set -U fish_color_valid_path --bold
set -u fish_pager_color_description cyan
set -U fish_color_match --background =blue

set -u fish_pager_color_progress white --background=blue

if not test -e $__fish_config_dir/functions/fisher.fish
	curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
	fisher update
end
