#!/bin/bash/

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