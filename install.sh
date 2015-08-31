#! /bin/bash

##
# Installer/updater script for my dev tools
#
# usage: ./install.sh <target directory>
#
# if <target directory doesn't exist, it will be created>
#
##

loc=$(pwd)
targetdir=$1

# script installer/updater
# params: source, destination
install () {
  src=$1 # source
  dest=$2 # destination

  ln -fs $src $dest
}

# git exclusion adder
# params: exclusion line to add
add_git_exclusion () {
  exclusion=$1 # exclusion line to add

  # check if the line already exists
  if ! grep -q $exclusion .git/info/exclude;
  then
    # append the line
    echo $exclusion >> .git/info/exclude
  fi
}

# make/cd into the target
if [ ! -d $targetdir ]; then
  mkdir $targetdir
fi
cd $targetdir

scripts="push-upstream.sh update.sh fg.sh go.sh runtests.sh add_remote.sh"
scripts="$scripts bicep.sh restart.sh tail.sh bg.sh"
renamed_scripts="install.sh"
all_scripts="$scripts $renamed_scripts"

for script in $scripts
do
  target="$loc/$script"
  install $target $script
done

for script in $renamed_scripts; do
  name="project-$script"
  target="$loc/$name"
  install $target $script
done

git init

for script in $all_scripts
do
  add_git_exclusion $script
done

add_git_exclusion ".fgrc"
add_git_exclusion "my.*"
add_git_exclusion "their.*"
add_git_exclusion "env"

if [ ! -e .fgrc ]; then
  cp $loc/.fgrc .
  vim .fgrc
fi

