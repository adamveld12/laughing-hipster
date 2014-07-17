# vim: set ft=sh

alias pd="pushd $1"
alias cdp="cd -"

alias ..='cd ..'

# list files
alias ll='ls --color=always -l'

#rake
alias bake='bundle exec rake'
alias fbake='bundle exec rake clobber default test:xunit'
alias bakeserver='bundle exec rake clobber localci build_env=dev'
alias uberbake='~/uberbake.txt'

function symlink(){
  bake nuget:symlink[$1,$2]
}

#tools
alias s='start Source/*.sln'
alias ss='startserver'
alias projects='cd /c/Projects'
alias resrc='source ~/.bash_aliases && source ~/.bashrc && source ~/.profile'
alias role='whoami -groups -fo list | grep -i'
alias fu='find ./ -type f -print0 | xargs -0 grep -n $1'

function cc()
{
  if [ -z "$1" ]
    then 
      echo "bake compass:compile"
      bake compass:compile
  else
    echo "compass compile"
    compass compile $1
  fi
}

#git
alias gs='git status'
alias ehinit='git init --template=C:/Users/adve/eh-git'

alias diff='git difftool'
alias diffc='git difftool --cached'
alias gpr='git pull --rebase'
alias gmt='git mergetool'
alias grc='git rebase --continue'
alias gk='git fetch origin; git remote prune origin; gitk --all &'
alias sym='~/nugetsymlink'
alias cw='compass watch $1'
alias dlb='dml'

function dml(){
  for b in `git branch --merged | grep -v \*`; do git branch -D $b; done
}

function ehclone()
{
  if [ -z "$1" ]
  then
    echo "Missing git repository url ending"
    echo "usage: ehclone 'extendhealth git repository ending' ['target directory name']"
  else
    giturl="git@github.extendhealth.com:extend-health/$1.git"

    if [ -z "$2" ]
    then
      # we DON'T HAVE a target directory
      git clone --template=C:/Users/adve/eh-git $giturl $1
    else
      # we HAVE a target directory
      git clone --template=C:/Users/adve/eh-git $giturl $2
    fi
  fi
}
