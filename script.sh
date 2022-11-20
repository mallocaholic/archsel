#!/bin/zsh

function debug {
  echo "You used $@"
}

function parse {
  local flag_help flag_list flag_recents
  local arg_filename=$(pwd)
  local arg_time=1440 arg_choose=1 arg_quant=1
  local usage=(
    "[-h|--help]"
    "[-v|--verbose] [-f|--filename=<file>] [<message...>]"
  )

  zmodload zsh/zutil
  zparseopts -D -F -K -- \
    {h,-help}=flag_help \
    {s,-show-recents}=flag_recents \
    {l,-list}=flag_list \
    {t,-time}:=arg_time \
    {c,-choose}:=arg_choose \
    {q,-quantity}:=arg_quant \
    {f,-filename}:=arg_filename ||
    return 1

  if [[ -n ${flag_help} ]]; then
    echo "help message"
    exit 1
  fi

  if [[ -n ${flag_list} ]]; then
    list_file=($(ls $filename -t))
    declare -i count=0

    for i in "${list_file[@]}"
    do
      count+=1
      echo "$count $i"
    done

    exit 1
  fi

  echo "--show-recents: $flag_recents"
  echo "--list: $flag_list"
  echo "--filename: $arg_filename"
  echo "positional: $@"

}

parse "$@"
