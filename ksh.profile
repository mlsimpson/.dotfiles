# $OpenBSD: dot.profile,v 1.5 2018/02/02 02:29:54 yasuoka Exp $
#
# sh/ksh initialization

PATH=$HOME/bin:/bin:/sbin:/usr/bin:/usr/sbin:/usr/X11R6/bin:/usr/local/bin:/usr/local/sbin:/usr/games

. /home/vagrant/.colors

LSCOLORS=fxexcxdxbxegedabagacad
PS1='\u${GRAY}@${NORM}\h:${CYAN}\w${NORM} \\$ '

export PATH HOME TERM LSCOLORS PS1

alias ls='colorls -G'
