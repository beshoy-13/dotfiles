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
        "git"
        "sudo"
        "zsh-256color"
        "zsh-autosuggestions"
        "zsh-syntax-highlighting"
    )
fi
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# --- dotnet ---
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$DOTNET_ROOT:$DOTNET_ROOT/tools:$PATH
source $HOME/.dotnet-aliases.zsh
alias dotnet="$HOME/.dotnet/dotnet"

# --- command not found handler ---
function command_not_found_handler {
    local purple='\e[1;35m' bright='\e[0;1m' green='\e[1;32m' reset='\e[0m'
    printf 'zsh: command not found: %s\n' "$1"
    local entries=( ${(f)"$(/usr/bin/pacman -F --machinereadable -- "/usr/bin/$1")"} )
    if (( ${#entries[@]} )) ; then
        printf "${bright}$1${reset} may be found in the following packages:\n"
        local pkg
        for entry in "${entries[@]}" ; do
            local fields=( ${(0)entry} )
            if [[ "$pkg" != "${fields[2]}" ]]; then
                printf "${purple}%s/${bright}%s ${green}%s${reset}\n" "${fields[1]}" "${fields[2]}" "${fields[3]}"
            fi
            printf '    /%s\n' "${fields[4]}"
            pkg="${fields[2]}"
        done
    fi
    return 127
}

# --- AUR helper ---
if pacman -Qi yay &>/dev/null; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null; then
   aurhelper="paru"
fi
function in {
    local -a inPkg=("$@")
    local -a arch=()
    local -a aur=()
    for pkg in "${inPkg[@]}"; do
        if pacman -Si "${pkg}" &>/dev/null; then
            arch+=("${pkg}")
        else
            aur+=("${pkg}")
        fi
    done
    if [[ ${#arch[@]} -gt 0 ]]; then
        sudo pacman -S "${arch[@]}"
    fi
    if [[ ${#aur[@]} -gt 0 ]]; then
        ${aurhelper} -S "${aur[@]}"
    fi
}

# --- personal aliases ---
alias c='clear'
alias l='eza -lh --icons=auto'
alias ls='eza -1 --icons=auto'
alias ll='eza -lha --icons=auto --sort=name --group-directories-first'
alias ld='eza -lhD --icons=auto'
alias lt='eza --icons=auto --tree'
alias un='$aurhelper -Rns'
alias up='$aurhelper -Syu'
alias pl='$aurhelper -Qs'
alias pa='$aurhelper -Ss'
alias pc='$aurhelper -Sc'
alias po='$aurhelper -Qtdq | $aurhelper -Rns -'
alias vc='code'
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'
alias mkdir='mkdir -p'
