#! /bin/bash
# Author: ShuXin Shu
# Date: 2019/1/4
DESCRIPTION="This script based on *ping* command is used to test host speed with a file contain hostnames or IPs."
HELP="Usage: auto-ping.sh [option] file
$DESCRIPTION

Option:
    -c <ping-count>     control the option -c of ping command in this script, default is 4  
    -h                  print help
"

# parse args 
ping_count=4
while getopts :c:h opt
do
    case "$opt" in
        c) ping_count=$OPTARG;;
        h) echo "$HELP"
           exit 0;;
        *) echo "Unknown option $opt";;
    esac
done
shift $[ $OPTIND - 1 ]

# do pings
count=1
while read line
do
    result=$(ping -c $ping_count $line | grep 'loss')
    echo "[Host $count] $line -> $result"
    count=$[ $count + 1 ]
done < $1
echo "Speed test done. Total $count host."