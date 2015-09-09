#! /bin/bash

##
# Installer/updater script for my dev tools
#
# usage: ./install.sh <target directory>
#
# if <target directory doesn't exist, it will be created>
#
##

# set up a repo
# params: targetdir
set_up_repo () {
  targetdir=$1
  if [ ! -d $targetdir ]; then
    mkdir $targetdir
  fi
  cd $targetdir
  echo "setting up repo"
  git init
  echo "readme" > README.md
  git add README.md
  git commit -m "initial commit"
}

# make a json key-value pair
# params: key, value
json_key_value () {
  key="$1"
  value="$2"
  string="\"$key\": \"$value\""
  echo "$string"
}

loc=$(pwd)
targetdir=$1
project_name=$2
FALSE=""
TRUE="TRUE"

if [ -z "$project_name" ]; then
  project_name=$(basename $targetdir)
fi

# get the directory set up
if [ -d $targetdir ]; then
  echo "$targetdir already exist, skipping creation"
else
  echo "no directory"

  if [ ! -e "~/.fgrc" ]; then
    cp ~/bash_scripts/.fgrc ~/.fgrc
  fi

  source ~/.fgrc

  # check connectivity
  ping -c 1 -t 15 -q $GITHUB_URL

  # if we have internet connection
  if [ $? -eq 0 ]; then
    echo "cloning"
    git clone git@$GITHUB_URL:$MYREMOTE/$project_name $targetdir
    # if remote repo doesn't exist
    if [ $? -gt 0 ]; then
      set_up_repo $targetdir
      ~/bash_scripts/createRepo.sh $project_name
      ./push-upstream.sh
    fi
  # set it up offline
  else
    echo "set up offline"
    set_up_repo $targetdir
  fi

  cd $targetdir
  cp $loc/.fgrc .

  # check that stemp is available
  if [ ! -e ~/stemp/stemp.py ]; then
    cd ~
    git clone git@$GITHUB_URL:$MYREMOTE/Stemp stemp
  fi

  if [ -e ~/stemp/stemp.py ]; then
    # ready the values!

    if [ -z "$project_name" ]; then
      PWD=$(pwd)
      project_name=$(basename $PWD)
    fi

    remote_value=$(json_key_value "MYREMOTE" "hoylemd")
    github_value=$(json_key_value "GITHUB_URL" "github.com")
    repo_value=$(json_key_value "REPO_NAME" "$project_name")
    values="{$remote_value, $github_value, $repo_value}"
    echo $values > /tmp/fgrc_values
    python ~/stemp/stemp.py /tmp/fgrc_values -i $loc/fgrc.stemp -o .fgrc
  fi

  vim .fgrc
  source .fgrc

  git remote add $MYREMOTE git@$GITHUB_URL:$MYREMOTE/$project_name
fi

#cd $loc
#./install.sh $targetdir
