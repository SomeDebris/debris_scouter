#!/bin/bash
# Shell script for dumb simple scouting tech.

SHORT_OPTIONS=''

getopt --test
getopt_state=$?

[ $getopt_state -eq 4 ] || echo "getopt --test error code $getopt_state, when it should be 4." \
    || exit 1 \
    && echo "getopt --test is $getopt_state! Moving forward." 

while true
do
    read -e -p "Match number?   : " MATCH
    read -e -p "Team number?    : " TEAM
    read -e -p "Alliance color? : " ALLIANCE



    AMPS=0
    SPEAKERS=0
    CLIMBED=0
    AUTO=0
    
    GO=true
    
    MLOG_FILENAME=$(printf 'M%d_T%d.dat' $MATCH $TEAM)
    touch "$MLOG_FILENAME"
    
    printf 'START match:%d\n' $MATCH >> "$MLOG_FILENAME"

    while $GO
    do
        echo "Hit 'S' for speaker, 'A' for amp. GO!"
        read -n 1 -e -p "$MATCH> " IN

        case $IN in
            s)
                let SPEAKERS++
                printf 'Scored 1 SPEAKER (total %d)\n' "$SPEAKERS"
                printf 'match:%d alliance:"%s" team:%d +speaker:1:%d\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $SPEAKERS >> "$MLOG_FILENAME"
                ;;
            S)
                let SPEAKERS--
                printf 'Remove 1 SPEAKER (total %d)\n' "$SPEAKERS"
                printf 'match:%d alliance:"%s" team:%d -speaker:1:%d\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $SPEAKERS >> "$MLOG_FILENAME"
                ;;
            a)
                let AMPS++
                printf 'Scored 1 AMP (total %d)\n' $AMPS
                printf 'match:%d alliance:"%s" team:%d +amp:1:%d\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $AMPS >> "$MLOG_FILENAME"
                ;;
            A)
                let AMPS--
                printf 'Remove 1 AMP (total %d)\n' $AMPS
                printf 'match:%d alliance:"%s" team:%d -amp:1:%d\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $AMPS >> "$MLOG_FILENAME"
                ;;
            c)
                if [ $CLIMBED -eq 1 ]; then
                    CLIMBED=0
                    printf 'Team %d set to NOT CLIMBED\n' "$TEAM"
                else
                    CLIMBED=1
                    printf 'Team %d set to CLIMBED\n' "$TEAM"
                fi

                printf 'match:%d alliance:"%s" team:%d climbed:"%s"\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $CLIMBED >> "$MLOG_FILENAME"
                ;;
            Q)
                printf 'Match done!.\n'
                printf 'match:%d alliance:"%s" team:%d speaker:%d amp:%d climbed:"%s" auto:"%s"\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $SPEAKERS $AMPS $CLIMBED $AUTO \
                    | tee -a "$MLOG_FILENAME"
                GO=false
                ;;
            *)
                printf 'Invalid input\n'
        esac
                
    done



done
