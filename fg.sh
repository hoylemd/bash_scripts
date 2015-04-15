#!/bin/bash
ENV=""
SERVICENAME=""
INSTALLCMD=""
RUNCMD=""
set -x

source .fgrc

git co master
git fetch origin
git merge origin/master
if [ -n "$INSTALLCMD" ]; then
  $INSTALLCMD
fi

./go.sh
