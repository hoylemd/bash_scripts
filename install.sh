#! /bin/bash

loc=$(pwd)
cd $1

# script installer/updater
# params: source, destination
install () {
  ln -fs $1 $2
  return 0
}

add_git_exclusion () {
  if ! grep -q $1 .git/info/exclude;
  then
    echo $1 >> .git/info/exclude
  fi
}

scripts=()
scripts+=("push-upstream.sh")
scripts+=("update.sh")
scripts+=("fg.sh")
scripts+=("go.sh")
scripts+=("runtests.sh")
scripts+=("add_remote.sh")
scripts+=("bicep.sh")

for script in "${scripts[@]}"
do
  target="$loc/$script"
  install $target $script
done

for script in "${scripts[@]}"
do
  add_git_exclusion $script
done
add_git_exclusion ".fgrc"
add_git_exclusion "my.*"
add_git_exclusion "env"

if [ ! -e .fgrc ]; then
  cp $loc/.fgrc .
  vim .fgrc
fi

