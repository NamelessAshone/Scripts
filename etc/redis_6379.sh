#!/bin/sh
# Auther: Shu Shuxin
# Date: 2019-07-25
# This script is for *start | stop | restart* redis. Based on a script
# in the book 'Redis入门'. This script  add  a *restart* argument  for
# restart redis.

BLUE="\033[34m"
GREEN="\033[32m"
YELLOW="\033[33m"
RESET="\033[0m"

REDISPORT=6379
EXEC=/usr/bin/redis-server
CLIEXEC=/usr/bin/redis-cli

PIDFILE=/var/run/redis_${REDISPORT}.pid
CONF=/etc/redis.conf

do_start() {
    if [ -f $PIDFILE ]
    then
	    printf "%s\n""${YELLOW}$(date +'%Y-%m-%d %H:%M:%s') ${BLUE}${PIDFILE} file exists, process is already running or crashed${RESET}"
        return 1
    else
        $EXEC $CONF &
	printf "%s\n""${YELLOW}$(date +'%Y-%m-%d %H:%M:%s') ${GREEN}Starting Redis server...${RESET}"
        return 0
    fi
}

do_stop() {
    if [ ! -f $PIDFILE ]
    then
        printf "%s\n""${YELLOW}$(date +'%Y-%m-%d %H:%M:%s') ${BLUE}${PIDFILE} file dose not exists, process is not running${RESET}"
        return 1
    else
        PID=$(cat $PIDFILE)
        printf "%s\n""${YELLOW}$(date +'%Y-%m-%d %H:%M:%s') ${BLUE}Stoping ...${RESET}"
        $CLIEXEC -p $REDISPORT shutdown
        while [ -x /proc/"${PID}" ]
	do
            printf "%s\n""${YELLOW}$(date +'%Y-%m-%d %H:%M:%s') ${BLUE}Waiting to stop...${RESET}"
            sleep 1
        done
        return 0
    fi
}

do_restart() {
    if [ ! -f $PIDFILE ]
    then
        printf "%s\n""${YELLOW}$(date +'%Y-%m-%d %H:%M:%s') ${BLUE}${PIDFILE} file dose not exists, process is not running${RESET}"
    else
        PID=$(cat $PIDFILE)
        printf "%s\n""${YELLOW}$(date +'%Y-%m-%d %H:%M:%s') ${BLUE}Stoping ...${RESET}"
        $CLIEXEC -p $REDISPORT shutdown
        while [ -x /proc/"${PID}" ]
	do
            printf "%s\n""${YELLOW}$(date +'%Y-%m-%d %H:%M:%s') ${BLUE}Waiting to stop...${RESET}"
            sleep 1
        done
    fi

    printf "%s\n""${YELLOW}$(date +'%Y-%m-%d %H:%M:%s') ${BLUE}Starting Redis server...${RESET}"
    $EXEC $CONF &

    return 0
}

case $1 in
    start)
        do_start
	printf "%s\n""${YELLOW}$(date +'%Y-%m-%d %H:%M:%s') ${GREEN}done${RESET}"
        ;;
    stop)
        do_stop
	printf "%s\n""${YELLOW}$(date +'%Y-%m-%d %H:%M:%s') ${GREEN}done${RESET}"
        ;;
    restart)
        do_restart
	printf "%s\n""${YELLOW}$(date +'%Y-%m-%d %H:%M:%s') ${GREEN}done${RESET}"
        ;;
    *) printf "%s\n""Usage: redis_<port>.sh start|stop|restart"
        ;;
esac
