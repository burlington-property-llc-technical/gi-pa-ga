#!/bin/bash

set -e  # Exit on first error
set -x  # Echo invoked commands

# Usage: inject_html target_file contents_file
inject_html() {
    TARGET="$1"
    CONTENTS="$2"

    # Check if target file exists before processing
    if [ ! -f "${TARGET}" ]; then
        echo "Skipping ${TARGET} (file does not exist)"
        return 0
    fi

    echo "inject_html invoked: ${TARGET} ${CONTENTS}"

    JSFILE=$(echo "$CONTENTS" | sed -e 's/[.]html$/.js/')
    echo "Creating ${JSFILE}"

    # https://stackoverflow.com/questions/7189604/replacing-html-tag-content-using-sed
    # https://stackoverflow.com/questions/8988855/include-another-html-file-in-a-html-file
    echo "document.write('\\" > "${JSFILE}"
    sed 's/\\/\\\\/g;s/^.*$/&\\/g;s/'\''/\\'\''/g' "${CONTENTS}" >> "${JSFILE}"
    echo "');" >> "${JSFILE}"
    sudo cp -f "${JSFILE}" build_output/public/

    # The <footer> tag seems a reasonable place in the thumbsup output
    sed -i -e 's|<footer>|<script src="public/'"${JSFILE}"'"></script>\n      <footer>|' "${TARGET}"
}

# Prove we can access build_output/index.html
echo "Starting line count of index.html: $(wc -l build_output/index.html)"

inject_html "build_output/index.html" "desc_index.html"

# Copy the JavaScript file for moving thumbnails
sudo cp -f move_thumbs.js build_output/public/

# Copy the logo
sudo cp -f logo.png build_output/public/

# Copy the favicon
sudo cp -f favicon-32x32.png build_output/public/

# Inject the logo into the header (before the h1)
sed -i -e 's|<header>|<header>\n      <img src="public/logo.png" alt="Burlington Property LLC Logo" class="burly-logo">|' "build_output/index.html"

# Inject favicon into all HTML files
for html_file in build_output/*.html; do
  if [ -f "$html_file" ]; then
    sed -i -e 's|<head>|<head>\n    <link rel="icon" type="image/png" sizes="32x32" href="public/favicon-32x32.png">|' "$html_file"
  fi
done

# Inject the script tag into index.html
sed -i -e 's|<footer>|<script src="public/move_thumbs.js"></script>\n      <footer>|' "build_output/index.html"
inject_html "build_output/Apartment-2.html" "desc_u2.html"
inject_html "build_output/Apartment-3.html" "desc_u3.html"
inject_html "build_output/Apartment-4.html" "desc_u4.html"
inject_html "build_output/Apartment-5.html" "desc_u5.html"
inject_html "build_output/Apartment-6.html" "desc_u6.html"

# Contents of build_output
ls -la build_output/
