#! /bin/sh -vx
# This file is for pushing graded assignments to GitHub Classroom repositories
# It will add all new files and commit them with a given message
# It requires the folder name and a message


if [[ $# -ne 1 ]];
	then
	echo "This script requires 1 parameter."
	echo "1. The folder name the assignments are in"
else
	assignment=$1
	for f in ../${assignment}/*
		do
			cd $f
			git add -A
			git commit -m "Graded"
			git push origin master
			echo $f
			cd ..
		done
fi
