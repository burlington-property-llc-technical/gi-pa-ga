#!/bin/sh

set -e

echo "=== My environment ==="
printenv

echo "=== PWD: $PWD ==="

OLDIFS=$IFS
IFS=':'
for dir in $PATH; do
    ls -la *thumb*
done
IFS=$OLDIFS
ls -la
ls -la /

