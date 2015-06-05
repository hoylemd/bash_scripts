MYREMOTE=""
REPO_NAME=""
GITHUB_URL="github.2ndsiteinc.com"

source .fgrc

branch=$(git rev-parse --abbrev-ref HEAD)

if [ -z "$MYREMOTE" ]; then
  MYREMOTE=mhoyle
fi

if [ -z "$GITHUB_URL" ]; then
  GITHUB_URL="github.2ndsiteinc.com"
fi

push_cmd="git push -u $MYREMOTE master"
eval $push_cmd

if [ $? -gt 0 ]; then
  if [ -n "$REPO_NAME" ]; then
    git remote add $MYREMOTE git@$GITHUB_URL:$MYREMOTE/$REPO_NAME
    $push_cmd
  else
    echo "No repository name set. Please edit the 'REPO_NAME' setting in .fgrc"
  fi
fi




