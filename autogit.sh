#!/bin/bash

# Welcome! This is my custom-made script to push my changes to origin master.

# make sure I add a commit message
if [[ ${#} -eq 0 ]]
then
    echo "Rashid!! Add a commit message!!!"
    exit 1
fi

# Do your thing
git add .

if [[ $? -eq 0 ]]
then
    echo ''
    echo 'Successfully added changes to the staging area. Hold tight...'
    echo ''
else
    echo 'Unable to add changes to the staging area' >&2
    exit 1
fi


git commit -m "${2}"

if [[ $? -eq 0 ]]
then
    echo ''
    echo 'Successfully commited your awesome changes. Moving on...'
    echo ''
else
    echo 'Unable to commit changes' >&2
    exit 1
fi



# branch name
case "${1}" in
    dev)
        BRANCH="dev"
        ;;
    uat)
        BRANCH="uat"
        ;;
    rashid)
        BRANCH="rashid"
        ;;
    *)
        BRANCH="master"
        ;;
esac


git push -u origin "${BRANCH}"

if [[ $? -eq 0 ]]
then
    echo ''
    echo "Successfully pushed your awesome changes!. You're the man!"
    echo ''
    exit 0
else
    echo 'Unable to push changes because an error occurred'
    exit 1
fi