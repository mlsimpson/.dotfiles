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
export ZSH_THEME="half-life"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable autosetting terminal title.
#export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
# Mac
# SLOW!!
# plugins=(brew bundler rvm gem github git gnu-utils heroku npm osx python rails3 rake ruby ssh-agent textmate nyan zargs zsh-syntax-highlighting fbcmd pgsql pip cpanm)
plugins=(ssh-agent zsh-syntax-highlighting pass git fuck task zsh-autosuggestions)
# Debian
# plugins=(rvm bundler debian gem github git gnu-utils heroku python rails3 rake ruby ssh-agent nyan)

source $ZSH/oh-my-zsh.sh
# End oh-my-zsh
#####
# . ~/.oh-my-zsh/custom/plugins/zsh-functional/functional.plugin.zsh

# Set LS_COLORS variable for cross-platform sanity.
# Mac OS X uses $LSCOLORS, defined within the shell.
# I like this better.
# Thanks to Mikachu from #zsh on irc.freenode.net
# LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32'
# LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;47:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'
# export LS_COLORS
# This is necessary for GNU dircolors on Debian-based systems
# d=.dircolors
# test -r $d && eval "$(dircolors $d)"
# ZLS_COLORS=$LS_COLORS

# Path stuff
# Customize to your needs...
# export PATH=$PATH:~:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin:/opt/local/bin

# ffs
setxkbmap -option ctrl:nocaps

# Locale
export LC_CTYPE="en_US.UTF-8"

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

## PulseAudio volume control
function vol(){
  pactl set-sink-volume 0 -- $1%
}

# Volume up & down for PulseAudio
alias vup='pactl set-sink-volume 0 -- +10%'
alias vdo='pactl set-sink-volume 0 -- -10%'

# add to Todo-list
function todo () {
	echo "$*" >> ~/Documents/notes/todo_macbook.txt
	cat Documents/notes/todo_macbook.txt | sort > tmp.txt && mv -v tmp.txt Documents/notes/todo_macbook.txt
}

function mdless () {
  pandoc -s -f markdown -t man $1 | groff -T utf8 -man | less
}

# Capitalize first letter of each word in filename
function capitalize () {
  rename 's/\b(\w)/\u$1/g' *
  rename 's/Mp3/mp3/' *
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

## Force menu on C-x RET.
#zle -C complete-first complete-word _generic
#zstyle ':completion:complete-first:*' menu yes
#bindkey "^X^M" complete-first

## c-x c-x => history menu
#autoload -Uz history-beginning-search-menu
#zle -N history-beginning-search-menu
#bindkey '^X^X' history-beginning-search-menu

## Complete in history with M-/, M-,
#zstyle ':completion:history-words:*' list no
#zstyle ':completion:history-words:*' menu yes
#zstyle ':completion:history-words:*' remove-all-dups yes
#bindkey "\e/" _history-complete-older
#bindkey "\e," _history-complete-newer

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

alias dca="deluge-console add"

alias gam='git commit -a -m'
alias gap='git add -p'
alias gcl='git clone'
alias gd='git diff'
alias gitclog='git log --graph --abbrev-commit --decorate --date=relative --format=format:'%C(bold blue)%h%C(reset) - %C(bold green)(%ar)%C(reset) %C(white)%s%C(reset) %C(dim white)- %an%C(reset)%C(bold yellow)%d%C(reset)' --all'
alias grep='grep --color=always'
alias gvim='gvim -f -geom 75x35'
alias latr="ls -latr"
alias less='less -mR'
# VLESS=$(find /usr/share/vim -name 'less.sh')
# if [ ! -z $VLESS ]; then
#   alias less=$VLESS
# fi
alias lltag='lltag --id3v2'
# Overwrite oh-my-zsh's lsa behavior (remove the -l flag)
alias lsa='ls -ah'
# Show only directories
alias lsd='ls -d */'
# Only directories, sorted by size
alias lsds='ls -dS */'
# Show only files, sorted by size
alias lss='ls -aSh *(.)'
alias larsh="ls -larSh"
alias mkdir='mkdir -p'
alias mpg123='mpg123 -v -C'
#alias npm='npm -g'
alias perldoc='perldoc -t'
alias pgrep='nocorrect pgrep -l'
alias pkill='nocorrect pkill'
alias ri='ri -f ansi'
alias scp='scp -r'
alias tree='tree -aCh'
alias dtree='tree -aChd -L 1'
alias ttytter='ttytter -ansi'

# Quick alias for gcc options
# CHOST="i686-pc-linux-gnu"
# CFLAGS="-march=pentium4 -O2 -pipe -fomit-frame-pointer"
# CXXFLAGS="${CFLAGS}"
alias gcc="gcc -O2 -Wall -pedantic"

# Create cscope.out in the current directory
alias mcs="cscope -bcvR **/*.(c|h|cpp|cc)"

# Update gems in one go
alias newgems="gem update; gem cleanup"

# Update npm packages
alias newnpm="sudo npm update; sudo npm cache clean"

# Update CPAN packages
alias newcpan="cpan-outdated -p | cpanm -i && rm -rf /home/threv/.cpanm/work"

# Always start irssi in screen
# alias irssi="screen irssi"

# Easy start/stop pgsql
# alias pgstart="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
# alias pgstop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"

# Make GNU fileutils more verbose
for c in cp mv chmod chown rename rm; do
    alias $c="$c -v"
done

alias cp='cp -r -v'

# List all executable files in PATH
#alias pathexec="print -l ${^path}/*(-*N) | less"

alias tmux="tmux -u attach"

# Always compress & encrypt ssh
# alias ssh="ssh -Cc arcfour,blowfish-cbc"

# Linux:  Make htop refresh every second
alias htop='htop -d 10'

# Silly random cowsay fun
#alias cowfun='fortune -a | fmt -80 -s | cowsay -$(shuf -n 1 -e b d g p s t w y) -f $(shuf -n 1 -e $(cowsay -l | tail -n +2)) -n;'

# ps auxww | ack "thingy" alias
alias psa='ps auxww | ag '

# Boy, do I type mid3v2 a lot
alias m32="mid3v2"

# for weather command
alias weather='weather --imperial KFTY'

# Wine aliases
alias winamp="wine /home/threv/.wine/drive_c/Program\ Files/Winamp/winamp.exe > /dev/null 2>&1 &"
alias foobar2000="wine /home/threv/.wine/drive_c/Program\ Files/foobar2000/foobar2000.exe > /dev/null 2>&1 &"

# clipit alias to suppress messages
#alias clipit="clipit 2> /dev/null"

# check Downloads dir
alias latrd="ls -latr /var/lib/deluge/Downloads"

# when running locate, check if file on disk
alias locate="locate -e"

# byobu alias
alias byobu="TERM=xterm-256color byobu"

# start gdb in tui mode
alias gdb="gdb -tui"

alias weather="curl -s wttr.in/Atlanta"

alias rcopy="rsync -av --info=progress2"

alias wine32="WINEARCH=win32 wine"

alias cleanpkgs="dpkg -l | grep "^rc" | cut -d " " -f 3 | xargs sudo dpkg --purge"
####
# bindkey
# Esc = undo
bindkey "^[" undo

# Pipe the current command through less
#bindkey -s "\el" " 2>&1|less^M"

#bindkey "^R" history-incremental-pattern-search-backward
#bindkey "^S" history-incremental-pattern-search-forward
####
# export

# Editor = vim
export EDITOR=vim

# Sets ANSI color for man pages, and the pager in general.  Also ensures % display on bottom.
export PAGER=less
# export PAGER=vimpager

# Set mail dir
# export MAIL="/var/mail/threv"

export HISTSIZE=5000
export SAVEHIST=10000

# MySQL Prompt
export MYSQL_PS1="\\d> "

# Linux stuff
# export TERM=-256color

# Save compiler headaches
# Particularly w/cpan
export ARCHFLAGS="-arch i386"
export VERSIONER_PERL_PREFER_32_BIT="yes"

# PIP virtual environment
# export PIP_RESPECT_VIRTUALENV=true
# export PIP_REQUIRE_VIRTUALENV=true

####
# autojump support
# [[ -f `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh
# For Linux
. /usr/local/bin/z.sh

####
# for vmail
#export VMAIL_VIM=vim
export VMAIL_BROWSER='midori'

# Don't send stuff to MS
export DOTNET_CLI_TELEMETRY_OPTOUT=1

####
# setopt
setopt glob globdots pushdminus multios extendedglob braceccl
# If you really do want to clobber a file, you can use the >! operator. To make things easier in this case, the > is stored in the history list as a >!
# setopt noclobber
# Pipe to multiple outputs

unsetopt hist_verify share_history auto_name_dirs nomatch correctall

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

# Make less open tons of file types
# Debian Linux:
# eval `lesspipe`
# Mac:
#   - requires brew install lesspipe
# eval `/usr/local/bin/lesspipe.sh`

# PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
# Maybe this isn't needed?
# source $HOME/.rvm/scripts/rvm

# Set SDL-based games to use joystick mappings
# export SDL_JOYSTICK_DEVICE=/dev/input/js0

# GPG
eval $(cat /home/threv/.gnupg/gpg-agent-info-commiebastard )
export GPG_AGENT_INFO
GPG_TTY=$(tty)
export GPG_TTY

#virtualenvwrapper
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh 2>&1 /dev/null
