INSTALLCMD=""

source .fgrc

branch=$(git rev-parse --abbrev-ref HEAD)

git co master
git fetch origin
git merge origin/master
git push mhoyle

git co $branch

if [ -n "$INSTALLCMD" ]; then
  $INSTALLCMD
fi
