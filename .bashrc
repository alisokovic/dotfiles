# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# -----------------------------------------------------------------------------

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# ---------- Aliases -----------
# show more ls aliases
alias ll="ls -alF"
alias la="ls -A"
alias l="ls -CF"

alias vim=nvim
alias fuzzy="fzf --ansi --style minimal --preview 'bat --color=always --style=numbers --line-range=:500 {}' --bind 'focus:transform-header:file --brief {}'"

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
# ----------------------------------

# Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Oh-My-Posh
eval "$(oh-my-posh init bash --config 'emodipt-extend')"

# ------------- FZF --------------
# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# Use fd instead of fzf
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for details.
_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}

# Use fd to generate list for directory completion
_fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
}

export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --style=numbers --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
        cd)     fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
        export) fzf --preview "eval 'echo \$' {}"          "$@" ;;
        ssh)    fzf --preview 'dig {}'                   "$@" ;;
        *)      fzf --preview "--preview 'bat -n --color=always --line-range :500 {}'" "$@" ;;
    esac
}

# --------- Eza (better ls) --------- 
alias ls="eza --color=always --icons=always --long --git --no-user --no-time --no-permissions"
