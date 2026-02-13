#!/bin/bash
# setup.sh for Case 3
rm -rf /tmp/alpha
mkdir -p /tmp/alpha/beta/gamma
touch /tmp/alpha/beta/gamma/hit.txt
gcc -o case3_deep_hit case3_deep_hit.c
