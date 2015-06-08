REMOTE=$1
GITHUB_URL=""
REPO_NAME=""

source .fgrc

usage="Usage: add_remote.sh <REMOTENAME>"
usage2="  <REMOTENAME>: name used in the url as well as the created remote"
no_github="GITHUB_URL environment variable not set. Add it to .fgrc"

if [ -z "$REMOTE" ]; then
  echo $usage
  echo $usage2
  exit 1
fi

if [ -z "$GITHUB_URL" ]; then
  echo $no_github
  exit 2
fi

if [ -z "$REPO_NAME" ]; then
  REPO_NAME=basename $PWD
fi

git remote add $REMOTE git@$GITHUB_URL:$REMOTE/$REPO_NAME.git
git fetch $REMOTE

