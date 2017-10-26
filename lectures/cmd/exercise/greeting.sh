#!/bin/bash

# The next few lines contain:
# - a command substitution $(...) that will give us the current hour of the day in 24hrs format
# - a test operation [ ... ] that uses the substituted value of "hour of the day" and checks if it's greater or lesser than 12
# - an if ... then ... else statement that performs an action depending on the result of the test operation

if [ $(date +%k) -lt 12 ]
	then
		echo "Good morning"
	else 
		echo "Good afternoon"
fi
