#!/bin/bash

source .fgrc

print_usage ()
{
  usage="usage multitest.sh <number of runs> [tests path]"
  echo $usage
  exit 1
}

# check that there are arguments
if [ $# -eq 0 ]; then
  print_usage
fi

# parse / validate times
if [ -z $1 ]; then
  print_usage
fi
times=$1

# parse / validate tests
tests=$2

# initialize reporting
failures=0
passes=0

# run test runs
for (( c=0; c<$times; c++ ))
do
  eval ./runtests $tests
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

