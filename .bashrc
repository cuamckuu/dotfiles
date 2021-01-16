# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# `cd --` to show history `cd -0` to select dir
cd_func ()
{
  local x2 the_new_dir adir index
  local -i cnt

  if [[ $1 ==  "--" ]]; then
    dirs -v
    return 0
  fi

  the_new_dir=$1
  [[ -z $1 ]] && the_new_dir=$HOME

  if [[ ${the_new_dir:0:1} == '-' ]]; then
    #
    # Extract dir N from dirs
    index=${the_new_dir:1}
    [[ -z $index ]] && index=1
    adir=$(dirs +$index)
    [[ -z $adir ]] && return 1
    the_new_dir=$adir
  fi

  #
  # '~' has to be substituted by ${HOME}
  [[ ${the_new_dir:0:1} == '~' ]] && the_new_dir="${HOME}${the_new_dir:1}"

  #
  # Now change to the new dir and add to the top of the stack
  pushd "${the_new_dir}" > /dev/null
  [[ $? -ne 0 ]] && return 1
  the_new_dir=$(pwd)

  #
  # Trim down everything beyond 11th entry
  popd -n +11 2>/dev/null 1>/dev/null

  #
  # Remove any other occurence of this dir, skipping the top of the stack
  for ((cnt=1; cnt <= 10; cnt++)); do
    x2=$(dirs +${cnt} 2>/dev/null)
    [[ $? -ne 0 ]] && return 0
    [[ ${x2:0:1} == '~' ]] && x2="${HOME}${x2:1}"
    if [[ "${x2}" == "${the_new_dir}" ]]; then
      popd -n +$cnt 2>/dev/null 1>/dev/null
      cnt=cnt-1
    fi
  done

  return 0
}

alias cd=cd_func

stty -ixon

alias is_vim="tty;ps | grep vim"
export EDITOR=vim

alias ls="ls --color=auto"
alias ll="ls -lahG --color=auto"

upto ()
{
  if [ -z "$1" ]; then
      return
  fi
  local upto=$1
  cd "${PWD/\/$upto\/*//$upto}"
}

_upto()
{
  local cur=${COMP_WORDS[COMP_CWORD]}
  local d=${PWD//\//\ }
  COMPREPLY=( $( compgen -W "$d" -- "$cur" ) )
}
complete -F _upto upto

jd(){
    if [ -z "$1" ]; then
        echo "Usage: jd [directory]";
        return 1
    else
        cd **"/$1"
    fi
}

alias pm="python -m"

alias gs='git status'
alias ga='git add'
alias gb='git br'
alias gbc='git brc'
alias gc='git commit'
alias gd='git diff'
alias gds='git diff --staged'
alias gco='git checkout '

alias :e='vim'

for x in {a..z}
do
    eval "alias q$x='REGISTER=$x source macro'"
done

howin () {
  curl "cheat.sh/$1"
}

putstate () {
  declare +x >~/environment.tmp
  declare -x >>~/environment.tmp
  echo cd "$PWD" >>~/environment.tmp
}

getstate () {
  . ~/environment.tmp
}

my_ngrok() {
  if [ $# -eq 0 ]
  then
      echo "Usage: 'my_ngrok <local_port> [<remote_port>]";
      echo "";
      echo "Do on remote host:";
      echo "$ vim /etc/ssh/sshd_config # GatewayPorts yes";
      echo "$ systemctl restart sshd";
      return 1;
  fi

  if [ $# -eq 1 ]
  then
      LOCAL=$1;
  fi

  REMOTE="1234";
  if [ $# -eq 2 ]
  then
      REMOTE=$2;
  fi

  IP="45.132.18.75";
  USER="root";

  echo "Forwarding http://$IP:$REMOTE to http://localhost:$LOCAL";
  echo "Press Ctrl-C to stop...";

  ssh -R $REMOTE:localhost:$LOCAL -N $USER@$IP
}

alias viclip='cat /dev/clipboard | vipe | cat > /dev/clipboard'
alias clone='mintty -D -e "/bin/bash" -c "cd \"$(pwd)\"; bash"'
