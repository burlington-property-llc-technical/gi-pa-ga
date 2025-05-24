#!/bin/sh

set -e

echo "=== My environment ==="
printenv

echo "=== PWD: $PWD ==="

ls -la
ls -la /
ls -la /bin
ls -la /sbin
ls -la /usr/*bin
