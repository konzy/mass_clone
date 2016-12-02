#! /bin/sh -vx
# This file is for pushing graded assignments to GitHub Classroom repositories
# It will add all new files and commit them with a given message
# It requires the folder name and a message


if [[ $# -ne 2 ]];
	then
	echo "This script requires 2 parameters."
	echo "First is the folder name the assignments are in"
	echo "Second is the message"
else
	assignment=$1
	message=$2
	for f in ${assignment}/*
		do
			cd $f
			git add -A
			git commit -m \""$message"\"
			git push origin master
			echo $f
			cd ..
		done
fi
