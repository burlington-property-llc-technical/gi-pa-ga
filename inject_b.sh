#!/bin/bash

set -e  # Exit on first error

# Contents of build_output
ls -la build_output/

# Prove we can access build_output/index.html
echo "Starting line count of index.html: $(wc -l build_output/index.html)"

# Test if we can modify index.html
echo "<!-- Jon was here -->" >> build_output/index.html
sudo cp -i b.js build_output/public/

# https://stackoverflow.com/questions/7189604/replacing-html-tag-content-using-sed
sed -i -e 's|<footer>|<script src="public/b.js"></script>\n<p>Does text appear?</p>\n      <footer>|' build_output/index.html

echo "Ending line count of index.html: $(wc -l build_output/index.html)"

