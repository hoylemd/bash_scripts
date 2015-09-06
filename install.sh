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
FALSE=""
TRUE="TRUE"

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

# set up a repo
set_up_repo () {
  git init
  echo "readme" > README.md
  git add README.md
  git commit -m "initial commit"
}

# make/cd into the target
setup=$FALSE
if [ ! -d $targetdir ]; then
  setup=$TRUE
  mkdir $targetdir
fi
cd $targetdir

scripts="push-upstream.sh update.sh fg.sh go.sh runtests.sh addRemote.sh"
scripts="$scripts bicep.sh restart.sh tail.sh bg.sh prod.sh"
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

if [ ! -e .fgrc ]; then
  cp $loc/.fgrc .
  vim .fgrc
fi
source .fgrc

project_name=""
code=0
if [ "$MYREMOTE" ] && [ "$REPO_NAME" ] && [ "$GITHUB_URL" ]; then
  # check connectivity
  ping -c 1 $GITHUB_URL
  ping_code=$?

  # check if this is already a repo
  git status -s
  project_name=$REPO_NAME
  # if git status indicates no repo
  if [ $? -gt 0 ]; then
    # if we have internet connection
    if [ $ping_code -eq 0 ]; then
      git clone git@$GITHUB_URL:$MYREMOTE/$REPO_NAME.git
      # if remote repo doesn't exist
      if [ $? -gt 0 ]; then
        set_up_repo
        ~/bash_scripts/createRepo.sh $project_name
        ./push-upstream.sh
      fi
    # set it up offline
    else
      set_up_repo
    fi
  fi
# if there isn't remote info
else
  git status -s
  # if no repo
  if [ $? -gt 0 ]; then
    set_up_repo
  fi
fi

for script in $all_scripts
do
  add_git_exclusion $script
done

add_git_exclusion ".fgrc"
add_git_exclusion "my.*"
add_git_exclusion "their.*"
add_git_exclusion "env"

if [ "$ENV" ]; then
  if [ ! -d $ENV ]; then
    virtualenv $ENV
  fi
fi
