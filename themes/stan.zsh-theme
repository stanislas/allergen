# Prompt

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '⊢'
}

exitStatusIndicator="%(?,%{$fg[green]%},%{$fg[red]%})●%{$reset_color%}"
userNameHost='%F{cyan}%n%f@%F{white}%M%f'
jobs="%F{magenta}%j%f"
directory="%F{green}%~%f"
PROMPT='${exitStatusIndicator}:${userNameHost}:${jobs}:${directory}
$(prompt_char) '

ZSH_THEME_GIT_PROMPT_PREFIX=":%{$fg[blue]%}(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
