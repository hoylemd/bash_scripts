#!/bin/bash

TESTCMD=""
TESTEXCLUDE=""
TESTPATH=""

source .fgrc

test_path=$TESTPATH
if [ -n "$1" ]; then
  test_path=$1
fi

if [ -n "$TESTCMD" ]; then
  $TESTCMD $TESTEXCLUDE $test_path
fi
