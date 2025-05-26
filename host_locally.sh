#!/bin/bash

echo "!!! UNTESTED !!! UNTESTED !!! UNTESTED !!!"

# Archive a copy of the live site
# https://stackoverflow.com/questions/12934528/recursive-wget-with-hotlinked-requisites
# TODO(jonmccune): figure out partial update, no reason to actually transfer media files
# we already have locally.
wget -e robots=off -r -l inf -pk -H https://burlingtonpropertyllc.com

# https://browsersync.io/#install
npx browser-sync start --server --files burlingtonpropertyllc.com/public/theme.css