#!/bin/sh
# Prompt Customizations

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

RED="\033[0;31m"
YELLOW="\033[0;33m"
GREEN="\033[0;32m"
GRAY="\033[0;30m"
EMPTY="\033[0;37m"

LIGHTBLUE="\033[38;5;111m"
LIGHTORANGE="\033[38;5;172m"
LIGHTGREEN="\033[38;5;70m"
LIGHTRED="\033[38;5;161m"
LIGHTYELLOW="\033[38;5;229m"
CONTINUE="\033[38;5;242m"
DARKGRAY="\033[38;5;247m"

# Glyph table for airline fonts
# U+E0A0    Version control branch
# U+E0A1    LN (line) symbol
# U+E0A2    Closed padlock
# U+E0B0    Rightwards black arrowhead
# U+E0B1    Rightwards arrowhead
# U+E0B2    Leftwards black arrowhead
# U+E0B3    Leftwards arrowhead
# U+1D77A 𝝺 Lambda

LAR=""
RAR=""
LARS=""
RARS=""
LN=""
VC=""
LK=""
LA="𝝺"

#╭─ ~/src/v8/v8 ‹master›
#╰─$
START_LINE_1="╭─"
START_LINE_2="╰─"

colorize() {
  # $1 is foreground
  # $2 is background
  # $3 is content
  if [ $OSTYPE = 'msys' ]; then
    echo -e "\033[48;3;$2;38;3;$1m$3\\033[0m"
  else
    echo -e "\033[48;5;$2;38;5;$1m$3\\033[0m"
  fi
}

parse_git_branch () {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

parse_git_tag () {
  git describe --tags 2> /dev/null
}

parse_git_branch_or_tag() {
  local OUT="$VC$(parse_git_branch)"
  if [ "$OUT" == " ((no branch))" ]; then
    echo "$VC ($(parse_git_tag)) "
  elif [ "$OUT" == "$VC" ]; then
    echo "x $VC"
  else
    echo "$OUT"
  fi
}

build_prompt_win(){
  local TIME="$(colorize 39 46 ' [$(date +%H:%M)] ')$(colorize 36 42 $RARS)";
  local USER="$(colorize 39 42 ' \u@\h ')$(colorize 32 41 $RARS)"
  local GIT="$(colorize 39 41 ' $(parse_git_branch_or_tag) ')$(colorize 31 49 $RARS)"
  local DIR="$(colorize 33 49 ' \w ')"
  local LEFT="$TIME$USER$GIT$DIR\033[0;0m "
  echo "$LEFT"
}

build_prompt_unix(){
  local TIME="$(colorize 15 33 ' [$(date +%H:%M)] ')$(colorize 33 34 $RARS)";
  local USER="$(colorize 15 34 ' \u@\h ')$(colorize 34 124 $RARS)";
  local GIT="$(colorize 252 124 ' $(parse_git_branch_or_tag) ')$(colorize 124 240 '$RARS')";
  local DIR="$(colorize 11 240 ' \w ')$(colorize 240 0 $RARS)";
  local LEFT="$TIME$USER$GIT$DIR\033[0;0m";
  echo "$LEFT";
}

build_prompt_unix_2(){
    echo -e "${START_LINE_1} \u@\h \w <$(parse_git_branch)>\n${START_LINE_2}${LA} ";
}

print_prompt(){
  local TIME="$(colorize 15 33)[$(date +%H:%M)] $(colorize 33 34)$RARS";
  local USER="$(colorize 15 34)\u@\h $(colorize 34 124)$RARS"
  local GIT="$(colorize 252 124) $(parse_git_branch_or_tag) $(colorize 124 240)$RARS"
  local DIR=" $(colorize 11 240)\w $(colorize 240 0)$RARS"
  local LEFT="$TIME$USER$GIT$DIR "
  local RIGHT="$DIR"
  local COMPENSATE=11
  PS1=$(printf "%*s\r%s\n$EMPTY\$$GRAY" "$(($(tput cols) - ${compensate}))" "$RIGHT" "$LEFT")
}


print_map(){
  if [ $OSTYPE = 'msys' ]; then
    #Background
    for clbg in {40..47} {100..107} 49 ; do
      #Foreground
      for clfg in {30..37} {90..97} 39 ; do
        #Formatting
        for attr in 0 1 2 4 5 7 ; do
          #Print the result
          echo -en "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
        done
        echo #Newline
      done
    done
  else
    for fgbg in 38 48 ; do #Foreground/Background
      for color in {0..256} ; do #Colors
        #Display the color
        echo -en "\033[${fgbg};5;${color}m ${color}\t\e[0m"
        #Display 10 colors per lines
        if [ $((($color + 1) % 10)) == 0 ] ; then
          echo #New line
        fi
      done
      echo #New line
    done
  fi
}

banner() {
  for i in {16..21} {23..27} {27..23} {21..16} ; do echo -en "\033[38;5;${i}m#" ; done ; echo
    echo -e "$LIGHTBLUE $1"
  for i in {16..21} {23..27} {27..23} {21..16} ; do echo -en "\033[38;5;${i}m#" ; done ; echo
}

# looks like the following:
# [hh:mm] username@host (git branch || svn revision) ~/working/directory
# $
if [ $OSTYPE = 'msys' ]; then
  export PROMPT_COMMAND='PS1="$($HISTORY_COMMAND) $(build_prompt_win)\n\$LA "'
else
  export PROMPT_COMMAND='PS1="$(history -a; history -c; history -r; build_prompt_unix)\n\$LA "'
fi

if ! [[ -f "${HOME}/.bash_logout" ]]; then
files_debug_log "setting up .bash_logout for privacy"
cat <<- EOF > ${HOME}/.bash_logout
  # when leaving the console clear the screen to increase privacy
  if [ "$SHLVL" = 1 ]; then
      [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
  fi
EOF
fi

