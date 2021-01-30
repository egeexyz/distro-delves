#!/bin/bash

###########TOGGLE SWITCH###########
# This variable right here, officer, will toggle whether or not the script automatically does a Random Stress Test or not. If enabled, messages for confirming the test also will not appear.
ALWAYSRNG=false





FULLPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

RED=`tput setaf 1`
NC=`tput sgr0`

if [ -z "$1" ]; then if [ "$ALWAYSRNG" = "true" ]; then
    echo "Automatic stress test randomisation is currently enabled. ${RED}Good Luck.${NC}"
fi; fi


if [ "$1" = "--f-u-operating-system" ]; then
    if [ -z "$2" ]; then
        exit 1
    fi
    
    "$2" &
    xdg-open "$2" &
    sleep 0.4
    
    exit 0
fi



if [ ! -f /usr/bin/dialog ]; then
    echo "Dialog is not installed, but it's required by this toolkit. Please install the package 'dialog' to continue."

    exit 1
fi

clear




spamproc () {
    if [ "$ALWAYSRNG" == "true" ]; then
        echo "RnGesus decided to pick a test which requires user intervention. Showing the test's prompt so that you know what it is right away:
"
    fi
    read -p "Spam a desired process
    
Does what it says on the tin - you type the full path of something it should run, and it then spams processes of it.

Would you like to proceed with this test? [y/N] " yn
    case $yn in
        [Yy]* ) echo "Alright, please enter the path of what you'd like to run:";;
        * ) bash "$FULLPATH/$(basename $0)"; exit $?;;
    esac
    
    commandtorun="/nofile"
    commandargs='"'
    
    while [ ! -f "$commandtorun" ]; do
        read -p "Path of command you'd like to run (no quotes): " commandtorun
        if [ ! -f "$commandtorun" ] || [[ "$commandtorun" != "/"* ]]; then
            echo "We couldn't find that command. Try again."
        fi
    done
    while [[ "$commandargs" == *'"'* ]]; do
    read -p "What arguments do you want the command to have? (just press ENTER for no arguments) " commandargs
        if [[ "$commandargs" == *'"'* ]]; then
            echo '" quotes are not supported.'" Please use ' instead."
        fi
    done
    clear
    commandtorunfull="'$commandtorun' $commandargs"
    while true; do
        eval "$commandtorunfull" &
        sleep 0.1
    done
    
}

filldisk () {
    if [ "$ALWAYSRNG" != "true" ]; then
    read -p "Fill up disk space
    
Fill up the available disk space with your old friend, Disk Destroyer.

Would you like to proceed with this test? [y/N] " yn
    case $yn in
        [Yy]* ) echo "Alright, have fun waiting.";;
        * ) bash "$FULLPATH/$(basename $0)"; exit $?;;
    esac
    fi
    
    sudo true || exit 1
    
    for i in /usr /home /boot /etc; do
        if [ -d "$i" ]; then
            sudo dd if=/dev/zero of="$i/stresstesting" status=progress &
        fi
    done
    sudo dd if=/dev/zero of=/stresstesting status=progress
    
}

fb () {
    if [ "$ALWAYSRNG" != "true" ]; then
    read -p "🍴💣
    
Dread it, run from it, the fork bomb arrives all the same.

Would you like to proceed with this test? [y/N] " yn
    case $yn in
        [Yy]* ) echo "what have you done.";;
        * ) bash "$FULLPATH/$(basename $0)"; exit $?;;
    esac
    else
        echo "what have you done."
    fi
    
    :(){ :|:& };:
    
}

runeverything () {
    if [ "$ALWAYSRNG" != "true" ]; then
    read -p "Run. EVERYTHING.
    
Runs or opens literally every file in /, lol. Good luck, Operating System.

Would you like to proceed with this test? [y/N] " yn
    case $yn in
        [Yy]* ) echo "Bruh. Good Luck, Egee.";;
        * ) bash "$FULLPATH/$(basename $0)"; exit $?;;
    esac
    fi
    
    nohup find / -type f -exec bash "$FULLPATH/$(basename $0)" --f-u-operating-system {} \; > /dev/null 2>&1 &
    
}

rngmode () {

    rng=$(( ( RANDOM % 4 ) + 1 ))
    
    if [ "$rng" = "1" ]; then
        spamproc
    elif [ "$rng" = "2" ]; then
        filldisk
    elif [ "$rng" = "3" ]; then
        fb
    elif [ "$rng" = "4" ]; then
        runeverything
    fi
    
}


credits () {

    clear

    availwidth=$(tput cols)
    availheight=$(tput lines)
    
    gapheight=$(($availheight / 2))
    if [[ $gapheight == *".5" ]]; then
        gapheight=$(($gapheight + 0.5))
    fi
    
    for i in $(seq $gapheight); do
        echo ""
    done
    
    for stringval in "Stress Testers by:" " " "Dominic Hayes"; do
    
        linetoprint=""
        
        namewidth=$((${#stringval} / 2))
        gapwidth=$(($availwidth / 2))
        gapwidth=$(($gapwidth - $namewidth))
        
        if [[ $gapwidth == *".5" ]]; then
            gapwidth=$(($gapwidth + 0.5))
        fi
        
        for i in $(seq $gapwidth); do
            linetoprint="$linetoprint "
        done
        linetoprint="$linetoprint$stringval"
        
        echo "$linetoprint"
        
    done
    
    for i in $(seq $(($gapheight-2))); do
        echo ""
    done
    
    read
    clear

}

if [ "$ALWAYSRNG" = "true" ]; then

    #Screw menus, who needs 'em?
    rngmode
    exit 0

fi

HEIGHT=16
WIDTH=80
CHOICE_HEIGHT=14
BACKTITLE=""
TITLE="Stress Testing"
MENU="Tell me, how would you like this to go down?"

OPTIONS=(1 "Quit"
         2 "Spam a desired process"
         3 "Fill up disk space"
         4 "🍴💣"
         5 "Run. EVERYTHING."
         6 "I'm Feeling Lucky Today"
         7 "View Credits..."
	 )

CHOICE=$(dialog --clear \
                --backtitle "$BACKTITLE" \
                --title "$TITLE" \
                --menu "$MENU" \
                $HEIGHT $WIDTH $CHOICE_HEIGHT \
                "${OPTIONS[@]}" \
                2>&1 >/dev/tty)

clear

case $CHOICE in
    2)
            spamproc
            ;;
    3)
            filldisk
            ;;
    4)
            fb
            ;;
    5)
            runeverything
            ;;
    6)
            rngmode
            ;;
    7) 
            credits
            bash "$FULLPATH/$(basename $0)"; exit $?
            ;;
    *)
            exit 0
            ;;
esac
