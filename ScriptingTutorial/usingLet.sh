#!/bin/bash/

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