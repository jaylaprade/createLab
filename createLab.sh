#!/bin/bash

PROJECT=$1
PROJECT_LOWER=${PROJECT,,}
MAIN=$2

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

function writeConfig
{
	cat >~/.createLab <<EOL
USER=${USER}
TEMPLATE=${TEMPLATE}
RUNONCE=${RUNONCE}
EOL
	
}

function createDir
{
	mkdir $PROJECT
}

function copyTemplate
{
	echo "$PROJECT/"
	echo "$TEMPLATE/*"
	cp  "$TEMPLATE/name.cpp" "$PROJECT/"
	cp  "$TEMPLATE/name.h" "$PROJECT/"
	cp  "$TEMPLATE/Makefile" "$PROJECT/"
}

function renameTemplate
{
	mv "$PROJECT/name.cpp" "$PROJECT/$MAIN.cpp"
	mv "$PROJECT/name.h" "$PROJECT/$MAIN.h"
	sed -i 's/name/$MAIN/g' "$PROJECT/Makefile"
}

function gitInit
{
	cd $PROJECT
	git init
}

function bitbucketInit
{
	echo "Creating your bitbucket repo"
	echo "Please enter your password for bitbucket when prompted"
	bitbucket create -u $USER -c -s git -P https $PROJECT_LOWER

}
function gitPush
{
	git remote add origin https://$USER@bitbucket.org/$USER/$PROJECT_LOWER	
	git add *
	git commit -a -m 'Initial Commit'
	echo "Pushing your initial commit"
	echo "Please enter your password for bitbucket again, when prompted"
	git push -u origin master
}

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
