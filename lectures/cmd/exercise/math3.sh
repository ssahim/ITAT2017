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
	# by using the "bc" utility, we can convert from integer to floating point
	result=$(echo "scale=2; $v1/$v2" | bc)
}

# function that reads our values
function get_values() {
		# "read ..." assigns the entered values to variables $v1 and $v2
		echo "Enter first value"
		# while loop to check if input was not empty!
		# if empty, restart the loop!
		while read v1; do
			if [[ -z "${v1}" ]]; then
				echo "That was empty, do it again!"
				continue
			else
				break
			fi
		done

		echo "Enter second value"		
		# while loop to check if input was not empty!
		# if empty, restart the loop!
		while read v2; do
			if [[ -z "${v2}" ]]; then
				echo "That was empty, do it again!"
				continue
			else
				break
			fi
		done
}


# Initialize stop to be 0; 
# we need this variable as a stop-condition for the while loop below!
stop=0

# Initialize the round counter i to be 0
i=0

# Until the value of $stop equals zero we run the while loop
while [ $stop -eq 0 ]; do

	# initialize the round counter
	i=$((i+1))


	clear

	# while loop to check if the operation was entered correctly
	while true; do

		# Echo calculator instructions so the user knows what to do
		echo "Round: $i"
		echo
		echo "Enter type of operation (add, sub, mul, div):"
		read type
		echo

		# depending on the type of operation we call the right function and pass it the variables $v1 and $v2
		case $type in

			add)
				get_values
				addition $v1 $v2
				break
			;;
			
			sub)
				get_values
				subtraction $v1 $v2
				break
			;;
			
			mul)
				get_values
				multiplication $v1 $v2
				break
			;;
			
			div)
				get_values
				division $v1 $v2
				break
			;;
			
			*) 
				# if user input is invalid, start the while loop from the top
				echo "Incorrect operation specified! Try again..."
				sleep 1
				clear
				continue
			;;
			
		esac
	done
	
	# show the user the result
	echo "The result is: $result"
	echo 
	
	# ask if user wants another operation
	# while loop to check for correct user input
	while true; do
		echo 'Another operation? Type "yes" or "no"'
		read go_on
		
		case $go_on in
		
			yes)
				stop=0
				clear
				break
			;;
			
			no)
				stop=1
				echo "OK, cool! $i rounds is probably enough :)"
				break
			;;
			
			*)
				echo "Invalid input"
				sleep 1
				clear
				continue
			;;
		
		esac
		
	done

done
