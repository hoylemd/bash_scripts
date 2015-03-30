#!/bin/bash

print_usage ()
{
  usage="Usage: smoke.sh [path to features] [number of runs]"
  echo $usage
  exit 1
}


# set path
features=$1
if [ -z $features ]; then
  features="features/"
fi

# parse / validate times
times=$2
if [ -z $times ]; then
  times=1
fi

# initialize reporting
failures=0
passes=0

# run test runs
for (( c=0; c<$times; c++ ))
do
  eval ./dofeature.sh $features
  if [ $? -gt 0 ]
  then
    failures=$((failures + 1))
  else
    passes=$((passes + 1))
  fi
done

# display report
echo Results
if [ $failures -gt 0 ]
then
  echo FAIL!!!!
  echo $failures of $times runs failed
else
  echo PASS!
  echo all $passes of $times runs passed
fi

