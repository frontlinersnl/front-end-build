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
# check whether inforit scope exists, if not add it
  if [[ $(cat ~/.npmrc | grep @inforit: | wc -l) -eq "0" ]]; then
      echo -e "\n@inforit:registry=https://www.myget.org/F/inforit/npm/\n//www.myget.org/F/inforit/npm/:_authToken=$MYGET_ACCESS_TOKEN" >> ~/.npmrc
      echo "@inforit scope sucesfully registered"
  else
      echo "@inforit scope already registered"
  fi
fi

if [ -n "$MYGET_DOMAIN_ACCESS_TOKEN" ]
then
  # add inforit domain scope
  if [[ $(cat ~/.npmrc | grep @inforit-domain: | wc -l) -eq "0" ]]; then
      echo -e "\n@inforit-domain:registry=https://www.myget.org/F/inforit-domain/npm/\n//www.myget.org/F/inforit-domain/npm/:_authToken=$MYGET_DOMAIN_ACCESS_TOKEN" >> ~/.npmrc
      echo "@inforit-domain scope sucesfully registered"
  else
      echo "@inforit-domain already registered"
  fi
fi

rm -rf "$DIST"

npm install
npm run build:prod --if-present
npm run test:prod --if-present
npm run zipdist --if-present
