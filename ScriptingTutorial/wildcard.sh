#!/bin/bash

#using a wildcard
for value in $1/*.html
do
	cp $value $1/$( basename -s .html $value ).php
done
#* - a wildcard, used to select all files of a certain type.  Ex all html files
#DIDNT RUN JUST AN EXAMPLE!!!