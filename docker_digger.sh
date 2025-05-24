#!/bin/sh

set -e

echo "=== My environment ==="
printenv

echo "=== PWD: $PWD ==="
ls -la
ls -la /
which thumbsup
ls -la /usr/local/bin

OLDIFS=$IFS
IFS=':'
for dir in $PATH; do
    ls -la thumb* || true
done
IFS=$OLDIFS

