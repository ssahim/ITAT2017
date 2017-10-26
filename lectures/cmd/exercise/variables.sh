#! /bin/bash

# Clear the terminal 
clear

# echo the script name by looking at the $0 variable
echo "The filename of this script: $0"

# insert an empty line for a nicer look
echo

# Ask the user what his favourite color is
echo "Name of the 1st parameter: $1"

# insert an empty line for a nicer look
echo

# Ask the user what his favourite color is
echo "Name of the 2nd parameter: $2"

# insert an empty line for a nicer look
echo

# Ask the user what his favourite color is
echo "Please enter value for \$var1 "

# insert an empty line for a nicer look
echo

# Read user input from terminal into the variable "var1"
read var1

# Set the color of the terminal background to the user's choice
echo "The value of \$var1 is: $var1"
