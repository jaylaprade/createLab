#!/bin/bash

USER=jaylaprade
TEMPLATE=/home/jaylaprade/School/CSIS222/Template

PROJECT=$1
PROJECT_LOWER=${PROJECT,,}
MAIN=$2

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
	bitbucket create -u $USER -c -s git -P https $PROJECT_LOWER

}
function gitPush
{
	git remote add origin https://$USER@bitbucket.org/$USER/$PROJECT_LOWER	
	git add *
	git commit -a -m 'Initial Commit'
	git push -u origin master
}

function usage
{
	echo "usage: $0 [[ProjectName]] [[Name of the Main File]]"
}

if [[ -z $0 ]]
	then
		usage
		exit
fi

createDir
copyTemplate
renameTemplate
gitInit
bitbucketInit
gitPush
