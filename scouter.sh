#!/bin/sh
# Shell script for dumb simple scouting tech.

SHORT_OPTIONS=''

getopt --test
getopt_state=$?

[ ! $getopt_state -eq 4 ] && echo "getopt --test error code $getopt_state, when it should be 4."; exit 1

echo "getopt --test is $getopt_state! Moving forward."
