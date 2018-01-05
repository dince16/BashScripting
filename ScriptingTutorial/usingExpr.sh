#!/bin/bash/

#using expr
#./variables.sh 12 - the terminal call to execute this
expr 5 + 4 #9

expr "5 + 4" #5 + 4

expr 5+4 #5+4

expr 5 \* $1 #60

expr 11 % 2 #1

a=$( expr 10 - 3 ) #no output
echo $a #7