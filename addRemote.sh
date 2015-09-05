#! /bin/bash

GITHUB_URL=""
REPO_NAME=""

source .fgrc

remote=$1

git remote add $remote git@$GITHUB_URL:$1/$REPO_NAME
code=$?
if [ $code -gt 0 ]; then
  echo "failed add $code"
  exit 1
fi

git fetch $remote
code=$?
if [ $code -gt 0 ]; then
  ~/bash-scripts/createRepo.sh
  git fetch $remote
  ccode=$?
  if [ $ccode -gt 0 ]; then
    echo "failed fetch($code) and create($ccode)"
    git remote remove $remote
    exit 1
  fi
fi

