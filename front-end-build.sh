#!/bin/bash
# return failing exit code if any command fails
set -e

# enable nullglob - allows filename patterns which match no files to expand to a null string, rather than themselves
shopt -s nullglob

DIST="./dist"

# go to the workdir
if [ -n "$BITBUCKET_CLONE_DIR" ]
then
    cd "$BITBUCKET_CLONE_DIR" || return
else
    cd /code || return
fi

# Add myget npm source if access token is set
if [ -n "$MYGET_ACCESS_TOKEN" ]
then
# check whether Frontliners scope exists, if not add it
  if [[ $(cat ~/.npmrc | grep @frontliners: | wc -l) -eq "0" ]]; then
      echo -e "\n@frontliners:registry=https://www.myget.org/F/frontliners/npm/\n//www.myget.org/F/frontliners/npm/:_authToken=$MYGET_ACCESS_TOKEN" >> ~/.npmrc
      echo "@frontliners scope sucesfully registered"
  else
      echo "@frontliners scope already registered"
  fi
fi
