#! /bin/bash

GITHUB_URL=""
REPO_NAME=""

source .fgrc

remote=$1
# check environment and params

git remote add $remote git@$GITHUB_URL:$1/$REPO_NAME
result=$(git fetch $remote)
if [ $? ]; then
  echo "Remote add failed: $result"
  exit 1
fi

