# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=4890
SAVEHIST=4890
setopt beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/johann/.zshrc'

autoload -U compinit
compinit
# End of lines added by compinstall

# Custom config
setopt PROMPT_SUBST
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}
NEWLINE=$'\n'
# color #d5c4a1 is white for gruvbox fg2
PS1='%F{gray}[%* - %n@%m] %B%F{cyan}%~%b %F{gray}$(parse_git_branch) %F{#d5c4a1}${NEWLINE}$ '

# Alias
[[ -f ~/.alias-personal ]] && . ~/.alias-personal

# TODO: move to a file
#       read https://thevaluable.dev/zsh-install-configure-mouseless/
# completion
zmodload -i zsh/complist

unsetopt MENU_COMPLETE   # do not autoselect the first completion entry
unsetopt FLOWCONTROL     # disable Ctrl-S pause output while Ctrl-Q continue
setopt AUTO_MENU         # show completion menu on successive tab press
setopt AUTO_LIST         # Automatically list choices on ambiguous completion.
setopt COMPLETE_IN_WORD  # Complete from both ends of a word.
setopt ALWAYS_TO_END
setopt AUTO_PARAM_SLASH

# +---------+
# | zstyles |
# +---------+

# Ztyle pattern
# :completion:<function>:<completer>:<command>:<argument>:<tag>

# Define completers
zstyle ':completion:*' completer _extensions _complete _approximate

# Use cache for commands using cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
# Complete the alias when _expand_alias is used as a function
zstyle ':completion:*' complete true

zle -C alias-expension complete-word _generic
bindkey '^Xa' alias-expension
zstyle ':completion:alias-expension:*' completer _expand_alias

# Use cache for commands which use it

# Allow you to select in a menu
zstyle ':completion:*' menu select

# Autocomplete options for cd instead of directory stack
zstyle ':completion:*' complete-options true

zstyle ':completion:*' file-sort modification


zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %D %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'
# zstyle ':completion:*:default' list-prompt '%S%M matches%s'
# Colors for files and directory
zstyle ':completion:*:*:*:*:default' list-colors ${(s.:.)LS_COLORS}

# Only display some tags for the command cd
zstyle ':completion:*:*:cd:*' tag-order local-directories directory-stack path-directories
# zstyle ':completion:*:complete:git:argument-1:' tag-order !aliases

# Required for completion to be in good groups (named after the tags)
zstyle ':completion:*' group-name ''

zstyle ':completion:*:*:-command-:*:*' group-order aliases builtins functions commands

# See ZSHCOMPWID "completion matching control"
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' keep-prefix true

zstyle -e ':completion:*:(ssh|scp|sftp|rsh|rsync):hosts' hosts 'reply=(${=${${(f)"$(cat {/etc/ssh_,~/.ssh/known_}hosts(|2)(N) /dev/null)"}%%[# ]*}//,/ })'


# automatically load bash completion functions
autoload -U +X bashcompinit && bashcompinit

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# move around completion menu
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# vim cursor
cursor_mode() {
    # See https://ttssh2.osdn.jp/manual/4/en/usage/tips/vim.html for cursors
    cursor_block='\e[2 q'
    cursor_beam='\e[6 q'

    function zle-keymap-select {
        if [[ ${KEYMAP} == vicmd ]] ||
            [[ $1 = 'block' ]]; then
            echo -ne $cursor_block
        elif [[ ${KEYMAP} == main ]] ||
            [[ ${KEYMAP} == viins ]] ||
            [[ ${KEYMAP} = '' ]] ||
            [[ $1 = 'beam' ]]; then
            echo -ne $cursor_beam
        fi
    }

    zle-line-init() {
        echo -ne $cursor_beam
    }

    zle -N zle-keymap-select
    zle -N zle-line-init
}
cursor_mode

# menuselect with vim keys
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# edit line with $EDITOR
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd V edit-command-line

# fzf stuff
[[ -f /usr/share/fzf/completion.zsh ]] && . /usr/share/fzf/completion.zsh
[[ -f /usr/share/fzf/key-bindings.zsh ]] && . /usr/share/fzf/key-bindings.zsh

# syntax highlight
[[ -f /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]] && . /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Custom OS stuff
[[ -f ~/.zshrc-mac ]] && . ~/.zshrc-mac
