#!/bin/bash
# setup.sh for Case 7
rm -f /tmp/target.txt /tmp/good_link
touch /tmp/target.txt
ln -s /tmp/target.txt /tmp/good_link
gcc -o case7_symlink_fast case7_symlink_fast.c
