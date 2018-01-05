#!/bin/bash/

#if elif else statements
if [ $1 -ge 18 ]
then
	echo You may go to the party.
elif [[ $2 == 'yes' ]] 
then
	echo You may go to the party but be back before midnight.
else
	echo You may not go to the party.
fi
#acceptable input
#./variables.sh 17 yes ---> You may go to the party but be back before midnight
#./variables.sh 19 ---> You may go to the party.
#./variables.sh 11 ---> You may not go to the party