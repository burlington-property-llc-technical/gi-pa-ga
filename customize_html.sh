#!/bin/bash

set -e  # Exit on first error
set -x  # Echo invoked commands

# Usage: inject_html target_file contents_file
inject_html() {
    TARGET="$1"
    CONTENTS="$2"
    echo "inject_html invoked: ${TARGET} ${CONTENTS}"

    JSFILE=$(echo "$CONTENTS" | sed -e 's/[.]html$/.js/')
    echo "Creating ${JSFILE}"

    # https://stackoverflow.com/questions/7189604/replacing-html-tag-content-using-sed
    # https://stackoverflow.com/questions/8988855/include-another-html-file-in-a-html-file
    echo "document.write('\\" > "${JSFILE}"
    sed 's/\\/\\\\/g;s/^.*$/&\\/g;s/'\''/\\'\''/g' "${CONTENTS}" >> "${JSFILE}"
    echo "');" >> "${JSFILE}"
    sudo cp -i "${JSFILE}" build_output/public/

    # The <footer> tag seems a reasonable place in the thumbsup output
    sed -i -e 's|<footer>|<script src="public/'"${JSFILE}"'"></script>\n      <footer>|' "${TARGET}"
}

# Prove we can access build_output/index.html
echo "Starting line count of index.html: $(wc -l build_output/index.html)"

inject_html "build_output/index.html" "desc_index.html"
inject_html "build_output/Apartment-2.html" "desc_u2.html"
inject_html "build_output/Apartment-5.html" "desc_u5.html"

# Contents of build_output
ls -la build_output/
