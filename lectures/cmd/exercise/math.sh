#!/bin/bash

# Simple mathematics


# Define our addition function
function addition () {
	let result=$2+$3
}

# Define our subtraction function
function subtraction () {
	let result=$2-$3
}

# Define our multiplication function
function multiplication () {
	let result=$2*$3
}

# Define our subtraction function
function division () {
	let result=$2/$3
}


# We need to call the function with $@ 
# Otherwise the arguments ($1, $2) can't be used inside the function!!
case $1 in

	add)
		addition $@
	;;
	
	sub)
		subtraction $@
	;;
	
	mul)
		multiplication $@
	;;
	
	div)
		division $@
	;;
	
esac

echo "The result is: $result"
