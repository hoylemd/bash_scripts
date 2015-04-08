branch=$(git rev-parse --abbrev-ref HEAD)
git co master
git fetch origin
git merge mhoyle/master
git push origin
git co $branch
