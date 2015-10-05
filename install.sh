#! /bin/bash

loc=$(pwd)
cd $1

# script installer/updater
# params: source, destination
install () {
  src=$1 # source
  dest=$2 # destination

  ln -fs $src $dest
}

add_git_exclusion () {
  exclusion=$1 # path to exclude

  if ! grep -q $exclusion .git/info/exclude;
  then
    echo $exclusion >> .git/info/exclude
  fi
}

scripts="push-upstream.sh update.sh fg.sh go.sh runtests.sh addRemote.sh"
scripts="$scripts bicep.sh restart.sh tail.sh bg.sh rebase.sh autoexec.sh"
scripts="$scripts back.sh"
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
add_git_exclusion "env"
