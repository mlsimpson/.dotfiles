#####
# Threv's .zshrc
# Don't forget to install mouseterm for vim!
#####

#####
# Oh-My-ZSH!
# Path to oh-my-zsh configuration.
export ZSH=/Users/mattsimpson/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#export ZSH_THEME="christopherSO"
export ZSH_THEME="half-life.custom"
#source /Users/threv/.liquidprompt/liquidprompt

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable autosetting terminal title.
#export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
# Mac
# SLOW!!
# plugins=(brew bundler rvm gem github git gnu-utils heroku npm osx python rails3 rake ruby ssh-agent textmate nyan zargs zsh-syntax-highlighting fbcmd pgsql pip cpanm)
plugins=(ssh-agent zsh-syntax-highlighting pass fuck brew vagrant docker python golang zsh-autosuggestions npm)
# Debian
# plugins=(rvm bundler debian gem github git gnu-utils heroku python rails3 rake ruby ssh-agent nyan)

source $ZSH/oh-my-zsh.sh
# End oh-my-zsh
#####
#. ~/.oh-my-zsh/custom/plugins/zsh-functional/functional.plugin.zsh

# Homebrew ZSH completion
fpath=(/usr/local/share/zsh-completions $fpath)

# Path stuff
# Customize to your needs...
export PATH=$HOME/.node_modules_global/bin:$PATH:~:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/opt/local/bin:/usr/local/git/bin:~/Library/Python/2.7/bin

####
# Functions
#
function most_useless_use_of_zsh {
  local lines columns colour a b p q i pnew
  ((columns=COLUMNS-1, lines=LINES-1, colour=0))
  for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
    for ((a=-2.0; a<=1; a+=3.0/columns)) do
      for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
        ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
      done
      ((colour=(i/4)%8))
      echo -n "\\e[4${colour}m "
    done
    echo
  done
}

# Convert coverart
function coverart {
  convert $1 -adaptive-resize 400x400 -adaptive-sharpen 0x1.0 cover.png
  rm $1
  optipng -o2 cover.png
}

# Search .allhistory
function hhist {
  ag --no-numbers $1 /Users/msimpson/.allhistory
}

# du -sh sorted
# Graciously provided by b8sell
# https://github.com/b8sell/bash_stuff/blob/master/dush
dush() {
  du -kd1 "$@" | sort -n | while read size fname;
    do for unit in k M G T P E Z Y;
      do if [ $size -lt 1024 ];
        then echo -e "${size}${unit}\t${fname}";
        break;
      fi;
    size=$((size/1024));
    done;
  done
}

#####
# Set colors for man pages.
man() {
  env \
    LESS_TERMCAP_mb=$(printf "\e[1;37m") \
    LESS_TERMCAP_md=$(printf "\e[1;37m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;47;30m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[0;36m") \
    man "$@"
}

# Display series of dots during completion
expand-or-complete-with-dots() {
  echo -n "\e[31m......\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots

####
# Completion
zstyle ':completion::complete:*' use-cache on
zstyle ':completion::complete:*' cache-path ~/.zsh/cache/$HOST

# Precede different sections in various completions with headers.
# IE:  ssh is separated into "remote host name" and "login name"
zstyle ':completion:*' group-name "${(@):-}"

# allow approximate
zstyle ':completion:*' completer _complete _match  _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

## tab completion for PID :D
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always

# Autocompletion of hosts, based on ssh known_hosts and config files
zstyle ':completion:*:ssh:*' group-order 'users' 'hosts'

# Set up colors, prompts, and messages
#eval `gdircolors`
#zstyle ':completion:*' list-colors ''
#zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' prompt 'Found %e errors:'
zstyle :compinstall filename $HOME/.zshcompl

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
#zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*:descriptions' format '%F{red}%U%B%d%b%u%f'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' separate-sections 'yes'

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Separate man page sections.  Neat.
zstyle ':completion:*:manuals' separate-sections true

# offer indexes before parameters in subscripts
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters

# command for process lists, the local web server details and host completion
zstyle ':completion:*:processes' command 'ps -o pid,s,nice,stime,args'
zstyle ':completion:*:processes-names' command 'ps axho command'
zstyle ':completion:*:urls' local 'www' '/var/www/htdocs' 'public_html'
# zstyle '*' hosts $hosts

# color code completion
#zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

# Enable oh-my-zsh agent-forwarding
zstyle :omz:plugins:ssh-agent agent-forwarding on

## c-x c-x => history menu
#autoload -Uz history-beginning-search-menu
#zle -N history-beginning-search-menu
#bindkey '^X^X' history-beginning-search-menu

####
# rbenv

#eval "$(rbenv init -)"

####
# alias

# Overwriting oh-my-zsh directory completion to suit pushdminus
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'

# Quickly show disk usage in current directory
alias duf='du -kd1 | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'

# Git aliases
alias gam='git commit -a -m'
alias grep='grep --color=always'
alias gitclog="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias gitsync="git checkout master; git reset --hard upstream/master; git push origin master --force"

# ANSI color for less, always
alias less='less -mRFX'

# Overwrite oh-my-zsh's lsa behavior (remove the -l flag)
alias lsa='ls -ah'

# Show only directories
alias lsd='ls -d */'

# Show only files, sorted by size
alias lss='ls -aSh *(.)'
alias mkdir='mkdir -p'
alias pgrep='nocorrect pgrep -lf'
alias pkill='nocorrect pkill'
alias scp='scp -r'

# Quick alias for gcc options
alias gcc="gcc -O2 -Wall -pedantic"

# Create cscope.out in the current directory
#alias mcs="cscope -bcvR **/*.(c|h|cpp|cc)"

# Homebrew commands all in one to update, upgrade, and cleanup
alias newbrew="brew update; brew upgrade; brew cleanup"

# NO LONGER NEEDED
# Always start irssi in screen
#alias irssi="/usr/local/bin/screen irssi"

# Make GNU fileutils more verbose
for c in cp mv chmod chown rename rm; do
    alias $c="$c -v"
done

alias cp='cp -r -v'

# List all executable files in PATH
#alias pathexec="print -l ${^path}/*(-*N) | less"

alias tmux="tmux -u attach"

alias weather="curl -s wttr.in/Atlanta  | head -n 38 | tail -n -37"

# Always compress & encrypt ssh
#alias ssh="ssh -Cc arcfour,blowfish-cbc"

# This shit works!!
# reseed when needed:  rand; <command> *(o+rand[range])
# range is unnecessary; used to specificy x files
# USE LIKE THIS:
# RANDOM=$(od -An -N2 -i /dev/random); <command>(o+rand[1,30])
rand () {
  REPLY=$RANDOM
}

####
# bindkey
# Esc = undo
bindkey "^[" undo

####
# export

# Sets ANSI color for man pages, and the pager in general.  Also ensures % display on bottom.
export PAGER=less

export HISTSIZE=5000
export SAVEHIST=10000

# Save compiler headaches
# Particularly w/cpan
export ARCHFLAGS="-arch i386 -arch x86_64"
#export ARCHFLAGS="-arch i386"
export VERSIONER_PERL_PREFER_32_BIT="no"

# PERL5LIB
export PERL5LIB=/usr/local/Cellar/perl/5.26.1/lib/perl5/site_perl/5.26.1

# PIP virtual environment
export PIP_RESPECT_VIRTUALENV=true
export PIP_REQUIRE_VIRTUALENV=true

export LC_CTYPE="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

export EDITOR=vim
####
# autojump support
#[[ -f `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
. /usr/local/bin/z.sh

####
# setopt
setopt glob
setopt globdots
setopt pushdminus
# If you really do want to clobber a file, you can use the >! operator. To make things easier in this case, the > is stored in the history list as a >!
# setopt noclobber
# Pipe to multiple outputs
setopt multios

unsetopt hist_verify
unsetopt share_history
#unsetopt auto_name_dirs
unsetopt nomatch
unsetopt correctall

# GPG
if [ -f "${HOME}/.gpg-agent-info" ]; then
  . "${HOME}/.gpg-agent-info"
  export GPG_AGENT_INFO
fi
GPG_TTY=$(tty)
export GPG_TTY

alias t.n="ssh threv@threv.net"
alias m32=mid3v2
alias cb='ssh threv@192.168.1.118'
alias ps="ps aux"
alias ssh='TERM=xterm-256color ssh'

function wttr(){
 curl wttr.in/$1
}

#export PATH="$HOME/.rbenv/bin:$PATH"
#eval "$(rbenv init -)"
#export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
export PATH="/usr/local/opt/python/libexec/bin:$PATH"
