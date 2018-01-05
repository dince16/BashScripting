#!/bin/bash/

#                           VARIABLES

myVar=4
my2Var=6
my3Var=($myVar+$my2Var)

echo $my3Var

#************************************************************

#                             INPUTS

#using read
echo Hello, who am I talking to?
 read varName

echo Its nice to meet you $varName
#-------------------------------------------------
#understanding -p and -sp
read -p 'Username: ' userVar
read -sp 'Password: ' passVar

echo
echo Thank you $userVar we now have your login details

echo Password: $passVar
#-------------------------------------------------
#reading multiple values divided by spaces
echo What cars do you like?

read car1 car2 car3

echo Your first car was: $car1
echo Your second car was: $car2
echo Your third car was: $car3
#-------------------------------------------------
#using /dev/stdin
#must populate salesdata.txt using vi first!!
#cat salesdata.txt | ./variables.sh - the terminal call to execute this properly
echo Here is a summary of the sales data:
echo ====================================

cat /dev/stdin | cut -d' ' -f 2,3 | sort

#************************************************************

#                           ARITHMATIC

#using let
#./variables.sh 15 - the terminal call to execute this (for last let statement)
let a=4+5
echo $a #9

let "a = 4 + 5"
echo $a #9

let a++
echo $a #10

let "a = 4 * 5"
echo $a #20

let "a = $1 + 30"
echo $a #30 + first command line argument
echo $1
#-------------------------------------------------
#using expr
#./variables.sh 12 - the terminal call to execute this
expr 5 + 4 #9

expr "5 + 4" #5 + 4

expr 5+4 #5+4

expr 5 \* $1 #60

expr 11 % 2 #1

a=$( expr 10 - 3 ) #no output
echo $a #7
#-------------------------------------------------
#using double parenthese
a=$(( 4 + 5 ))
echo $a #9

a=$((3+5))
echo $a #8

b=$(( a + 3 ))
echo $b #11

b=$(( a + 4 ))
echo $b #12

(( b++ ))
echo $b #13

(( b += 3 ))
echo $b #16

a=$(( 4 * 5 ))
echo $a #20
#-------------------------------------------------
#calculating the length of a variable
a='Hello World'
echo ${#a} #11

b=4953
echo ${#b} #4

#************************************************************

#                         IF STATEMENTS

#basics
if [ $1 -gt 100 ]
	then
	echo Hey that\'s a large number.
	pwd
fi

date
#input- './variables.sh 15' ----> output- 'Wed May 31 16:37:43 PDT 2017'
#input- './variables.sh 150' ----> output- 'Hey that's a large number. \n /Users/danielleince/desktop \n Wed May 31 16:38:37 PDT 2017'
#-------------------------------------------------
#TestCommandInTerminal.txt
#-------------------------------------------------
#nested if statements
#./variables.sh 150 - terminal input
if [ $1 -gt 100 ]
then
	echo Hey that\'s a large number.
	if (( $1 % 2 == 0 ))
	then
		echo And is also an even number
	fi
fi
#-------------------------------------------------
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
#-------------------------------------------------
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
#-------------------------------------------------
#boolean operations
if [ -r $1 ] && [ -s $1 ]
then
	echo This file is useful
else
	echo This file is not useful
fi
#we only want to perform an operation if the file is readable 
#and has a size greater than zero.
#-------------------------------------------------
#case statements
case $1 in
	start)
		echo Starting
		;;
	stop)
		echo Stopping
		;;
	restart)
		echo restarting
		;;
	*)
		echo '¯\_(ツ)_/¯'
esac

#************************************************************

#                             LOOPS

#basic while loop
counter=1
while [ $counter -le 10 ]
do
	echo $counter
	((counter++))
done

echo All done!
#-------------------------------------------------
#basic until loop
counter=1
until [ $counter -gt 10 ]
do 
	echo $counter
	((counter++))
done

echo All done!
#the point of having two very similar loops is to help increase
#readabity of code (use the loop that makes the most sense in context)
#-------------------------------------------------
#for loops
names='Stan Kyle Cartman'

for name in $names
do
	echo $name
done 

echo All done!
#-------------------------------------------------
#ranges
for value in {1..5}
do
	echo $value
done

echo All done!
#-------------------------------------------------
#basic range with steps for loop
for value in {10..0..2}
do
	echo $value
done

echo All done!
#DOESNT WORK!!!
#should output 10 to 0 with a step of 2 but just outputs '{10..0..2}'
#-------------------------------------------------
#using a wildcard
for value in $1/*.html
do
	cp $value $1/$( basename -s .html $value ).php
done
#* - a wildcard, used to select all files of a certain type.  Ex all html files
#DIDNT RUN JUST AN EXAMPLE!!!
#-------------------------------------------------
#break
#we are copying files but if the free disk space 
#get's below a certain level we should stop copying
for value in $1/*
do
	used=$( df $1 | tail -1 | awk '{ print $5 }' | sed 's/%//' )
	if [ $used -gt 90 ]
	then 
		echo Low disk space 1>&2
		break
	fi
	cp $value $1/backup/
done
#-------------------------------------------------
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
#-------------------------------------------------
#select (menus)
names='Kyle Cartman Stan Quit'

PS3='Select character: '

select name in $names
do
	if [ $name == 'Quit' ]
		then
		break
	fi
	echo Hello $name
done

echo Bye
#-------------------------------------------------

#                        FUNCTIONS
print_something () {
	echo Hello I am a function
}

print_something
print_something
#pick function names that are obvious and descriptive
#-------------------------------------------------
#passing arguments
print_something () {
	echo Hello $1
}

print_something Mars
print_something Jupiter
#-------------------------------------------------
#return values
print_something () {
	echo Hello $1
	return 5
}

print_something Mars
print_something Jupiter
echo The previous function has a return value of $?

#$? contains the return status of the previously run command or function
#-------------------------------------------------
#return values pt1
lines_in_file () {
	cat $1  wc -l
}

num_lines=$( lines_in_file $1 )

echo The file $1 has $num_lines lines in it
#-------------------------------------------------
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
#-------------------------------------------------
#Overriding Commands
#if we want to really call 'ls -lh' everytime we call ls, 
#create a wrapper around the command like this
ls () {
	command ls -lh
}

ls
#-------------------------------------------------

#-------------------------------------------------

#-------------------------------------------------

#-------------------------------------------------

#-------------------------------------------------

#-------------------------------------------------


