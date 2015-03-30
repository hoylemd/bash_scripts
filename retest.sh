#!/bin/bash

fail_count=0
pass_count=0
test_count=0
features=()
failures=()
output="my.retest_fails.txt"

print_usage ()
{
  usage="Usage: retest.sh <path_to_list_of_features>"
  echo $usage
  exit 1
}

print_still_failing ()
{
  failures=$1
  echo "" > $output
  for i in "${failures[@]}"
  do
    :
    echo "  " $i
    echo $i >> $output
  done
}

fail_list=$1
if [ -z $fail_list ]; then
  fail_list=$output
fi

while read p; do
  features+=($p)
  test_count=$((test_count + 1))
done < $fail_list

for i in "${features[@]}"
do
  :
  eval ./dofeature.sh $i
  if [ $? -gt 0 ]
  then
    fail_count=$((fail_count + 1))
    failures+=($i)
  else
    pass_count=$((pass_count + 1))
  fi
done

# display report
echo Results
if [ $fail_count -gt 0 ]
then
  echo FAIL!!!!
  echo $fail_count of $test_count features failed
  echo The following features are still failing:
  print_still_failing $failures
else
  echo PASS!
  echo all $pass_count of $test_count features passed
fi

