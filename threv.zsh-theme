PROMPT='%{$fg[white]%}%n%{$fg[cyan]%}@%{$fg[white]%}%m %{$fg[cyan]%}%~%{$fg_bold[red]%} ➜ $(git_prompt_info)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗ "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) "
