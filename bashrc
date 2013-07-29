#!/bin/sh

export PATH=~/dotfiles/bin:/usr/local/sbin:$PATH
export GREP_OPTIONS='--color=auto'
export HISTTIMEFORMAT='%F %T '
export EDITOR='subl -w'

HISTCONTROL=ignoreboth

# aliases
alias ls="ls -alpGh"             # always need long listing
alias cd..='cd ..'               # my common mistake from DOS era
alias ..="cd .."                 # go to parent dir
alias ...="cd ../.."             # go to grandparent dir
alias -- -="cd -"                # go to previous dir
alias vim='vim -X'               # don't try to contact xserver (which can hang on network issues)
alias top='htop'                 # preffered
alias head='head -n $((${LINES:-12}-2))'      # as many as possible without scrolling
alias tail='tail -n $((${LINES:-12}-2)) -s.1' # likewise, also more responsive -f

# load brew autocompletion
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

# recognize a branch for our prompt
function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}

# custom prompt and coloring
function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  local      YELLOW="\[\033[1;33m\]"
  local   COLORLESS="\[\033[0m\]"
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac
  PS1="\n$RED\u@\h: $LIGHT_GREEN[\W]$WHITE\$(parse_git_branch)\n$YELLOW-> $COLORLESS"
  PS2="$YELLOW > $COLORLESS"
  PS4=PS2
}

proml
