#####
# Threv's .zshrc
# Don't forget to install mouseterm for vim!
#####

#####
# Oh-My-ZSH!
# Path to oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
export ZSH_THEME="half-life-threv"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable autosetting terminal title.
#export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
# Mac
# SLOW!!
# plugins=(brew bundler rvm gem github git gnu-utils heroku npm osx python rails3 rake ruby ssh-agent textmate nyan zargs zsh-syntax-highlighting fbcmd pgsql pip cpanm)
plugins=(ssh-agent pass git fuck zsh-autosuggestions ripgrep colored-man-pages colorize fast-syntax-highlighting zsh-completions) # fzf-tab F-Sy-H
# Debian
# plugins=(rvm bundler debian gem github git gnu-utils heroku python rails3 rake ruby ssh-agent nyan)

# source homebrew completions
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

source $ZSH/oh-my-zsh.sh
# End oh-my-zsh
#####
. ~/.oh-my-zsh/custom/plugins/zsh-functional/functional.plugin.zsh

# Locale
export LC_CTYPE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LANGUAGE="en_US.UTF-8"
export LC_CTYPE="en_US.UTF-8"
export LC_NUMERIC="en_US.UTF-8"
export LC_TIME="en_US.UTF-8"
export LC_COLLATE="en_US.UTF-8"
export LC_MONETARY="en_US.UTF-8"
export LC_MESSAGES="en_US.UTF-8"
export LC_PAPER="en_US.UTF-8"
export LC_NAME="en_US.UTF-8"
export LC_ADDRESS="en_US.UTF-8"
export LC_TELEPHONE="en_US.UTF-8"
export LC_MEASUREMENT="en_US.UTF-8"
export LC_IDENTIFICATION="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

####
# Functions
#

####
# ZSH General functions
####
# Mandelbrot pattern generation
# Displays floating point abilites of zsh
#function most_useless_use_of_zsh {
#  local lines columns colour a b p q i pnew
#  ((columns=COLUMNS-1, lines=LINES-1, colour=0))
#  for ((b=-1.5; b<=1.5; b+=3.0/lines)) do
#    for ((a=-2.0; a<=1; a+=3.0/columns)) do
#      for ((p=0.0, q=0.0, i=0; p*p+q*q < 4 && i < 32; i++)) do
#        ((pnew=p*p-q*q+a, q=2*p*q+b, p=pnew))
#      done
#      ((colour=(i/4)%8))
#      echo -n "\\e[4${colour}m "
#    done
#    echo
#  done
#}

# This shit works!!
# Random file list generation
# the [1,x] can be omitted to get *all* files
# RANDOM=$RANDOM; command glob(oe:'REPLY=$RANDOM':[1,x])

# Convert coverart
function coverart {
  convert $1 -adaptive-resize 400x400 -adaptive-sharpen 0x1.0 cover.png
  rm $1
  optipng -o2 cover.png
  #pngout cover.png -f5
}

# Search .allhistory
function hhist {
  ag --no-numbers $1 /home/threv/.allhistory
}

# git reup
function gitreup {
  find . -name .git -print -execdir git fetch \; -execdir git pull \; -execdir git submodule update --init --recursive \;
}

# du -sh sorted
# Graciously provided by b8sell
# https://github.com/b8sell/bash_stuff/blob/master/dush
#function dush() {
#  du -kd1 "$@" | sort -n | while read size fname;
#    do for unit in k M G T P E Z Y;
#      do if [ $size -lt 1024 ];
#        then echo -e "${size}${unit}\t${fname}";
#        break;
#      fi;
#    size=$((size/1024));
#    done;
#  done
#}

# Capitalize first letter of each word in filename
function capitalize () {
  rename 's/\b(\w)/\u$1/g' *
  rename 's/Mp3/mp3/' *
}
# Add artist to mobius.txt
function mobius () {
    echo "$1" >> notes/mobius.txt
}
# https://blog.robertelder.org/bash-one-liner-compose-music/
function randmajor () {
    cat /dev/urandom | hexdump -v -e '/1 "%u\n"' | awk '{ split("0,2,4,5,7,9,11,12",a,","); for (i = 0; i < 1; i+= 0.0001) printf("%08X\n", 100*sin(1382*exp((a[$1 % 8]/12)*log(2))*i)) }' | xxd -r -p | sox -t raw -r 44.1k -c 1 -e unsigned -b 16 - test.wav trim 0 15
}
function randminor {
    cat /dev/urandom | hexdump -v -e '/1 "%u\n"' | awk '{ split("0,2,3,5,7,8,10,12",a,","); for (i = 0; i < 1; i+= 0.0001) printf("%08X\n", 100*sin(1382*exp((a[$1 % 8]/12)*log(2))*i)) }' | xxd -r -p | sox -t raw -r 44.1k -c 1 -e unsigned -b 16 - test.wav trim 0 15
}

# Display series of dots during completion
function expand-or-complete-with-dots () {
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
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' prompt 'Found %e errors:'
zstyle :compinstall filename $HOME/.zshcompl

# insert all expansions for expand completer
zstyle ':completion:*:expand:*' tag-order all-expansions

# formatting and messages
zstyle ':completion:*' verbose yes
zstyle ':completion:*' auto-description 'specify: %d'
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
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

# Enable oh-my-zsh agent-forwarding
zstyle :omz:plugins:ssh-agent agent-forwarding on

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
#alias cpanm='cpanm --sudo'
alias duf='du -kd1 | sort -n | perl -ne '\''($s,$f)=split(m{\t});for (qw(K M G T)) {if($s<1024) {printf("%.1f",$s);print "$_\t$f"; last};$s=$s/1024}'\'
alias gcl='git clone'
alias gd='git diff'
alias gitclog="git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all"
alias grep='grep --color=always'
#alias gvim='gvim -f -geom 75x35'
alias latr="ls -latr"
alias less='less -mR'
# Overwrite oh-my-zsh's lsa behavior (remove the -l flag)
alias lsa='ls -ah'
# Show only directories
#alias lsd='ls -d */'
# Only directories, sorted by size
alias lsds='ls -dS */'
# Show only files, sorted by size
alias lss='ls -aSh *(.)'
alias larsh="ls -larSh"
alias mkdir='mkdir -p'
#alias mpg123='mpg123 -v -C'
#alias npm='npm -g'
alias perldoc='perldoc -t'
alias pgrep='nocorrect pgrep -l'
alias pkill='nocorrect pkill'
alias ri='ri -f ansi'
alias scp='scp -r'
alias tree='tree -aCh'
alias dtree='tree -aChd -L 1'
# Make GNU fileutils more verbose
for c in cp mv chmod chown rename rm; do
    alias $c="$c -v"
done
alias cp='cp -r -v'
alias tmux="tmux -u attach"
alias htop='htop -d 10'
# ps auxww | ack "thingy" alias
alias psa='ps auxww | ag '
# when running locate, check if file on disk
alias locate="locate -e"
# start gdb in tui mode
alias gdb="gdb -tui"
alias weather="curl -s wttr.in/Atlanta"
alias rcopy="rsync -av --info=progress2"
alias ssh='ssh -X'
alias t.n='ssh threv@threv.net'
alias cb='ssh -Y threv@192.168.1.76'
alias pry="/usr/local/bin/pry --simple-prompt"
alias ipython="ipython --colors Linux"
alias rm="rm -v -i"
alias faketre="ls -R ../ | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/  /' -e 's/-/|/'"
alias code="/mnt/c/Users/threv/AppData/Local/Programs/Microsoft\ VS\ Code/bin/code"
alias rg="RIPGREP_CONFIG_PATH=/home/threv/.dotfiles/.ripgreprc rg"
alias lsd="lsd --group-directories-first --hyperlink=auto"
# https://www.commandlinefu.com/commands/view/29556/speak-spell-esque-glitch-sounds
alias randspeech="cat /dev/urandom | sox -tlpc - -p | sox -t raw -b 16 -e unsigned -r 4k - test.wav trim 0 10"

####
# bindkey
# Esc = undo
bindkey "^[" undo

####
# export
# Editor = vim
export EDITOR=vim
# Sets ANSI color for man pages, and the pager in general.  Also ensures % display on bottom.
export PAGER=less
# export PAGER=vimpager
export HISTSIZE=5000
export SAVEHIST=10000
#export DISPLAY=localhost:0.0
export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
export "LIBGL_ALWAYS_INDIRECT=1"
# GPG
eval $(cat /home/threv/.gnupg/gpg-agent-info-commiebastard )
export GPG_AGENT_INFO
GPG_TTY=$(tty)
export GPG_TTY
# view percentage of man page viewed
export MANPAGER='less -s -M +Gg'

# with colored-man-pages omz plugin, this works
less_termcap[md]="${fg_bold[white]}"
less_termcap[md]="${fg_bold[white]}"
less_termcap[so]="${bg_bold[white]}${fg_bold[grey]}"
less_termcap[us]="${fg[cyan]}"

####
# autojump support
# [[ -f `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
# For Linux
. /usr/local/bin/z.sh

####
# setopt
setopt glob globdots pushdminus multios extendedglob braceccl inc_append_history # share_history
# If you really do want to clobber a file, you can use the >! operator. To make things easier in this case, the > is stored in the history list as a >!
# setopt noclobber
unsetopt hist_verify auto_name_dirs nomatch correctall share_history

####
# zsh modules
# Load command-line math
# zmodload zsh/mathfunc

# Load zsh raw socket & packet handling
# zmodload zsh/net/socket
# zmodload zsh/zftp

# Load zsh builtin functions
# autoload -U zargs zmv zcalc tcp_open
# autoload -U zmv
#
#autoload -Uz copy-earlier-word
#zle -N copy-earlier-word
#bindkey "^[m" copy-earlier-word

#export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
#autoload -U add-zsh-hook
#load-nvmrc() {
#  if [[ -f .nvmrc && -r .nvmrc ]]; then
#    nvm use
#  elif [[ $(nvm version) != $(nvm version default)  ]]; then
#    echo "Reverting to nvm default version"
#    nvm use default
#  fi
#}
#add-zsh-hook chpwd load-nvmrc
#load-nvmrc

# source ~/.rvm/scripts/rvm
#export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

hash -d steampunk=/mnt/c/Users/threv/Documents/Steampunk

# make the cursor blink like i want god damn it
echo -ne "\e[5 q"

