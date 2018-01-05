#!/bin/bash/

#if else statements
#Now we could easily read from a file if it is supplied as a command line argument, else read from STDIN.
if [ $# -eq 1 ]
then
	nl $1
else
	nl /dev/stdin
fi
#nl - The nl utility reads lines from the named file or the standard input if
     #the file argument is ommitted, applies a configurable line numbering fil-
     #ter operation and writes the result to the standard output.