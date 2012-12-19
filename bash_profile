if [ -f "$HOME/.bashrc" ] ; then
  source $HOME/.bashrc
fi

set -o vi
set -o notify
set -o noclobber
set -o ignoreeof

# Enable options:
shopt -s cdspell
shopt -s cdable_vars
shopt -s checkhash
shopt -s checkwinsize
shopt -s sourcepath
shopt -s no_empty_cmd_completion
shopt -s cmdhist
shopt -s histappend histreedit histverify
shopt -s extglob        # Necessary for programmable completion.

# Disable options:
shopt -u mailwarn
unset MAILCHECK         # Don't want my shell to warn me of incoming mail.

export SVN_EDITOR=vi
export CLICOLOR=1

#export LS_COLORS=ExFxCxDxBxegedabagacad
#export LSCOLORS=ExFxCxDxBxegedabagacad
export GREP_OPTIONS='--color=auto'

export LS_COLORS=HxbxcxdxHxegedabagacad
export LSCOLORS=HxbxcxdxHxegedabagacad

function parse_git_branch {
  git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

function proml {
  local        BLUE="\[\033[0;34m\]"
  local         RED="\[\033[0;31m\]"
  local   LIGHT_RED="\[\033[1;31m\]"
  local       GREEN="\[\033[0;32m\]"
  local      YELLOW="\[\033[0;33m\]"
  local LIGHT_GREEN="\[\033[1;32m\]"
  local       WHITE="\[\033[1;37m\]"
  local  LIGHT_GRAY="\[\033[0;37m\]"
  
  # Color the Prompt
  LESS='\e[1;37m' #gray
  SOME='\e[0;32m' #green
  MORE='\e[1;33m' #yellow
  HIGH='\e[1;36m'
  ROOT='\e[1;31m'
  TEXT='\e[m'
  
  case $TERM in
    xterm*)
    TITLEBAR='\[\033]0;\u@\h:\w\007\]'
    ;;
    *)
    TITLEBAR=""
    ;;
  esac
  
  PS1="$LIGHT_GRAY\$(parse_git_branch)$GREEN\w$BLUE\n${TITLEBAR}$BLUE($RED\u$BLUE)$GREEN\$ "
  PS2='> '
  PS4='+ '
}
proml

#===============================================================
#
# ALIASES AND FUNCTIONS
#
# Arguably, some functions defined here are quite big.
# If you want to make this file smaller, these functions can
# be converted into scripts and removed from here.
#
# Many functions were taken (almost) straight from the bash-2.04
# examples.
#
#===============================================================

#-------------------
# Personnal Aliases
#-------------------

alias r='ruby'

# -> Prevents accidentally clobbering files.
alias ssh='la ~/.ssh/id_rsa.pub; ssh '
alias mkdir='mkdir -p'

alias h='history'
alias j='jobs -l'
alias which='type -a'
alias ..='cd ..'
alias cd..='cd ..'
alias path='echo -e ${PATH//:/\\n}'
alias libpath='echo -e ${LD_LIBRARY_PATH//:/\\n}'

alias du='du -kh'       # Makes a more readable output.
alias df='df -kTh'

alias cw='compass watch'
alias m='mate .'
alias o='open .'

alias psg='ps -e | grep '
alias break2comma='while read line; do echo -n "$line,"; done'
#--------------------------
# Version Control Aliases
#--------------------------

alias gits='git status'
alias gita='git add .'
alias gitc='git commit -m'
alias gitcam='git add .; git commit -m'
alias gitrm='git status | grep deleted | cut -c 15- | xargs git rm'
alias gitb='git branch'
alias gitl='clear; git log'
alias gitco='git checkout'
alias gitm='git merge --no-ff'
alias gcl='git clone '
alias gpso='git push origin '
alias gplo='git pull origin '
alias gpsom='gpso master'
alias gplom='gplo master'
alias gpsod='gpso develop'
alias gplod='gplo develop'
alias gpsor='gpso release'
alias gplor='gplo release'
alias gpshm='git push heroku master'
alias gcp='git cherry-pick'
alias gcpm='git cherry-pick -m1'
alias gitfiles='git show --pretty="format:" --name-only '
alias gitexport='git archive --format zip --output source-tree-master.zip master '
alias gitdfc='git diff --color'
alias grhh='git reset HEAD --hard'
alias gitcod='gitco develop'
alias gitcor='gitco release'
alias gitcom='gitco master'
alias gitsma='git submodule add'

# Git Flow
alias gitfs='git flow feature start '
alias gitff='git flow feature finish '
alias giths='git flow hotfix start '
alias githf='git flow hotfix finish '
alias gitrs='git flow release start '
alias gitrf='git flow release finish '

# SVN
alias svna='svn add . --force'
alias svnc='svn commit -m'
alias svnco='svn checkout'
alias svncf='svn commit -m "updated"'
alias svni='svn propedit svn:ignore'
alias svns='svn status'
alias svnu='svn up'
alias svnrmw='rm -rf `find . -type d -name .svn`'


# RVM
alias rvmrc='rvm --rvmrc --create'
alias bundle!='gem install bundler;bundle;'
alias rebuild_test_db='rake db:drop RAILS_ENV=test; rake db:create RAILS_ENV=test; rake db:migrate RAILS_ENV=test; rake db:seed RAILS_ENV=test;'

#-------------------------------------------------------------
# The 'ls' family (this assumes you use a recent GNU ls)
#-------------------------------------------------------------

alias ll="ls -lU"
#alias ls='ls -hFC --color=auto'         # add colors for filetype recognition
alias ls='ls -hFC'         # add colors for filetype recognition
alias la='ls -Al'          # show hidden files
alias lx='ls -lXB'         # sort by extension
alias lk='ls -lSr'         # sort by size, biggest last
alias lc='ls -ltcr'        # sort by and show change time, most recent last
alias lu='ls -ltur'        # sort by and show access time, most recent last
alias lt='ls -ltr'         # sort by date, most recent last
alias lr='ls -lR'          # recursive ls
alias trg='tree -d | grep ' # nice alternative to 'recursive ls'
#alias tr='tree -d -L 2'    # tree but only a few levels deep
alias llg='ll | grep -i '  # filter list by string
alias lag='la | grep -i '  # filter list by string

#-------------------------------------------------------------
# spelling typos - highly personnal and keyboard-dependent :-)
#-------------------------------------------------------------

alias xs='cd'
alias vf='cd'
alias kk='ll'

alias startnginx='sudo /opt/nginx/sbin/nginx' 
alias stopnginx='sudo kill `cat /opt/nginx/logs/nginx.pid `' 
alias restartnginx='stopnginx; startnginx'

#Git Repositories
export GHIL=gitolite@hilscher.ca
export GHUB=git@github.com:blakehilscher
export GQ=git@github.com:quandl/

function go()
{
  case $1 in
  c)
    cd ~/www/quandl/chef-repo/;;
  h)
    cd ~/www/hilscher/;;
  n)
    cd /opt/nginx/;;
  q)
    cd ~/www/quandl/;;
  w)
    cd ~/www/quandl/wikiposit/;;
  s)
    cd ~/user_settings/;;
  esac
}

#-------------------------------------------------------------
# File & string-related functions:
#-------------------------------------------------------------


# Find a file with a pattern in name:
function ff() { find . -type f -iname '*'$*'*' -ls ; }

function lowercase()  # move filenames to lowercase
{
    for file ; do
        filename=${file##*/}
        case "$filename" in
        */*) dirname==${file%/*} ;;
        *) dirname=.;;
        esac
        nf=$(echo $filename | tr A-Z a-z)
        newname="${dirname}/${nf}"
        if [ "$nf" != "$filename" ]; then
            mv "$file" "$newname"
            echo "lowercase: $file --> $newname"
        else
            echo "lowercase: $file not changed."
        fi
    done
}

function swap()  # Swap 2 filenames around, if they exist
{                #(from Uzi's bashrc).
    local TMPFILE=tmp.$$ 

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE 
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

function extract()      # Handy Extract Program.
{
     if [ -f $1 ] ; then
         case $1 in
             *.tar.bz2)   tar xvjf $1     ;;
             *.tar.gz)    tar xvzf $1     ;;
             *.bz2)       bunzip2 $1      ;;
             *.rar)       unrar x $1      ;;
             *.gz)        gunzip $1       ;;
             *.tar)       tar xvf $1      ;;
             *.tbz2)      tar xvjf $1     ;;
             *.tgz)       tar xvzf $1     ;;
             *.zip)       unzip $1        ;;
             *.Z)         uncompress $1   ;;
             *.7z)        7z x $1         ;;
             *)           echo "'$1' cannot be extracted via >extract<" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

#-------------------------------------------------------------
# Process/system related functions:
#-------------------------------------------------------------

function my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,bsdtime,command ; }


#-------------------------------------------------------------
# Misc utilities:
#-------------------------------------------------------------

function repeat()       # Repeat n times command.
{
    local i max
    max=$1; shift;
    for ((i=1; i <= max ; i++)); do  # --> C-like syntax
        eval "$@";
    done
}

#-------------------------------------------------------------
# Greeting, motd etc...
#-------------------------------------------------------------

# --> Nice. Has the same effect as using "ansi.sys" in DOS.

function _exit()        # Function to run upon exit of shell.
{
    echo -e "Hasta la vista"
}
trap _exit EXIT
