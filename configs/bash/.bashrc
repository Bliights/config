export LANG=en_US.UTF-8

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Aliases
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Conda (conflicts with prompt rendering because of icon parsing issues)
# export CONDA_CHANGEPS1=false
# export CONDA_PROMPT_MODIFIER=""

# if [ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]; then
#   source "$HOME/anaconda3/etc/profile.d/conda.sh"
# fi

# Starship (Prompt)
eval "$(starship init bash)"

# History
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=20000
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
shopt -s histappend # append to the history file, don't overwrite it
shopt -s checkwinsize # check the window size after each command and, if necessary, update the values of LINES and COLUMNS.

# GPG (Signing keys)
export GNUPGHOME="/c/Users/cleme/AppData/Roaming/gnupg"
export PATH="/c/Program Files (x86)/GnuPG/bin:$PATH"
export GPG_TTY=$(tty)

# FZF (fuzzy finder)
# ctrl-r for search history, ctrl-t to search file and alt-c to go in a folder
eval "$(fzf --bash)"
export FZF_DEFAULT_OPTS="--bind=tab:down --bind=btab:up --cycle --layout=reverse --border"

get_completions() {
    local root node cur word
    local -a words

    words=("$@")
    cur="${words[-1]}"

    root="$(carapace "$1" export)" || return
    node="$root"

    # Walk down the command tree based on already typed subcommands
    for word in "${words[@]:1:${#words[@]}-2}"; do
        [[ "$word" == -* ]] && break

        # Find matching subcommand in the current node
        node="$(
            jq -c --arg word "$word" '
                .Commands[]?
                | select(
                    .Name == $word
                    or (.Aliases[]? == $word)
                )
            ' <<< "$node"
        )"

        [[ -z "$node" ]] && return
    done

    # Extract possible completions from the current node
    jq -r --arg cur "$cur" '
        def emit($name; $desc):
            select($name | startswith($cur))
            | "\($name) (\($desc // ""))";

        def emit_command:
            . as $cmd
            | emit($cmd.Name; $cmd.Short),
            (
                $cmd.Aliases[]?
                | emit(.; "alias for " + $cmd.Name)
            );

        def emit_short_flag:
            select(.Shorthand?)
            | emit("-" + .Shorthand; .Usage);

        def emit_long_flag:
            select(.Longhand?)
            | emit("--" + .Longhand; .Usage);

        (.Commands[]? | emit_command),
        (.LocalFlags[]? | emit_short_flag),
        (.LocalFlags[]? | emit_long_flag)
    ' <<< "$node" |
    awk '
        !seen[$0]++ {
            if ($0 ~ /^--/) long_flags[++lf] = $0
            else if ($0 ~ /^-/) short_flags[++sf] = $0
            else commands[++c] = $0
        }
        END {
            for (i = 1; i <= c; i++) print commands[i]
            for (i = 1; i <= sf; i++) print short_flags[i]
            for (i = 1; i <= lf; i++) print long_flags[i]
        }
    '
}

_fzf_possible_completions() {
    local line="$READLINE_LINE"
    local point="$READLINE_POINT"

    # Do nothing on empty line
    if [[ -z "${line//[[:space:]]/}" ]]; then
        return
    fi

    # Remove the TAB character inserted by readline
    if [[ "${line:point-1:1}" == $'\t' ]]; then
        line="${line:0:point-1}${line:point}"
        ((point--))
    fi

    # Rebuild completion context for carapace
    COMP_LINE="$line"
    COMP_POINT="$point"
    COMP_TYPE=63
    COMP_KEY=9

    local prefix="${line:0:point}"

    # Properly rebuild COMP_WORDS
    read -ra COMP_WORDS <<< "$prefix"

    # Detect trailing space (new argument)
    if [[ "$prefix" == *" " ]]; then
        COMP_WORDS+=("")
    fi

    COMP_CWORD=$((${#COMP_WORDS[@]}-1))

    local cur="${COMP_WORDS[COMP_CWORD]}"
    local cmd="${COMP_WORDS[0]}"

    COMPREPLY=()

    if (( COMP_CWORD == 0 )); then
        mapfile -t COMPREPLY < <(compgen -c -- "$cur" | sort -u)
    else
        mapfile -t COMPREPLY < <(get_completions "${COMP_WORDS[@]}")
    fi

    [[ ${#COMPREPLY[@]} -eq 0 ]] && return

    local selected
    selected=$(
        printf '%s\n' "${COMPREPLY[@]}" |
        sed 's/^[[:space:]]*//' |
        awk '
        {
            line=$0
            cmd=line
            desc=""

            if (match(line, /^([^ ]+) \((.*)\)/, m)) {
                cmd=m[1]
                desc=m[2]
            }

            printf "%s\t%s\n", cmd, desc
        }' |
        column -t -s $'\t' -o $'\t' |
        fzf \
            --reverse \
            --select-1 \
            --exit-0 \
            --query="$cur" \
            --delimiter=$'\t' \
            --with-nth=1,2 \
            --nth=1 \
    )

    # Extract only the command (first column)
    insert="${selected%%$'\t'*}"
    insert="${insert%% *}"

    if [[ -n "$insert" ]]; then
        local line="$READLINE_LINE"
        local point="$READLINE_POINT"

        # Remove the TAB if readline inserted one
        if [[ "${line:point-1:1}" == $'\t' ]]; then
            line="${line:0:point-1}${line:point}"
            ((point--))
        fi

        # Find the start of the current word
        local start=$point
        while (( start > 0 )) && [[ "${line:start-1:1}" != " " ]]; do
            ((start--))
        done

        # Replace the current word with the selected completion
        READLINE_LINE="${line:0:start}${insert}${line:point}"
        READLINE_POINT=$(( start + ${#insert} ))
    fi
}

# Replace TAB TAB behavior
bind -x '"\C-i\C-i": _fzf_possible_completions'

# Carapace (autocompletion in shell)
export CARAPACE_BRIDGES='bash'
source <(carapace _carapace)

# Fix Windows PATH (convert ; -> :)
export PATH="$(echo "$PATH" | tr ';' ':')"