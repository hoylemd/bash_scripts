MYREMOTE=""
REPO_NAME=""
GITHUB_URL=""

source .fgrc

branch=$(git rev-parse --abbrev-ref HEAD)

if [ -z "$MYREMOTE" ]; then
  MYREMOTE=mhoyle
fi

if [ -z "$GITHUB_URL" ]; then
  echo "GITHUB_URL is not set in .fgrc. Please set it."
  exit 1
fi

push_cmd="git push -u $MYREMOTE $branch"
$push_cmd

if [ $? -gt 0 ]; then
  if [ -n "$REPO_NAME" ]; then
    ./add_remote.sh $MYREMOTE
    $push_cmd
  else
    echo "No repository name set. Please edit the 'REPO_NAME' setting in .fgrc"
  fi
fi




