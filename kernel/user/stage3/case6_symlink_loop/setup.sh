#!/bin/bash
# setup.sh for Case 6
rm -f /tmp/link_a /tmp/link_b
ln -s /tmp/link_b /tmp/link_a
ln -s /tmp/link_a /tmp/link_b
gcc -o case6_symlink_loop case6_symlink_loop.c
