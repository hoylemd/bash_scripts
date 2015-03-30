#!/bin/bash
md5file=./md5file.old

echo "-------------------------------------------------------"
echo "- Running cache script...                             -"
echo "-------------------------------------------------------"

MD5_current=$(cat Brocfile.js package.json bower.json Gemfile.lock Gemfile Gruntfile.js | md5sum | cut -d ' ' -f 1)
echo "Current md5 for configs: ${MD5_current}"

export PATH=$PATH:/usr/local/rvm/bin
/usr/local/rvm/bin/rvm use 2.0.0

cleanAll () {
  echo "Cleaning up old files..."
  npm cache clean
  npm run clean
}

if [ -e "$md5file" ]; then
    MD5_previous=$(cat $md5file)
    echo "Past md5 file found, md5: ${MD5_previous}"
    if [ "$MD5_current" != "$MD5_previous" ]; then
        echo "The directory was modified since the last run"
        cleanAll
        rm $md5file
        echo "Removed old md5file"
        echo $MD5_current > $md5file
        echo "Put new md5 into md5file"
    fi
else
    echo "Past md5 file not found"
    cleanAll
    echo $MD5_current > $md5file
    echo "Wrote current md5 into file"
fi

npm install

echo "-------------------------------------------------------"
echo "- Done cache script.                                  -"
echo "-------------------------------------------------------"
