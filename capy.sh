#!/bin/bash

print_usage ()
{
  usage="Usage: capy.sh <path to features> [number of runs]"
  echo $usage
  exit 1
}

# check that there are arguments
if [ $# -eq 0 ]; then
  print_usage
fi

# parse / validate features
if [ -z $1 ]; then
  print_usage
fi
features=$1

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

