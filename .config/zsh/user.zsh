#  Startup 
# Commands to execute on startup (before the prompt is shown)
# Check if the interactive shell option is set
#if [[ $- == *i* ]]; then
    # This is a good place to load graphic/ascii art, display system information, etc.
#    if command -v pokego >/dev/null; then
#        pokego --no-title -r 1,3,6
#    elif command -v pokemon-colorscripts >/dev/null; then
#        pokemon-colorscripts --no-title -r 1,3,6
#    elif command -v fastfetch >/dev/null; then
#        if do_render "image"; then
#            fastfetch --logo-type kitty
#        fi
#    fi
#fi
#

#  Startup 
#  Startup 
#  Startup 
#  Startup 
if [[ $- == *i* ]]; then
    _print_ascii_with_fetch() {
        local art='         @@@@@@@ @@@@@@@@@@@@@             
         @@@@@@@ @@@@@@@@@@@@@@@           
           @@@@@           @@@@@@          
           @@@@@            @@@@%          
           @@@@@ @@@@@@@@@ @@@@@           
           @@@@@ @@@@@@@ @@@@@@            
           @@@@@        @@@@@@@@@          
           @@@@@            @@@@@@         
           @@@@% @@@@        @@@@@         
           @@@@@ @@@@@      @@@@@@         
           @@@@@  @@@@@@@@@@@@@@@          
           @@@@@   @@@@@@@@@@@@@           
            @@@       @@@@@@@'

        local art_width=46
        local art_lines=()
        while IFS= read -r line; do
            art_lines+=("$line")
        done <<< "$art"
        local art_count=${#art_lines[@]}

        local fetch_output
        fetch_output=$(fastfetch --logo none --pipe)
        local fetch_lines=()
        while IFS= read -r line; do
            fetch_lines+=("$line")
        done <<< "$fetch_output"
        local fetch_count=${#fetch_lines[@]}

        # Pad art at the top to vertically center it against fetch output
        local top_pad=$(( (fetch_count - art_count) / 2 ))
        local padded_art=()
        for (( i=0; i<top_pad; i++ )); do
            padded_art+=("")
        done
        for line in "${art_lines[@]}"; do
            padded_art+=("$line")
        done

        local total=$(( ${#padded_art[@]} > fetch_count ? ${#padded_art[@]} : fetch_count ))

        for (( i=0; i<total; i++ )); do
            local left="${padded_art[$i]:-}"
            local right="${fetch_lines[$i]:-}"
            printf "%-${art_width}s%s\n" "$left" "$right"
        done
    }

    _print_ascii_with_fetch
fi

#   Overrides 
# HYDE_ZSH_NO_PLUGINS=1 # Set to 1 to disable loading of oh-my-zsh plugins, useful if you want to use your zsh plugins system 
# unset HYDE_ZSH_PROMPT # Uncomment to unset/disable loading of prompts from HyDE and let you load your own prompts
# HYDE_ZSH_COMPINIT_CHECK=1 # Set 24 (hours) per compinit security check // lessens startup time
# HYDE_ZSH_OMZ_DEFER=1 # Set to 1 to defer loading of oh-my-zsh plugins ONLY if prompt is already loaded

if [[ ${HYDE_ZSH_NO_PLUGINS} != "1" ]]; then
    #  OMZ Plugins 
    # manually add your oh-my-zsh plugins here
    plugins=(
        "sudo"
    )
fi
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
