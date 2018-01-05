#!/bin/bash/

#nested if statements
#./variables.sh 150 - terminal input
if [ $1 -gt 100 ]
then
	echo Hey that\'s a large number.
	if (( $1 % 2 == 0 ))
	then
		echo And is also an even number
	fi
fi