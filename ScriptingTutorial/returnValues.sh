#!/bin/bash/

#return values
print_something () {
	echo Hello $1
	return 5
}

print_something Mars
print_something Jupiter
echo The previous function has a return value of $?

#$? contains the return status of the previously run command or function