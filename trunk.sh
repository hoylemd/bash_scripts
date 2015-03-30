times=$1
failures=0
passes=0
for (( c=0; c<$times; c++ ))
do
  eval bundle exec cucumber -p trunk --tag ~@skip --tag ~@unstable -r features $2
  if [ $? -gt 0 ]
  then
    failures=$((failures + 1))
  else
    passes=$((passes + 1))
  fi
done

echo Results
if [ $failures -gt 0 ]
then
  echo FAIL!!!!
  echo $failures of $times runs failed
else
  echo PASS!
  echo all $passes of $times runs passed
fi

