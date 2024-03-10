# Debris's Scouter

A simple bash script for tracking the performance of a single FRC robot across a
match. This script should run on most linux distributions without issue.

## Usage

Clone this repository and run `scouter.sh` from the command line. It (currently)
takes no arguments, though I am preparing to do this soon.

The script will immediately ask you for a Match number, a Team number, and an
Alliance color. 

After doing so, the script will state `-- Match Starting --` and will prompt you
for input. The match number (colored either red or blue, depending on your
response to the Alliance color question) is printed to the left of the cursor.
The script is ready to count game pieces. Type in commands to tell the script
what is occuring in the match (case sensitive):
- `R` or `r`: reset the match timer
- `s`: count a game piece scored in the SPEAKER. Undo with `S`.
- `a`: count a game piece scored in the AMP. Undo with `A`.
- `c`: toggle whether the robot has CLIMBED successfully
- `T` or `t`: toggle whether the robot has scored a game piece in the TRAP
- `Q`: Declare the match as FINISHED.
All commands sent to the script are immediately printed to a terse log file
named according to the match number and the team number. 

After the match is declared as FINISHED, the script will ask for an optional
comment and then print out the results of the match in one line.

## Goals

Create an easy way to record match data while I watch robots compete. I want it
to:
- be simple to use without looking at the screen
- tell me exactly what its doing
- never lose data
- be able to undo mistakes
- use the fewest possible number of dependencies for core functionality
- give me a simple visual indication of a robot's performance in a match
- get the hell out of my way and just work!

## Why?

This was fun to hack out in a couple hours. And, hey, maybe I'll even use this
when I'm watching competitions!
