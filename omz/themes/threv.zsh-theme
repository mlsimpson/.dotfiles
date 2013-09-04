PROMPT='%{$fg[white]%}%n%{$fg[cyan]%}@%{$fg[white]%}%m%{$fg_bold[red]%} ➜ %{$fg[cyan]%}%~ $(git_prompt_info)$(svn_prompt_info)$(hg_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗ "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%}) "

ZSH_THEME_SVN_PROMPT_PREFIX="%{$fg_bold[blue]%}svn:(%{$fg[red]%}"
ZSH_THEME_SVN_PROMPT_SUFFIX=""
ZSH_THEME_SVN_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗ "
ZSH_THEME_SVN_PROMPT_CLEAN="%{$fg[blue]%}) "

ZSH_THEME_HG_PROMPT_PREFIX="%{$fg_bold[blue]%}hg:(%{$fg[red]%}"
ZSH_THEME_HG_PROMPT_SUFFIX=""
ZSH_THEME_HG_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗ "
ZSH_THEME_HG_PROMPT_CLEAN="%{$fg[blue]%}) "
