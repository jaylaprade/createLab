#!/bin/bash
#
# Create a directory for a CS Lab project, setup git, 
#  copy files from a template, then push the files to a private
#  BitBucket repo.

# Copyright 2015, Jason Laprade <jay.l.laprade@gmail.com>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License at <http://www.gnu.org/licenses/> for
# more details.

# Usage: createLab.sh [[ProjectName]] [[Name of the Main File]] 

PROJECT=$1
PROJECT_LOWER=${PROJECT,,}
MAIN=$2

#######################################
# Check to see if the config file has been written 
# Globals:
#   None 
# Arguments:
#   None
# Returns:
#   None
#######################################
function isFirstRun
{
	if [ -f ~/.createLab ]; then
		echo "Loading values"
		source ~/.createLab
	else
		echo "Enter the name of your bitbucket user"
		read USER
		echo "Enter the path to your template"
		read TEMPLATE
		RUNONCE=1
		writeConfig
	fi
}

#######################################
# Write out the config file 
# Globals:
#   None 
# Arguments:
#   None
# Returns:
#   None
#######################################
function writeConfig
{
	cat >~/.createLab <<EOL
USER=${USER}
TEMPLATE=${TEMPLATE}
RUNONCE=${RUNONCE}
EOL
	
}

#######################################
# Create the Project Directory 
# Globals:
#   None 
# Arguments:
#   None
# Returns:
#   None
#######################################
function createDir
{
	mkdir $PROJECT
}

#######################################
# Copy the Template file 
# Globals:
#   None 
# Arguments:
#   None
# Returns:
#   None
#######################################
function copyTemplate
{
	echo "$PROJECT/"
	echo "$TEMPLATE/*"
	cp  "$TEMPLATE/name.cpp" "$PROJECT/"
	cp  "$TEMPLATE/name.h" "$PROJECT/"
	cp  "$TEMPLATE/Makefile" "$PROJECT/"
}

#######################################
# Rename the Template files 
# Globals:
#   None 
# Arguments:
#   None
# Returns:
#   None
#######################################
function renameTemplate
{
	mv "$PROJECT/name.cpp" "$PROJECT/$MAIN.cpp"
	mv "$PROJECT/name.h" "$PROJECT/$MAIN.h"
	sed -i "s/name/$MAIN/g" "$PROJECT/Makefile"
}

#######################################
# Initialize git in the project directory
# Globals:
#   None 
# Arguments:
#   None
# Returns:
#   None
#######################################
function gitInit
{
	cd $PROJECT
	git init
}

#######################################
# Create the BitBucket repo for the project
# Globals:
#   None 
# Arguments:
#   None
# Returns:
#   None
#######################################
function bitbucketInit
{
	echo "Creating your bitbucket repo"
	echo "Please enter your password for bitbucket when prompted"
	bitbucket create -u $USER -c -s git -P https $PROJECT_LOWER

}

#######################################
# Add all the files and push to the Repo
# Globals:
#   None 
# Arguments:
#   None
# Returns:
#   None
#######################################
function gitPush
{
	git remote add origin https://$USER@bitbucket.org/$USER/$PROJECT_LOWER	
	git add *
	git commit -a -m 'Initial Commit'
	echo "Pushing your initial commit"
	echo "Please enter your password for bitbucket again, when prompted"
	git push -u origin master
}

#######################################
# Provide a simple help
# Globals:
#   None 
# Arguments:
#   None
# Returns:
#   None
#######################################
function usage
{
	echo "usage: $0 [[ProjectName]] [[Name of the Main File]]"
}

if [[ -z "$1" ]]
	then
		usage
		exit
fi

isFirstRun
useConfig
createDir
copyTemplate
renameTemplate
gitInit
bitbucketInit
gitPush
