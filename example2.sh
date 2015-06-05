# This is an example of branching

foo=""

if [ -z "$foo" ]; then
  foo="ananas"
fi

echo $foo

bar="red"

if [ -n "$bar" ]
then
  bar='purple'
fi

echo "$foo $bar"

git branch
cmd="git remote"
$cmd
