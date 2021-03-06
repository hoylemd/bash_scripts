#! /bin/bash

GITHUB_URL=""
REPO_NAME=""

source .fgrc

usage="Usage: add_remote.sh <REMOTENAME>"
usage2="  <REMOTENAME>: name used in the url as well as the created remote"
no_github="GITHUB_URL environment variable not set. Add it to .fgrc"
no_repo_name="REPO_NAME environment variable not set."
no_repo_name2="Using current directory name for now."
no_repo_name3="You should add the repo name to .fgrc."

remote=$1

if [ -z "$remote" ]; then
  echo $usage
  echo $usage2
  exit 1
fi

if [ -z "$GITHUB_URL" ]; then
  echo $no_github
  exit 2
fi

if [ -z "$REPO_NAME" ]; then
  REPO_NAME=$(basename $PWD)
  echo "$no_repo_name"
  echo "$no_repo_name2 ($REPO_NAME)"
fi

if [ "$remote" == "origin" ]; then
  echo "Attempting to create origin remote, but this should be done manually."
  echo "  git remote add git@$GITHUB_URL:<origin_username>/$REPO_NAME\.git"
  exit 3
fi

git remote add $remote git@$GITHUB_URL:$remote/$REPO_NAME
git fetch $remote
code=$?

if [ $code -gt 0 ]; then
  echo 'Something went wrong. Checking your ssh-agent...'
  ssh-add -ls
  echo "Removing remote '$remote'"
  git remote remove $remote
  exit 5
fi
exit 0
