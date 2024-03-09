#!/bin/sh
# Shell script for dumb simple scouting tech.

SHORT_OPTIONS=''

getopt --test
getopt_state=$?

[ $getopt_state -eq 4 ] || echo "getopt --test error code $getopt_state, when it should be 4." \
    || exit 1 \
    && echo "getopt --test is $getopt_state! Moving forward." 

while true
do
    read -p "Match number?   : " MATCH
    read -p "Team number?    : " TEAM
    read -p "Alliance color? : " ALLIANCE

    AMPS=
    SPEAKERS=
    CLIMBED=false
    AUTO=false
    
    GO=true
    
    MLOG_FILENAME=$(printf 'M%d_T%d.dat' $MATCH $TEAM)
    touch "$MLOG_FILENAME"
    
    printf 'START match:%d\n' $

    while $GO
    do
        echo "Hit 'S' for speaker, 'A' for amp. GO!"
        read -n 1 -p "$MATCH > " IN

        case $IN in
            [Ss])
                let SPEAKERS++
                printf 'Scored 1 SPEAKER (total %d)\n' $SPEAKERS
                printf 'match:%d alliance:"%s" team:%d speaker:+1,%d\n' \ 
                    "$MATCH" "$ALLIANCE" "$TEAM" $SPEAKERS >> "$MLOG_FILENAME"
                ;;
            Q)
                printf 'Quitting.\n'
                printf 'match:%d alliance:"%s" team:%d speaker:%d amp:%d climbed:"%s" auto:"%s"\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $SPEAKERS $AMPS $CLIMBED $AUTO
                ;;
        esac
                
    done



done
