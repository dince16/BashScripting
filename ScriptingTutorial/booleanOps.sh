#!/bin/bash/

#boolean operations
if [ -r $1 ] && [ -s $1 ]
then
	echo This file is useful
else
	echo This file is not useful
fi
#we only want to perform an operation if the file is readable 
#and has a size greater than zero.