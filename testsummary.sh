#! /bin/bash
TESTCMD=""
TESTSUMFLAGS=""
TESTPATH=""

TEMPPATH="/tmp/testsummary.txt"

source .fgrc

path="$1"

if [ -z "$path" ]; then
  path="$TESTPATH"
fi

$TESTCMD $TESTSUMFLAGS $path &> $TEMPPATH
cat $TEMPPATH | grep "\.\.\. \(ok\)\|\(FAILED\)\|\(ERROR\)$"
rm $TEMPPATH
