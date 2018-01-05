#!/bin/bash/

#basics
if [ $1 -gt 100 ]
	then
	echo Hey that\'s a large number.
	pwd
fi

date
#input- './variables.sh 15' ----> output- 'Wed May 31 16:37:43 PDT 2017'
#input- './variables.sh 150' ----> output- 'Hey that's a large number. \n /Users/danielleince/desktop \n Wed May 31 16:38:37 PDT 2017'