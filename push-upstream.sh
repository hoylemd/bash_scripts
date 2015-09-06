#!/bin/bash

MYREMOTE=""
REPO_NAME=""
GITHUB_URL=""

source .fgrc

branch=$(git rev-parse --abbrev-ref HEAD)

ERROR_env_var_not_set="is not set. please set it in .fgrc"

remote=$MYREMOTE
if [ -z "$remote" ]; then
  echo "MYREMOTE not set, using origin"
  remote="origin"
fi

if [ -z "$GITHUB_URL" ]; then
  echo "GITHUB_URL $ERROR_env_var_not_set"
  exit 2
fi

push_cmd="git push -u $remote $branch"
$push_cmd

if [ $? -gt 0 ]; then
  echo "remote '$remote' does not exist. Attempting to create..."
  if [ -n "$REPO_NAME" ]; then
    ./addRemote.sh $remote
    $push_cmd
  else
    echo "No repository name set. Please edit the 'REPO_NAME' setting in .fgrc"
  fi
fi




