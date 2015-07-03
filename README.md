# Scripts for managing CS class labs

createLab.sh: This is a simple script for creating labs from a simple
 template. It does the following:
-  Creates a directory for the labname
-  Copies your template files into the directory
-  Creates a git repo in the directory
-  Create a private BitBucket repo
-  Push the initial template to the BitBuck repo

Please make sure the following is installed:
- git
- bitbucket-cli

You should be able to install the above with:
-  apt-get install git
or
-  yum install git
and
-  pip install bitbucket-cli

The script has a few problems:
-  Little to no error checking
-  No checking to see if git, or bitbucket-cli are installed
-  The Make file isn't edited correctly
-  Using the "source" command which is insecure
-  The template editing is garbage but works for these first projects
-  The entire template piece only works with cpp and h files.


Other notes:

You'll note that I said "Scripts".  My intention is to create two more 
 scripts in this repo to do the following:
- Package a Lab by:
----   Setting up the zip file correctly
----   Verifying that only the correct files are included
----   Performing any rudementary checking
- Create a Homework assignment:
----   Get name and assignment number
----   Upload to Google docs
- Package a Homework assignment:
----   Download from Google docs
----   Name correctly
----   Give user a path to upload file from
