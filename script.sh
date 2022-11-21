#!/bin/zsh

list_file=()
show_size=5
arg_filename=$pwd
temp_filename="$(pwd)/$(echo $1)"

function list {
  # Using ls to transform files in arrays
  list_file=($arg_filename*(om[1,$show_size]))
  declare -i count=0

  print -DP "%B%F{red}$(print -D $arg_filename)%b%f:"

  # Display ls information
  local filename
  for i in "${list_file[@]}"
  do
    count+=1
    filename=$(echo "$i" | sed "s/.*\///")
    print -P "%B%F{yellow}[$count]%f%b %b$filename%b" | sed "s/.*\///"

    # echo "$count $i"
  done

}

function parse {
  local flag_help flag_show
  local sel_files
  local helper=( "[-h|--help]" "Blablabla")

  # Debugging info
  # echo "positional: $@"

  zmodload zsh/zutil
  zparseopts -D -F -K -- \
    {h,-help}=flag_help \
    {s,-show-all}=flag_show \
    {f,-filename}:=arg_filename ||
    return 1

  # Check help flag
  if [[ -n ${flag_help} ]]; then
    echo $helper
    exit 1
  fi

  if [[ -n ${flag_show} ]]; then
    show_size=100
  fi
  # Display list information in screen
  list

}

## Main

## Check if first argument is a valid directory in case that's not a flag

if ! [[ $1 == -* ]] && [[ -n $1 ]]; then
  if [[ $1 == \/* ]]; then
    arg_filename=$1/
    shift
  elif [[ -d $temp_filename ]]; then
    arg_filename=$temp_filename/
    shift
  else
    echo "$1: No such file or directory"
    exit 1
  fi
else
  arg_filename=$(pwd)/
fi

parse $@
##
