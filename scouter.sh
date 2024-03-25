#!/bin/bash
# Shell script for dumb simple scouting tech.

SHORT_OPTIONS=''

getopt --test
getopt_state=$?

[ $getopt_state -eq 4 ] || echo "getopt --test error code $getopt_state, when it should be 4." \
    || exit 1 \
    && echo "getopt --test is $getopt_state! Moving forward." 

black=$(tput setaf 0)
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
lime_yellow=$(tput setaf 190)
powder_blue=$(tput setaf 153)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)

bold=$(tput bold)
normal=$(tput sgr0)
blink=$(tput blink)
reverse=$(tput smso)
underline=$(tput smul)
end_underline=$(tput rmul)


read -e -p "What is your NAME? (optional) : " NAME


while true
do
    read -e -p "Match number?   : " MATCH
    read -e -p "Team number?    : " TEAM
    read -e -p "Alliance color? : " ALLIANCE
    
    printf "${magenta}-- Match Starting --${normal}\n"


    AMPS=0
    TRAP=0
    SPEAKERS=0
    CLIMBED=0
    AUTO=0
    PICKUPS=0
    FERRIED=0
    
    GO=true
    
    MLOG_FILENAME=$(printf 'M%d_T%d.mlog' $MATCH $TEAM)
    touch "$MLOG_FILENAME"
    
    printf 'START match:%d alliance:"%s" team:%d scouter_name:"%s"\n' \
        "$MATCH" "$ALLIANCE" "$TEAM" "$NAME" >> "$MLOG_FILENAME"

    case "${ALLIANCE}" in
        [Bb][Ll][Uu][Ee])
            ENTRY_PROMPT_COLOR="${blue}${bold}"
            ;;
        [Rr][Ee][Dd])
            ENTRY_PROMPT_COLOR="${red}${bold}"
            ;;
        *)
            ENTRY_PROMPT_COLOR="${bold}"
            ;;
    esac

    ENTRY_PROMPT="${ENTRY_PROMPT_COLOR}${MATCH}${normal}> "
    

    MATCH_START_TIME=$(date +%s)

    while $GO
    do
        # echo "Hit 'S' for speaker, 'A' for amp. GO!"
        read -n 1 -e -p "$ENTRY_PROMPT" IN

        DELTA=$(expr $(date +%s) '-' $MATCH_START_TIME)

        case $IN in
            f)
                let FERRIED++
                printf '%sFerried%s 1 NOTE (total %d)\n' "${green}" "${normal}" "$FERRIED"
                printf 'match:%d alliance:"%s" team:%d time:%d +ferried:1:%d\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $DELTA $FERRIED >> "$MLOG_FILENAME"
            F)
                let FERRIED--
                printf '%sUn-ferried%s 1 NOTE (total %d)\n' "${green}" "${normal}" "$FERRIED"
                printf 'match:%d alliance:"%s" team:%d time:%d -ferried:1:%d\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $DELTA $FERRIED >> "$MLOG_FILENAME"
            p)
                let PICKUPS++
                printf '%sPicked up%s 1 NOTE (total %d)\n' "${green}" "${normal}" "$PICKUPS"
                printf 'match:%d alliance:"%s" team:%d time:%d +pickups:1:%d\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $DELTA $PICKUPS >> "$MLOG_FILENAME"
            P)
                let PICKUPS--
                printf '%sUndo pickup%s 1 NOTE (total %d)\n' "${green}" "${normal}" "$PICKUPS"
                printf 'match:%d alliance:"%s" team:%d time:%d -pickups:1:%d\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $DELTA $PICKUPS >> "$MLOG_FILENAME"
            [Rr])
                printf 'RESET TIMER @ match:%d alliance:"%s" team:%d time:%d start_time_previous:%d\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $DELTA $MATCH_START_TIME >> "$MLOG_FILENAME"
                MATCH_START_TIME=$(date +%s)
                printf "Reset match start time.\n"
                ;;
            s)
                let SPEAKERS++
                printf '%sScored%s 1 SPEAKER (total %d)\n' "${green}" "${normal}" "$SPEAKERS"
                printf 'match:%d alliance:"%s" team:%d time:%d +speaker:1:%d\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $DELTA $SPEAKERS >> "$MLOG_FILENAME"
                ;;
            S)
                let SPEAKERS--
                printf '%sRemove%s 1 SPEAKER (total %d)\n' "${red}" "${normal}" "$SPEAKERS" 
                printf 'match:%d alliance:"%s" team:%d time:%d -speaker:1:%d\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $DELTA $SPEAKERS >> "$MLOG_FILENAME"
                ;;
            a)
                let AMPS++
                printf '%sScored%s 1 AMP (total %d)\n' "${green}" "${normal}" $AMPS
                printf 'match:%d alliance:"%s" team:%d time:%d +amp:1:%d\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $DELTA $AMPS >> "$MLOG_FILENAME"
                ;;
            A)
                let AMPS--
                printf '%sRemove%s 1 AMP (total %d)\n' "${red}" "${normal}" $AMPS
                printf 'match:%d alliance:"%s" team:%d time:%d -amp:1:%d\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $DELTA $AMPS >> "$MLOG_FILENAME"
                ;;
            [Tt])
                if [ $TRAP -eq 1 ]; then
                    TRAP=0
                    printf "Set to ${bold}${red}NO TRAP${normal}\n"
                else
                    TRAP=1
                    printf "Set to ${bold}${green}TRAP${normal}\n"
                fi
                printf 'match:%d alliance:"%s" team:%d time:%d trap:%d\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $DELTA $TRAP >> "$MLOG_FILENAME"
                ;;
            c)
                if [ $CLIMBED -eq 1 ]; then
                    CLIMBED=0
                    printf "Team %d set to ${bold}${red}NOT CLIMBED${normal}\n" "$TEAM"
                else                                                       
                    CLIMBED=1                                              
                    printf "Team %d set to ${bold}${green}CLIMBED${normal}\n" "$TEAM"
                fi

                printf 'match:%d alliance:"%s" team:%d time:%d climbed:"%s"\n' \
                    "$MATCH" "$ALLIANCE" "$TEAM" $DELTA $CLIMBED >> "$MLOG_FILENAME"
                ;;
            Q)
                GO=false
                ;;
            *)
                printf "${red}Invalid input${normal} (should be in [%s])\n" \
                    'RrSsAaTtcQPpFf'
        esac
                
    done

    printf "${magenta}-- Match finished --${normal}\n"
    
    COMMENT=''
    read -e -p 'Write a comment (optional) : ' COMMENT

    printf "${cyan}Added final line to '%s':${normal}\n" "$MLOG_FILENAME"
    printf 'match:%d alliance:"%s" team:%d time:%d pickups:%d speaker:%d amp:%d climbed:"%s" trap:%d auto:"%s" comment:"%s"\n' \
        "$MATCH" "$ALLIANCE" "$TEAM" "$DELTA" "$PICKUPS" "$SPEAKERS" "$AMPS" "$CLIMBED" "$TRAP" "$AUTO" "$COMMENT" \
        | tee -a "$MLOG_FILENAME"

    printf "${bold}-- Next Match! --\n${normal}"


done
