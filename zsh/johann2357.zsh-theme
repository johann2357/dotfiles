PROMPT='$(git_prompt_info)%{$fg[cyan]%}%c%{$reset_color%}'
PROMPT+='$(get_default_prompt)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[white]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_DIRTY_CUSTOM="%(?:%{$fg_bold[yellow]%} $:%{$fg_bold[red]%} $)"
# ZSH_THEME_GIT_PROMPT_DIRTY_CUSTOM="%{$fg_bold[yellow]%} $"
ZSH_THEME_GIT_PROMPT_CLEAN_CUSTOM="%(?:%{$fg_bold[white]%} $:%{$fg_bold[red]%} $)"
# ZSH_THEME_GIT_PROMPT_CLEAN_CUSTOM="%{$fg_bold[white]%} $"

# We wrap in a local function instead of exporting the variable directly in
# order to avoid interfering with manually-run git commands by the user.
function __git_prompt_git() {
  GIT_OPTIONAL_LOCKS=0 command git "$@"
}

# Checks if working tree is dirty
function custom_git_prompt() {
  local STATUS
  local -a FLAGS
  FLAGS=('--porcelain')
  if [[ "$(__git_prompt_git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
    if [[ "${DISABLE_UNTRACKED_FILES_DIRTY:-}" == "true" ]]; then
      FLAGS+='--untracked-files=no'
    fi
    case "${GIT_STATUS_IGNORE_SUBMODULES:-}" in
      git)
        # let git decide (this respects per-repo config in .gitmodules)
        ;;
      *)
        # if unset: ignore dirty submodules
        # other values are passed to --ignore-submodules
        FLAGS+="--ignore-submodules=${GIT_STATUS_IGNORE_SUBMODULES:-dirty}"
        ;;
    esac
    STATUS=$(__git_prompt_git status ${FLAGS} 2> /dev/null | tail -n 1)
  fi
  if [[ -n $STATUS ]]; then
    echo "$ZSH_THEME_GIT_PROMPT_DIRTY_CUSTOM"
  else
    echo "$ZSH_THEME_GIT_PROMPT_CLEAN_CUSTOM"
  fi
}

function get_default_prompt() {
    if [[ -z $(git_prompt_info) ]]
    then
        echo " %(?:$ :%{$fg_bold[red]%}$ )%{$reset_color%}"
    else
        echo "$(custom_git_prompt) %{$reset_color%}"
    fi
}
