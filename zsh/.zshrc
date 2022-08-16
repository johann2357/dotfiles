# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=4890
SAVEHIST=4890
setopt beep extendedglob nomatch notify
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/johann/.zshrc'

autoload -Uz compinit
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
Setopt AUTO_MENU         # show completion menu on successive tab press
setopt COMPLETE_IN_WORD
setopt ALWAYS_TO_END
setopt AUTO_PARAM_SLASH

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
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

