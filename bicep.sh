#!/bin/bash

print_usage ()
{
  usage="usage: bicep.sh <URI> [method] [path to request payload]"
  echo $usage
  exit 1
}

if [ $# -eq 0 ]; then
  print_usage
fi

uri=$1

method=$2
if [ -z "$method" ]; then
  method="GET"
fi

payload=""
if [ "$3" ]; then
  if [ -a "$3" ]; then
    payload=$(<$3)
  else
    echo "$3 does not exist"
    exit 2
  fi
fi

command="curl -s -X $method"
if [ "$payload" ]; then
  command="$command -d \"$payload\""
fi
command="$command $uri"

echo "$command"
$command
