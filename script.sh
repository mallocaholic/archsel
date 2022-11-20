#!/bin/zsh

function list {
  # Using ls to transform files in arrays
  local list_file=($(ls -tr $arg_filename))
  declare -i count=0

  print -DP "%B%F{red}$(print -D $arg_filename)%b%f:"

  for i in "${list_file[@]}"
  do
    count+=1
    print -P "%B%F{yellow}[$count]%f%b %b$i%b"
    # echo "$count $i"
  done
}

function parse {
  local flag_help flag_list flag_recents
  local arg_time=1440 arg_choose=1 arg_quant=1
  local usage=(
    "[-h|--help]"
  )

  echo "positional: $@"

  zmodload zsh/zutil
  zparseopts -D -F -K -- \
    {h,-help}=flag_help \
    {s,-show-recents}=flag_recents \
    {f,-filename}:=arg_filename ||
    return 1

  if [[ -n ${flag_help} ]]; then
    echo "help message"
    exit 1
  fi

  list

  echo "--show-recents: $flag_recents"
  echo "--list: $flag_list"
  echo "--filename: $arg_filename"

}

## Main

## Check if first argument is a dir
arg_filename=$pwd
temp_filename="$(pwd)/$1"

if [[ -d $temp_filename ]] && [[ -n $1 ]];
then
  arg_filename=$temp_filename
  shift
  parse "$@"
else
  arg_filename=$pwd
  echo "Not a dir"
  parse "$@"
fi
