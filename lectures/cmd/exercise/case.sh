#!/bin/sh

# The following script uses a case statement
# It checks if the argument we passed to the script ($1) matches one of the pre-defined cases. It then performs an action.

# start the case statement and use the first argument ($1) 
case $1 in

	# if $1 is "start"
	start)

		# Add all start operations / commands here
		echo "Starting!"

	;;

	# if $1 is "stop"
	stop)

		# Add all stop operations / commands here
		echo "Stopping!"

	;;

	# if $1 is "status"
	status)

		# Add commands that output useful status information here
		echo "Status!"

	;;

	bogus)
	
		echo "blabla"

	;;

	# if $1 is anything other than "start" or "stop" or "status"
	*)

		# display an error message!
		echo "Syntax Error!"
		echo "Syntax: $0 {start|stop|status}"

		# stop script execution with error code 1 (default error level)
		exit 1

	;;

# close the case statement
esac
