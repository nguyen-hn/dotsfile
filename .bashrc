# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

export PATH="$PATH:/opt/nvim-linux64/bin"
export PATH="$PATH:/usr/local/go/bin"
export PATH="$PATH:~/workspace/Scripts/"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
#export FZF_DEFAULT_OPTS="--layout=reverse-list --multi --preview='[[ \$(file --mime {}) =~ binary ]] && echo {} is a binary file || (bat --style=numbers --color=always {} || cat {}) 2> /dev/null | head -300"
export FZF_DEFAULT_OPTS='--layout=reverse --inline-info'
#export FZF_DEFAULT_OPTS="-m --height 50% --layout=reverse --border"
export FZF_CTRL_T_OPTS="
    --walker-skip .git,node_modules,target
    --preview 'bat -n --color=always {}'
    --bind 'ctrl-/:change-preview-window(down|hidden|)'"
export FZF_COMPLETION_TRIGGER='~'
export FZF_COMPLETION_OPTS='--border --info=inline'
export FZF_COMPLETION_PATH_OPTS='--walker file,dir,follow,hidden'
RG_PREFIX="rg --column --line-number --no-heading --color=always --smart-case "
INITIAL_QUERY="${*:-}"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

function zodiac_sign() {
  lst_date=(120 218 320 420 521 621 722 823 923 1023 1122 1222 1231)
  lst_zodiac=(♑ ♒ ♓ ♈ ♉ ♊ ♋ ♌ ♍ ♎ ♏ ♐)
  DD=$(date +%d)
  MM=$(date +%m)
  temp=$((${MM#0}*100 + ${DD#0}))
  for i in "${!lst_date[@]}"; do
    if [ $temp -le "${lst_date[i]}" ]; then echo ${lst_zodiac[i]}; break; fi
  done
}

parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

git_info() {
    if [[ $(parse_git_branch) ]]; then
        printf ' \uf126'
        parse_git_branch
    fi
}

parse_git_bg() {
    [[ $(git status -s 2> /dev/null) ]] && echo -e "\e[43m" || echo -e "\e[42m"
}

FMT_BOLD="\[\e[1m\]"
FMT_DIM="\[\e[2m\]"
FMT_UNBOLD="\[\e[22m\]"
FMT_RESET="\[\e[0m\]"
FMT_UNDIM="\[\e[22m\]"
FG_BLACK="\[\e[30m\]"
FG_BLUE="\[\e[34m\]"
FG_CYAN="\[\e[36m\]"
FG_GREEN="\[\e[32m\]"
FG_GREY="\[\e[37m\]"
FG_MAGENTA="\[\e[35m\]"
FG_RED="\[\e[31m\]"
FG_WHITE="\[\e[97m\]"
BG_BLACK="\[\e[40m\]"
BG_BLUE="\[\e[44m\]"
BG_CYAN="\[\e[46m\]"
BG_GREEN="\[\e[42m\]"
BG_MAGENTA="\[\e[45m\]"
BG_RED="\[\e[41m\]"

# regular
COLOR_BLACK="$(echo -e "\033[30m")"
COLOR_RED="$(echo -e "\033[31m")"
COLOR_GREEN="$(echo -e '\033[32m')"
COLOR_YELLOW="$(echo -e "\e[33m")"
COLOR_BLUE="$(echo -e "\e[34m")"
COLOR_MAGENTA="$(echo -e "\e[35m")"
COLOR_CYAN="$(echo -e "\e[36m")"
COLOR_WHITE="$(echo -e "\e[37m")"
NO_COLOR="$(echo -e "\033[0m")"

# bold
COLOR_BRED="$(echo -e "\033[1;31m")"
COLOR_BGREEN="$(echo -e '\033[1;32m')"
COLOR_BYELLOW="$(echo -e "\e[1;33m")"
COLOR_BBLUE="$(echo -e "\e[1;34m")"
COLOR_BMAGENTA="$(echo -e "\e[1;35m")"
COLOR_BCYAN="$(echo -e "\e[1;36m")"
COLOR_BWHITE="$(echo -e "\e[1;37m")"

# italic
COLOR_IRED="$(echo -e "\033[3;31m")"
COLOR_IGREEN="$(echo -e "\033[3;32m")"
COLOR_IYELLOW="$(echo -e "\033[3;33m")"
COLOR_IBLUE="$(echo -e "\033[3;34m")"
COLOR_IMAGENTA="$(echo -e "\033[3;35m")"
COLOR_ICYAN="$(echo -e "\033[3;36m")"
COLOR_IWHITE="$(echo -e "\033[3;37m")"
COLOR_IBLACK="$(echo -e "\033[3;30m")"

# background
COLOR_BGRED="$(echo -e "\033[0;41m")"
COLOR_BGGREEN="$(echo -e "\033[0;42m")"
COLOR_BGYELLOW="$(echo -e "\033[0;43m")"
COLOR_BGBLUE="$(echo -e "\033[0;44m")"
COLOR_BGMAGENTA="$(echo -e "\033[0;45m")"
COLOR_BGCYAN="$(echo -e "\033[0;46m")"
COLOR_BGWHITE="$(echo -e "\033[0;47m")"



FG_WHITE="\[\e[97m\]"

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\[\033[0;31m\]'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Underline
UBlack='\033[4;30m'       # Black
URed='\033[4;31m'         # Red
UGreen='\033[4;32m'       # Green
UYellow='\033[4;33m'      # Yellow
UBlue='\033[4;34m'        # Blue
UPurple='\033[4;35m'      # Purple
UCyan='\033[4;36m'        # Cyan
UWhite='\033[4;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# High Intensity
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White

# Bold High Intensity
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\033[0;100m'   # Black
On_IRed='\033[0;101m'     # Red
On_IGreen='\033[0;102m'   # Green
On_IYellow='\033[0;103m'  # Yellow
On_IBlue='\033[0;104m'    # Blue
On_IPurple='\033[0;105m'  # Purple
On_ICyan='\033[0;106m'    # Cyan
On_IWhite='\033[0;107m'   # White

USER='\[${COLOR_GREEN}\]\[${NO_COLOR}\]\[${COLOR_BGGREEN}\]\[${COLOR_IBLACK}\] \u \[${NO_COLOR}\]\[${COLOR_GREEN}\]\[${COLOR_BGBLUE}\]\[${COLOR_GREEN}\]\[${NO_COLOR}\]'
HOST='\[${COLOR_BGBLUE}\]\[${COLOR_IWHITE}\] \h \[${NO_COLOR}\]\[${COLOR_BLUE}\]\[${COLOR_BGYELLOW}\]\[${COLOR_BLUE}\]\[${NO_COLOR}\]'
TIME='\[${COLOR_BGYELLOW}\]\[${COLOR_WHITE}\] ⏱ $(date +%H:%M) \[${NO_COLOR}\]\[${COLOR_BGWHITE}\]\[${COLOR_YELLOW}\]\[${NO_COLOR}\]'
LOCATION='\[${COLOR_BGWHITE}\] \[${COLOR_IBLACK}\]\w \[${NO_COLOR}\]\[${COLOR_WHITE}\]\]\[${NO_COLOR}\]'
ARROW='\[${COLOR_RED}\]→\[${NO_COLOR}\]'


#PS1='\[${COLOR_GREEN}\]\u${NO_COLOR} $(zodiac_sign) ${COLOR_YELLOW}\h${NO_COLOR} \[${COLOR_CYAN}\w${NO_COLOR}\]\n \[${COLOR_BLUE}\]\d\[${NO_COLOR}\]\[${COLOR_GREEN}\]$(parse_git_branch) → \[${NO_COLOR}\]'

#export PS1='\[${COLOR_GREEN}\]\[${NO_COLOR}\]\[${COLOR_IGREEN}\]\[${COLOR_BLACK}\]  \u \[${NO_COLOR}\] \h \w \n $(git_info) '

PS1='\[\e]2;\W\a\]'$USER$HOST$TIME$LOCATION' \n'$ARROW'\[${COLOR_IYELLOW}\]$(git_info)\[${NO_COLOR}\] '
#PS1='\033[1;32m\033[0m\033[0;42m\033[3;30m \u \033[0m\033[0;32m\033[0;44m\033[0m\033[0;44m\033[3;37m\h\033[0m\033[0;32m\033[0;47m\033[0m\
#\033[32m\033[3;47m\w\033[0m\033[1;37m\033[0m '

export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTIGNORE="&:ls:[bf]g:exit"
HISTCONTROL=ignoredups


#alias vim=nvim
alias home='cd ~'
alias mkdir='mkdir -p'
alias hs='history | grep '
alias ls='ls --color=auto --group-directories-first'
alias lsl='ls -lhFA | less'
alias du='du -Hs'
alias ff='find . -type f -name'
alias fd='find . -type d -name'
alias cls='printf "\033c"'
alias psg='ps aux | grep -v grep | grep -i -e VSZ -e'
alias myip="curl http://ipecho.net/plain; echo"
alias ..='cd ..'
alias ...='cd ../..'
alias 777='chmod -R 777'
alias checkcommand='type -t'
alias openports='netstat -nape --inet'
alias rebootsafe='sudo shutdown -r now'
alias rebootforce='sudo shutdown -r -n now'

# Alias's for multiple directory listing commands
alias la='ls -Alh' # show hidden files
alias lss='ls -aFh --color=always' # add colors and file type extensions
alias lx='ls -lXBh' # sort by extension
alias lk='ls -lSrh' # sort by size
alias lc='ls -lcrh' # sort by change time
alias lu='ls -lurh' # sort by access time
alias lr='ls -lRh' # recursive ls
alias lt='ls -ltrh' # sort by date
alias lm='ls -alh |more' # pipe through 'more'
alias lw='ls -xAh' # wide listing format
alias ll='ls -Fls' # long listing format
alias labc='ls -lap' #alphabetical sort
alias lf="ls -l | egrep -v '^d'" # files only
alias ldir="ls -l | egrep '^d'" # directories only
alias cd2="cd ../.."
alias cd3="cd ../../.."
alias cd4="cd ../../../.."
alias ls2="ls ../../"
alias ls3="ls ../../../"
alias ls4="ls ../../../../"
alias ws='cd ~/workspace'
alias algo='cd ~/workspace/Algorithms/'
alias tar_view='tar -tf '
alias fbat='fzf --preview "bat --color=always --style=numbers --line-range=:500 {}"'
alias open_port='netstat -tuln'
alias refresh_bash='source ~/.bashrc'

vim_tab() {
    vim -p $(git status -uno -s | awk '{print $2}')
}

duf() {
    du -sk "$@" | sort -n | while read size fname; do for unit in k M G T P E Z Y; do if [ $size -lt 1024 ]; then echo -e "${size}${unit}\t${fname}";break; fi;
    size=$((size/1024)); done; done;
}

most_use() {
    history | awk '{CMD[$2]++;count++;}END {for (a in CMD) print CMD[a] " " CMD[a]/count*100 " % " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl | head -n 10
}

history_run() {
    eval "$(fc -ln $1 $2)"
}

memory_usage() {
    free -m | awk 'NR==2{printf "Memory Usage: %s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2}'
    df -h | awk '$NF=="/"{printf "Disk Usage: %d/%dGB (%s)\n", $3,$2,$5}'
    top -bn1 | grep load | awk '{printf "CPU Load: %.2f\n", $(NF-2)}'
}

fawk() {
    first="awk '{printf "
    last="}'"
    cmd="${first}\$${1}${last}"
    eval $cmd
}

function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
    return 1
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

ftext() {
    # case-insensitive, ignore binary files, recursive serach, 
    grep -iIHrn --color=always "$1" . | less -r
}

# move and go to the directory
mvg() {
    if [ -d "$2" ];then
        mv $1 $2 && cd $2
    else
        mv $1 $2
    fi
}

# create and go to the directory
mkdirg() {
    mkdir -p $1
    cd $1
}

neofetch() {
    echo -e "\033[0;32muptime: \t$(uptime -p)\033[0m"
    echo -e "\033[0;34mdistro: \t$(cat /etc/os-release | grep PRETTY_NAME | awk -F'=' '{print $2}' | awk -F'"' '{print $2}')\033[0m"
    echo -e "\033[0;32mkernel: \t$(uname -a | awk 'match($0, "#1") {print substr($0, 1, RSTART-2)}') \033[0m"
    echo -e "\033[0;35mshell: \t\t$(bash --version | awk 'NR==1')\033[0m"
    echo -e "\033[0;33mcpu: \t\t$(lscpu | grep "Model name:" | sed -r 's/Model name: \s{1,}//g') \033[0m"
    echo -e "\033[0;36mdisk: \t\t$(free -h | grep Mem: | awk '{print $3  $2 }') \033[0" 
}

bat_diff() {
    git diff --name-only --relative --diff-filter=d -z | xargs -0 bat --diff
}

rgf() {
    rg --color=always --line-number --no-heading --smart-case "${*:-}" | 
        fzf --ansi --color "hl:-1:underline,hl+:-1:underline:reverse" --delimiter : \
        --preview 'bat --color=always {1} --highlight-line {2} ' \
        --preview-window 'right,50%,border-bottom,+{2}+3/3,~3' \
        --bind 'enter:become(nvim {1} +{2})'
}

# printf "\033]0;$*\007"

source ~/workspace/Scripts/devtool.sh
