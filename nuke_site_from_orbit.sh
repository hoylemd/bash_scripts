#!/bin/bash
nuke_dir() {
  if [ -z "$1" ]; then
    echo "I can't nuke nothing, cap'n!"
    exit 1
  fi
  if [ ! -d "$1" ]; then
    echo "I can't nuke something that ain't a directory, cap'n!"
    exit 2
  fi

  for i in $( ls $1 ); do
    if [ "$i" == "screenshots" ]; then
      nuke_dir $1/$i
    else
      nuke_path="$1/$i"
      echo "BOOM! $nuke_path is vapor!"
      rm -rf $nuke_path
    fi
  done
}

echo "Nuking $1 from orbit..."
nuke_dir $1
echo "It's the only way to be sure..."
