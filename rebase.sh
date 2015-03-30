branch=$(git rev-parse --abbrev-ref HEAD)
git co master
git fetch upstream
git merge upstream/master
git push origin
git co $branch
git rebase master
