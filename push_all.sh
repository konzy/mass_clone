#! /bin/sh
# This file is for pushing graded assignments to GitHub Classroom repositories
# It requires at least 2 command line arguments
# 1 - name of the assignment, for cycling through folders
# 2 - an option argument: 1 or 2
# 3 - if option 1 is chosen, the name of the file to push
# Author: @umasshokie, Megan Olsen

#Check that at least 1 parameter is given
if [[ $# -lt 2 ]];
	then
	echo "This script requires at least 2 parameters."
	echo "First is an assignment name, i.e. common start to all directory names"
	echo "Second is a numerical option:"
	echo "	1 - add a single file and commit/push. Filename is third parameter."
	echo "	2 - no new files, commit and push all changes to the repository."
# If the option choice is 1, add given file and commit/push
elif [[ $2 -eq 1 ]];
	then
	if [[ $# -eq 3 ]];
		then
		assignment=$1
		file=$3
		for f in ${assignment}*
		do
			cd $f
			git add $file
			git commit $file -m "Graded"
			git push origin master
			cd ..
		done
	else
		echo "For option 1, you must list a filename as a third parameter"
	fi
#  If the option choice is 2, commit and push all files in directory
elif [[ $2 -eq 2 ]];
	then
	assignment=$1
	for f in ${assignment}/${assignment}*
		do
			cd $f
			git commit * -m "Graded"
			git push origin master
			echo $f
			cd ..
		done
else
	echo "Option must be 1 or 2"
fi

