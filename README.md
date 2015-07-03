# createLab
Scripts for managing CS class labs

Please make sure the following is installed:
git
bitbucket-cli

You should be able to install the above with:
  apt-get install git
or
  yum install git
and
  pip install bitbucket-cli


This is a simple script for creating labs from a simple template. It also does the following:
-  Create a git repo in the directory
-  Create a private BitBucket repo
-  Push the initial template to the BitBuck repo

The script has a few problems:
-  No checking to see if git, or bitbucket-cli are installed
-  The Make file isn't edited correctly
-  Using the "source" command which is insecure
-  The template editing is garbage but works for these first projects
-  The entire template piece on works with cpp and h files.
