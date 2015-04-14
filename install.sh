#! /bin/bash

loc=$(pwd)
cd $1

# script installer/updater
# params: source, destination
install () {
  echo installing $1 to $2
  ln -fs $1 $2

  return 0
}

for script in "update.sh" "rebase.sh" "fg.sh"
do
  echo $loc
  target="$loc/$script"
  install $target $script
done

if [ ! -e .fgrc ]; then
  cp $loc/.fgrc .
fi

for script in "update.sh" "rebase.sh" "fg.sh" ".fgrc" "my.*"
do
  echo $script >> .git/info/exclude
done

vim .fgrc
