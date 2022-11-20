#!/bin/zsh

  local flag_help flag_list flag_recents
  local arg_filename=$(pwd)
  local arg_time=1440 arg_choose=1 arg_quant=1
  local usage=(
    "[-h|--help]"
    "[-v|--verbose] [-f|--filename=<file>] [<message...>]"
  )

zmodload zsh/zutil
zparseopts -D -F -K -- \
  {h,-help}:=flag_help \
  {s,-show-recents}:=flag_recents \
  {l,-list}l:=flag_list \
  {t,-time}:=arg_time \
  {c,-choose}:=arg_choose \
  {q,-quantity}:=arg_quant \
  {f,-filename}=arg_filename || return 1

echo "--help: $flag_help"
echo "--logs: $flag_logs"
echo "--list: $flag_list"
echo "--filename: $arg_filename"
echo "positional: $@"
