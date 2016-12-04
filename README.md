# mass_clone
This is a shell script that will clone multiple repositories.  The intended usage is for GitHub Classroom to be able to clone all repos of a certain assignment.  The script will create a folder based on the identifier(assignment name) then make folders for each repo then clone.  Uses GitHub api v3, curl 7.49.1 and grep 2.5.1

# clone_all.sh

This script takes 4 arguments in order to clone repos based on organization(github classroom), a unique identifier(assignment), username, and protocol.

This script will make a new folder based on the unique identifier, then clone each to their own subfolder.

If you would like to have osx remember your credentials to use https: https://help.github.com/articles/caching-your-github-password-in-git/

If you would like to setup an ssh key: https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/

If you are running windows, here is a stack post that may help with ssh: https://stackoverflow.com/questions/18404272/running-ssh-agent-when-starting-git-bash-on-windows

# push_all.sh

Adds all files, commits, then pushes all changes.

Takes 1 argument, the unique identifier(folder containing repos)

Used the commit message "Graded", but can be changed.

# clone_all_helper.sh

This script runs clone_all.sh with three arguments as defaults, Organization, username, and protocol

The script takes one argument, the unique identifier.