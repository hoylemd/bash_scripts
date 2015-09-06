#!/bin/bash
# script to push a branch to it's upstream repo
#
# usage:
# ./push-upstream.sh [<remote_name>]
#
# first, this script determines the upstream remote of the current branch
# if this branch has an upstream, it simply does a git push
# if this branch does not have an upstream, this script will attempt to set
# one.  The first place it will check for which remote to set as upstream is
# the first argument passed. If none is passed, the MYREMOTE environment
# variable will be checked. If that is not set, 'origin' will be used
# The script will then push the current branch to that remote, setting it as
# the branch's upstream.
# If the chosen remote does not exist, this script will attempt to create and
# fetch it. If this fails, the script will error out.

MYREMOTE=""
REPO_NAME=""
GITHUB_URL=""

source .fgrc

branch=$(git rev-parse --abbrev-ref HEAD)

ERROR_env_var_not_set="is not set. please set it in .fgrc"

# determine target remote
remote=$1
if [ ! "$remote" ]; then
  if [ ! "$MYREMOTE" ]; then
    remote=$MYREMOTE
  else
    remote="origin"
  fi
fi

# error out if we don't know where github is
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




