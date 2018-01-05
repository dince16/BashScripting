#!/bin/bash/

#variable scope
var_change () {
	local var1='local 1'
	echo Inside Function: var1 is $var1 : var2 is $var2
	var1='changed again'
	var2='2 changed again'
}

var1='global 1'
var2='global 2'

echo Before function call: var1 is $var1 : var2 is $var2

var_change
echo After function call: var1 is $var1 : var2 is $var2
#output:
#Before function call: var1 is global 1 : var2 is global 2
#Inside Function: var1 is local 1 : var2 is global 2
#After function call: var1 is global 1 : var2 is 2 changed again