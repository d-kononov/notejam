#!/bin/bash
# release script for bumping semantic versions in CircleCI

# this script is intended to be run on CircleCI. If you try to
# to do it locally we try to stop you. If you really want to stick
# it to the man then go for it.

set -ex

if [ -z $CIRCLE_PROJECT_REPONAME ]; then
  echo "Must run on CircleCI"
  exit 1
fi

if [ "$#" -ne 1 ]; then
  echo "Must pass 1 args: VERSION_FILE"
  exit 1
fi

version_file=$1

if [ -z $(grep -Eo "[0-9]+\.[0-9]+\.[0-9]+" $version_file) ]; then
  echo "did not find semantic version in $version_file"
  exit 1
fi

git config --global user.name "Release Man" && git config --global user.email "deploys@kononov.app"
git checkout master
git reset --hard origin/master
perl -i -pe 's/\d+\.\d+\.\K(\d+)/$1+1/e' $version_file
version=$(grep -Eo "[0-9]+\.[0-9]+\.[0-9]+" $version_file)
git add -u
git commit -m "[skip ci] $version release"
git tag "$version"
git push origin master
git push --tags
