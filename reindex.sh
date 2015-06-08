CONFIGPATH='/home/fresh/my.cnf'
set -x

if [ ! -e "$CONFIGPATH" ]; then
  touch $CONFIGPATH
fi

mysql --defaults-file=$CONFIGPATH -e "show databases;" | grep '\(\(live[0-9]\{0,\}\)\|\(dev\)\) ' > databases.txt
cat databases.txt

query='SELECT systemid FROM {}.system WHERE modern_system=2;'

cat databases.txt | xargs -P 3 -I {} mysql --defaults-file=$CONFIGPATH -e $query | grep '[1-9]\{1,\}' > systemids.txt

cat systemids.txt
