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
JSFILE=index_customizer.js
echo "document.write('\\" > ${JSFILE}
sed 's/\\/\\\\/g;s/^.*$/&\\/g;s/'\''/\\'\''/g' index_desc.html >> ${JSFILE}
echo "');" >> ${JSFILE}
sudo cp -i ${JSFILE} build_output/public/

# The <footer> tag seems a reasonable place in the thumbsup output
sed -i -e 's|<footer>|<script src="public/'"${JSFILE}"'"></script>\n      <footer>|' build_output/index.html

echo "Ending line count of index.html: $(wc -l build_output/index.html)"

