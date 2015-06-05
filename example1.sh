# This is a comment
# Wow such utility

foo="foo"
bar=bar
num=5
othernum=7

biz = 7 # no good! tries to run the 'biz' command.

baz=$foo$bar
echo $baz
echo $foo$num
echo $num$othernum

echo $foo baz

echo $((num+othernum))


