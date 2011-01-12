# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ $home = "cps" ]; then
    echo "@home"
else
    echo "@cit"
    export http_proxy=http://proxycps2.cit:3128
    export https_proxy=http://proxycps2.cit:3128
    export ftp_proxy=http://proxycps2.cit:3128
fi

# Colours
export BLUE="\[\033[1;34m\]"
export PURPLE="\[\033[1;35m\]"
export NO_COLOR="\[\e[0m\]"
export GRAY="\[\033[1;31m\]"
export GREEN="\[\033[1;32m\]"
export LIGHT_GRAY="\[\033[1;37m\]"
export LIGHT_GREEN="\[\033[1;32m\]"
export LIGHT_RED="\[\033[1;31m\]"
export RED="\[\033[1;31m\]"
export WHITE="\[\033[1;37m\]"
export YELLOW="\[\033[1;33m\]"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'


# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Set window title
title() {
  echo -ne "\033]0;$@\007";
}

# Usage: f /some/path [grep options]
f() {
  local path="$1"
  shift
  find "$path" -follow -name '*' | xargs grep "$*"
}

# reload source
reload() { source ~/.bashrc; }

custom_prompt () {
  local BRANCH=`git branch 2> /dev/null | grep \* | sed 's/* //'`

  if [[ "$BRANCH" = "" ]]; then
    BRANCH=`git status 2> /dev/null | grep "On branch" | sed 's/# On branch //'`
  fi

  local RUBY_VERSION=`ruby -e "puts RUBY_VERSION"`
  local GEMSET_NAME=`rvm gemset name`
  local RAILS_VERSION=`rails -v 2> /dev/null | sed 's/Rails //'`
  local RAILS_PROMPT=""
  local RUBY_PROMPT=""
  local STATUS=`git status 2>/dev/null`
  local PROMPT_COLOR=$GREEN
  local STATE=" "
  local NOTHING_TO_COMMIT="# Initial commit"
  local BEHIND="# Your branch is behind"
  local AHEAD="# Your branch is ahead"
  local UNTRACKED="# Untracked files"
  local DIVERGED="have diverged"
  local CHANGED="# Changed but not updated"
  local TO_BE_COMMITED="# Changes to be committed"
  local LOG=`git log -1 2> /dev/null`

  if [[ "$RAILS_VERSION" != "" ]]; then
    RAILS_PROMPT="${RAILS_VERSION}@"
  fi

  if [[ "$GEMSET_NAME" != "" ]]; then
    RUBY_PROMPT="${GREEN}[${RAILS_PROMPT}${GEMSET_NAME}#${RUBY_VERSION}]${NO_COLOR} "
  else
    RUBY_PROMPT="${GREEN}[${RAILS_PROMPT}${RUBY_VERSION}]${NO_COLOR} "
  fi

  if [ "$STATUS" != "" ]; then
    if [[ "$STATUS" =~ "$NOTHING_TO_COMMIT" ]]; then
      PROMPT_COLOR=$RED
      STATE=""
    elif [[ "$STATUS" =~ "$DIVERGED" ]]; then
      PROMPT_COLOR=$RED
      STATE="${STATE}${RED}↕${NO_COLOR}"
    elif [[ "$STATUS" =~ "$BEHIND" ]]; then
      PROMPT_COLOR=$RED
      STATE="${STATE}${RED}↓${NO_COLOR}"
    elif [[ "$STATUS" =~ "$AHEAD" ]]; then
      PROMPT_COLOR=$RED
      STATE="${STATE}${RED}↑${NO_COLOR}"
    elif [[ "$STATUS" =~ "$CHANGED" ]]; then
      PROMPT_COLOR=$RED
      STATE=""
    elif [[ "$STATUS" =~ "$TO_BE_COMMITED" ]]; then
      PROMPT_COLOR=$RED
      STATE=""
    else
      PROMPT_COLOR=$GREEN
      STATE=""
    fi

    if [[ "$STATUS" =~ "$UNTRACKED" ]]; then
      STATE="${STATE}${YELLOW}*${NO_COLOR}"
    fi

    PS1="\n${RUBY_PROMPT}${YELLOW}\w\a${NO_COLOR} (${PROMPT_COLOR}${BRANCH}${NO_COLOR}${STATE}${NO_COLOR})\n${BLUE}\$${NO_COLOR} "
  else
    PS1="\n${RUBY_PROMPT}${YELLOW}\w\a${NO_COLOR}\n${BLUE}\$${NO_COLOR} "
  fi
}

# taken from http://github.com/bryanl/zshkit/
git-track () {
  local BRANCH=`git branch 2> /dev/null | grep \* | sed 's/* //'`
  git config branch.$BRANCH.remote origin
  git config branch.$BRANCH.merge refs/heads/$BRANCH
  echo "tracking origin/$BRANCH"
}
github-url () { git config remote.origin.url | sed -En 's/git(@|:\/\/)github.com(:|\/)(.+)\/(.+).git/https:\/\/github.com\/\3\/\4/p'; }
github-go () { open $(github-url); }
git-scoreboard () { git log | grep '^Author' | sort | uniq -ci | sort -r; }
manp () { man -t $* | ps2pdf - - | open -f -a Preview; }

PROMPT_COMMAND=custom_prompt


export PATH


######################
# CUSTOM STARTS HERE #
######################

# Aliases #
###########
# projects
alias citcode='cd ~/projects/citcode'
alias exame='cd ~/projects/exame'
# ls
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Dir
alias home='cd'
alias documents='cd ~/documents'
alias downloads='cd ~/downloads'
alias linuxdoc='cd ~/linuxdoc'
alias music='cd ~/music'
alias pix='cd ~/pictures'
alias root='sudo -i'

# Sudo
alias install='sudo apt-get install'
alias remove='sudo apt-get remove'
alias purge='sudo apt-get remove --purge'
alias update='sudo apt-get update'
alias clean='sudo apt-get autoclean && sudo apt-get autoremove'
alias sources='(gksudo geany /etc/apt/sources.list &)'

# chmod and permissions commands
alias mx='chmod a+x'
alias 000='chmod 000'
alias 644='chmod 644'
alias 755='chmod 755'

# Misc
alias a='alias'
alias c='clear'
alias h='htop'
alias x='exit'
alias bg='geany ~/.bashrc'
alias pci='lspci'
alias ksf='killall swiftfox-bin'
alias del='rm --target-directory=$HOME/.Trash/'
alias font='fc-cache -v -f'

# cit servers
alias pina='ssh exame@pina'
alias abeguar='ssh exame@abeguar'


#abril servers
alias dev-abril='ssh exame@dev.exame.abril.com.br -p 5022'
alias qa-abril='ssh exame@qa.exame.abril.com.br -p 5022'


# Rails
mrake () { RAILS_ENV="$1" rake "$2"; }
alias tdrop='RAILS_ENV=test rake db:drop'
alias tcreate='RAILS_ENV=test rake db:create'
alias tclone='rake db:test:clone'
alias ddrop='RAILS_ENV=development rake db:drop'
alias dcreate='RAILS_ENV=development rake db:create'
alias dmigrate='RAILS_ENV=development rake db:migrate'
alias dseed='RAILS_ENV=development rake db:seed'
mgit() {
git "$1" origin "$parse_git_branch";
}





# Extracting
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       rar x $1       ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

export GREP_OPTIONS="--color=auto"

findf() {
 find . | xargs grep $1 -islno
}
#Automatically do an ls after each cd
cd() {
  if [ -n "$1" ]; then
    builtin cd "$@" && ls
  else
    builtin cd ~ && ls
  fi
}

##################
# WELCOME SCREEN #
##################

fortune | cowsay -f tux
echo -ne "${NC}"



# Activate RVM
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm
