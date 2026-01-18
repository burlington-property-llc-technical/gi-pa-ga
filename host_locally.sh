#!/bin/bash

set -e

# Don't delete - use wget -N instead
# https://stackoverflow.com/questions/77050692/how-to-redownload-file-with-wget-only-when-the-file-is-newer-or-the-size-chang
# rm -rf tmp/burlingtonpropertyllc.com

# Archive a copy of the live site
# https://stackoverflow.com/questions/12934528/recursive-wget-with-hotlinked-requisites
# TODO(jonmccune): figure out partial update, no reason to actually transfer media files
# we already have locally.
wget -N -P tmp -e robots=off -r -l inf -pk -H https://burlingtonpropertyllc.com

# https://browsersync.io/#install
(cd tmp/burlingtonpropertyllc.com && npx browser-sync start --server --files tmp/burlingtonpropertyllc.com/public/theme.css)

