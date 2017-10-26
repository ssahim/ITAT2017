#!/bin/bash

# Simple mathematics

# Define our addition function
function add () {
	let result=$1+$2
}

# We need to call the function with $@ 
# Otherwise the arguments ($1, $2) can't be used inside the function!!
add $@

echo "The sum of value 1 and value 2 is: $result"
