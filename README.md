# Debris's Scouter

A simple bash script made to be run by scouts during an FRC event. It tracks
the performance of a single FRC robot across a match. It is intended to feel
like a hand-held counter device: during matches, it acts on each key press and
immediately writes the result to a small text file without any additional
prompting. This script should run on most linux distributions without issue.

## Usage

Clone this repository and run `scouter.sh` from the command line. It (currently)
takes no arguments, though I am preparing to do this soon.

The script will immediately ask you for a Match number, a Team number, and an
Alliance color. 

After doing so, the script will print the following line:
```
-- Match Starting --
``` 
and will prompt you for input. The match number (colored either red or blue,
depending on your response to the Alliance color question) is printed to the
left of the cursor. The script is ready to count game pieces. Type in commands
to tell the script what is occuring in the match (case sensitive):

- `R` or `r`: reset the match timer. Press this button ONCE, right when the
  match begins.
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

Create an easy way to record match data while I watch FRC matches. I want it
to:
- be simple enough to use effectively without looking at the screen during a match
- tell me exactly what its doing
- never lose data
- be able to undo mistakes
- use the fewest possible number of dependencies for core functionality
- give me a simple visual indication of a robot's performance in a match
- get the hell out of my way and just work!

## Why?

This was fun to hack out in a couple hours. And, hey, maybe I'll even use this
when I'm watching competitions!
