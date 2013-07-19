# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions
alias ..="cd .."
alias ...="cd ../.."
alias ls="ls -G"
alias less="less -mR"
alias dirs="dirs -v"

export PS1="\[\e[36;1m\][\u@\[\e[32;1m\]\h \[\e[0m\]\w]\$ "

pushd()
{
  if [ $# -eq 0 ]; then
    DIR="${HOME}"
  else
    DIR="$1"
  fi

  builtin pushd "${DIR}" > /dev/null
}

pushd_builtin()
{
  builtin pushd > /dev/null
}

popd()
{
  builtin popd > /dev/null
}

alias cd='pushd'
# alias back='popd'
# alias flip='pushd_builtin'

alias 1='cd +1'
alias 2='cd +2'
alias 3='cd +3'
alias 4='cd +4'
alias 5='cd +5'
alias 6='cd +6'
alias 7='cd +7'
alias 8='cd +8'
alias 9='cd +9'

alias grep='grep --color=AUTO'

alias ListAllCommands='compgen -A function -abck|sort|uniq|less'
