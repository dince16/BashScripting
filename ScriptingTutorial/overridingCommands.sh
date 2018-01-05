#!/bin/bash/

#Overriding Commands
#if we want to really call 'ls -lh' everytime we call ls, 
#create a wrapper around the command like this
ls () {
	command ls -lh
}

ls