#!/bin/sh

# github api reference
# https://developer.github.com/v3/

# Written By: Brian Konzman


if [[ $# -ne 4 ]];
	then
	echo ""
	echo "This script will clone groups of repos from an organization using an identifier"
	echo "This identifier can be the name of the assignment for github classroom repos"
	echo "or some common identifier across multiple repos"
	echo ""
	echo "Please provide 4 parameters in this order:"
	echo "1. Name of Organization (GitHubClassroom)"
	echo "2. Name of Identifier (assignment)"
	echo "3. Your github username"
	echo "4. The protocol for cloning the repo (ssh/https)"
	echo ""
	echo "note: To use ssh, you must set up an ssh key with github"
	echo "You may find it useful to set up your shell to know your GitHub credentials for https"
else
	organization=$1
	identifier=$2
	githubUsername=$3
	tag=$4

	if [ "$tag" == "https" ];
		then
		tag="clone_url"
		echo "Using https"
	else
		tag="ssh_url"
		echo "Using ssh"
	fi

	echo "Enter Github Password:"
	read -s githubPassword

	# Get the first page of repo results (100 entries)
	rawJSON=$(curl --user  "$githubUsername:$githubPassword" "https://api.github.com/orgs/$organization/repos?per_page=100" -v)
	# Get the line that tells if this is the last page
    numRepos=$(echo "$rawJSON" | grep -o "full_name" | wc -l)
	page=2

	# While we have not seen the last page
	while [[ "$numRepos" -eq "100" ]]; do
		# Get next page
		tempJSON=$(curl --user  "$githubUsername:$githubPassword" "https://api.github.com/orgs/$organization/repos?per_page=100&page=$page" -v)
		numRepos=$(echo "$tempJSON" | grep -o "full_name" | wc -l)

		#concatenate tempJSON on to rawJSON
		rawJSON=$rawJSON$tempJSON
		((page++))
	done
	# grep full lines that have the same tag identifier
	fullLines=$(echo "$rawJSON" | grep "$tag" )

	# grep just the url
	justURLs=$(echo "$fullLines" | grep -o "[^\"]*"$identifier"[^\"]*")

	((lengthOfIdentifier=${#identifier}+2))

	# Make subdirectory and move to it
	mkdir -p ../${identifier}
	cd ../${identifier}

	while read -r url; do
		dir=$(basename ${url})
		dir=${dir//.git}
		if [ -d ${dir} ]; then
			git -C ${dir} pull
		else
			git clone ${url}
		fi
	done <<< "$justURLs"
fi
