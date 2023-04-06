#!/usr/bin/env bash
#
# Script name: build-db.sh


echo "###########################"
echo "Building the repo database."
echo "###########################"

## Arch: x86_64

rm -f ArtemisOS/x86_64/ArtemisOS*
rm -f ArtemisOS-Testing/x86_64/ArtemisOS-Testing*

echo "###################################"
echo "Building for architecture 'x86_64'."
echo "###################################"

## repo-add
## -s: signs the packages
## -n: only add new packages not already in database
## -R: remove old package files when updating their entry
repo-add -n -s -v -R ArtemisOS/x86_64/ArtemisOS.db.tar.gz ArtemisOS/x86_64/*.pkg.tar.zst
repo-add -n -s -v -R ArtemisOS-Testing/x86_64/ArtemisOS-Testing.db.tar.gz ArtemisOS-Testing/x86_64/*.pkg.tar.zst

# Removing the symlinks because GitLab can't handle them.
rm -f ArtemisOS/x86_64/ArtemisOS.db
rm -f ArtemisOS-Testing/x86_64/ArtemisOS-Testing.db
rm -f ArtemisOS/x86_64/ArtemisOS.db.sig
rm -f ArtemisOS-Testing/x86_64/ArtemisOS-Testing.db.sig

rm -f ArtemisOS/x86_64/ArtemisOS.files
rm -f ArtemisOS-Testing/x86_64/ArtemisOS-Testing.files
rm -f ArtemisOS/x86_64/ArtemisOS.files.sig
rm -f ArtemisOS-Testing/x86_64/ArtemisOS-Testing.files.sig



# Renaming the tar.gz files without the extension.
mv ArtemisOS/x86_64/ArtemisOS.db.tar.gz ArtemisOS/x86_64/ArtemisOS.db
mv ArtemisOS-Testing/x86_64/ArtemisOS-Testing.db.tar.gz ArtemisOS-Testing/x86_64/ArtemisOS-Testing.db

mv ArtemisOS/x86_64/ArtemisOS.db.tar.gz.sig ArtemisOS/x86_64/ArtemisOS.db.sig
mv ArtemisOS-Testing/x86_64/ArtemisOS-Testing.db.tar.gz.sig ArtemisOS-Testing/x86_64/ArtemisOS-Testing.db.sig



mv ArtemisOS/x86_64/ArtemisOS.files.tar.gz ArtemisOS/x86_64/ArtemisOS.files
mv ArtemisOS-Testing/x86_64/ArtemisOS-Testing.files.tar.gz ArtemisOS-Testing/x86_64/ArtemisOS-Testing.files

mv ArtemisOS/x86_64/ArtemisOS.files.tar.gz.sig ArtemisOS/x86_64/ArtemisOS.files.sig
mv ArtemisOS-Testing/x86_64/ArtemisOS-Testing.files.tar.gz.sig ArtemisOS-Testing/x86_64/ArtemisOS-Testing.files.sig


echo "#######################################"
echo "Packages in the repo have been updated!"
echo "#######################################"
 
git pull

# Below command will backup everything inside the project folder
git add --all .

# Give a comment to the commit if you want
echo "####################################"
echo "Write your commit comment!"
echo "####################################"

#read input

# Committing to the local repository with a message containing the time details and commit text

git commit -m "Repo Update"

# Push the local files to github

git push -u origin main


echo "################################################################"
echo "###################    Git Push Done      ######################"
echo "################################################################"
