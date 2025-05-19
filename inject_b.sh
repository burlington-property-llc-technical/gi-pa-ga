#!/bin/bash

set -e  # Exit on first error

# Contents of build_output
ls -la build_output/

# Prove we can access build_output/index.html
echo "Starting line count of index.html: $(wc -l build_output/index.html)"

# Test if we can modify index.html
echo "<!-- Jon was here -->" >> build_output/index.html

# https://stackoverflow.com/questions/7189604/replacing-html-tag-content-using-sed
# https://stackoverflow.com/questions/8988855/include-another-html-file-in-a-html-file
echo "document.write('\\" > b.js
sed 's/\\/\\\\/g;s/^.*$/&\\/g;s/'\''/\\'\''/g' u2_desc.html >> b.js
echo "');" >> b.js
sudo cp -i b.js build_output/public/

# The <footer> tag seems a reasonable place in the thumbsup output
sed -i -e 's|<footer>|<script src="public/b.js"></script>\n      <footer>|' build_output/index.html

echo "Ending line count of index.html: $(wc -l build_output/index.html)"

