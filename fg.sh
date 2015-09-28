#!/bin/bash

echo 'Updating'
out=$(./update.sh)

if [ $? -eq 0 ]; then
  echo 'Running'
  ./go.sh
fi
