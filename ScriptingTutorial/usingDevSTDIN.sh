#!/bin/bash/

#using /dev/stdin
#must populate salesdata.txt using vi first!!
#cat salesdata.txt | ./variables.sh - the terminal call to execute this properly
echo Here is a summary of the sales data:
echo ====================================

cat /dev/stdin | cut -d' ' -f 2,3 | sort