set FAILURE 1

function _pure_prompt_current_folder --argument-names current_prompt_width

    if test -z "$current_prompt_width"; return $FAILURE; end

    set --local current_folder (_pure_parse_directory (math $COLUMNS - $current_prompt_width - 1))
    set --local current_folder_color (_pure_set_color $pure_color_current_directory)

    set --local in_tmux ""
    if set -q TMUX
        set in_tmux (set_color cyan)" "(set_color normal)
    end

    echo "$current_folder_color$current_folder$in_tmux"
end
