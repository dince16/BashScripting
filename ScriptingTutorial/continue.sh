#!/bin/bash/

#continue
#we are using the loop to process a series of files but if we happen upon a 
#file which we don't have the read permission for we should not try to process it.
for value in $1/*
do
	if [ ! -r $value ]
	then
		echo $value not readable 1>&2
		continue
	fi
	cp $value $1/backup/
done