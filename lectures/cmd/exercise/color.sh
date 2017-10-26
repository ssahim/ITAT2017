#! /bin/bash

# Clear the terminal 
clear

# Ask the user what his favourite color is
echo "What is your favourite color? (black, red, green, yellow, blue, magenta, cyan or white)?"

# insert an empty line for a nicer look
echo ""

# Read user input from terminal
read usercolor

# Set the color of the terminal background to the user's choice
setterm -background $usercolor

# Wish the user a nice colorful day
echo "Good choice! Have a $usercolor day!"

# Set the color of the terminal background back to black
setterm -background black

