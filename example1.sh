# This is a comment
# Wow such utility

foo="foo"
bar=bar
num=5
othernum=7
escaped="\$5$othernum"
very_escaped='\$5'

biz = 7 # no good! tries to run the 'biz' command.

baz=$foo$bar
echo $baz

echo $foo$num
echo $num$othernum
echo $escaped
echo $very_escaped

echo $foo baz

echo $((num+othernum))


