branch=$(git rev-parse --abbrev-ref HEAD)
git co master
git fetch origin
git merge mhoyle/master
git push mhoyle
git co $branch
