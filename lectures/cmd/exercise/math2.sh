#!/bin/bash

# Simple mathematics

# Define our addition function
function addition () {
	let result=$v1+$v2
}

# Define our subtraction function
function subtraction () {
	let result=$v1-$v2
}

# Define our multiplication function
function multiplication () {
	let result=$v1*$v2
}

# Define our subtraction function
function division () {
	# bash only knows integers but not floating point math
	# workaround: by echoing our division to the "bc" utility (note the command substitution here!), we can do floating point math as well
	result=$(echo "scale=2; $v1/$v2" | bc)
}

# Initialize stop to be 0; 
# we need this variable as a stop-condition for the while loop below!
stop=0

# Until the value of $stop equals zero we run the while loop
while [ $stop -eq 0 ]; do

	# clear the screen
	clear

	# Echo calculator instructions so the user knows what to do
	# "read ..." assigns the entered values to variables $v1 and $v2
	echo "Enter type of operation (add, sub, mul, div):"
	read type
	echo
	echo "Enter first value"
	read v1
	echo
	echo "Enter second value"
	read v2
	echo 

	# depending on the type of operation we call the right function and pass it the variables $v1 and $v2
	case $type in

		add)
			addition $v1 $v2
		;;
		
		sub)
			subtraction $v1 $v2
		;;
		
		mul)
			multiplication $v1 $v2
		;;
		
		div)
			division $v1 $v2
		;;
		
	esac
	
	echo "The result is: $result"
	echo 
	echo 'Another operation? Type "yes" or "no"'
	read continue
	if [ $continue = yes ]

		then stop=0
		else stop=1

	fi

done



