#!/bin/bash

MYREMOTE=""
GITHUB_URL=""
REPO_NAME=""

source .fgrc

payload="{\"name\":\"$REPO_NAME\"}"

result=$(curl -u "$MYREMOTE" https://api.$GITHUB_URL/user/repos -d "$payload")
code=$?

echo "code: $code"
echo "result"
echo "======"
echo "$result"

