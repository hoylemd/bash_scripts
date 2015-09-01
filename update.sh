INSTALLCMD=""
MYREMOTE=""

source .fgrc

branch=$(git rev-parse --abbrev-ref HEAD)

if [ -z "$MYREMOTE" ]; then
  MYREMOTE=mhoyle
fi

git co -q master

# make sure all keys are added
keys=$(ls ~/.ssh | grep -e ".*_rsa$")
ssh_list=$(ssh-add -l)
result=$?
if [ $result -gt 0 ]; then
  echo "ssh-agent is not running. Please start it now."
  exit 1
else
  added=$(echo "$ssh_list" | sed -rn 's/.*\.ssh\/([a-zA-Z0-9_-]+) \(RSA\)/\1/p')
fi

me=$(whoami)
for key in $keys; do
  # check if this key exists
  if [ ! $(echo "$added" | grep $key) ]; then
    echo "rsa key $key is missing from agent adding it."
    ssh-add "/home/$me/.ssh/$key"
  fi
done

git fetch origin
if [ $? -gt 0 ]; then
  exit 2
fi

git merge origin/master
if [ $? -gt 0 ]; then
  exit 3
fi

./push-upstream.sh

git co $branch

if [ "$1" ]; then
  if [ "-r" == "$1" ]; then
    git rebase master
  fi
fi

./install.sh
