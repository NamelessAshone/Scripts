#! /usr/bin/env expect

set P               "1qaz@WSX"
set P2              "INtd!@#123"
set P3              "EBupt!@#123"
set FALSE           0
set TRUE            1
set IS_GBK_USED     $FALSE
set IS_SFTP_USED    $FALSE
set IS_CMD_USED     $FALSE
set IS_ARGS_EMPTY   $FALSE
set CMD             ""
# Host using P2
set HOST_P2_LIST    {hdh bms bms-ykdhyh yyht}
set HOST_P3_LIST    {gp_nginx gp1 gp2}

# def proc for dispatch cmd
proc do_cmd {pcmd} {
    array set cmds {
        "list" "do_list"
        "help" "do_help"
    }
    foreach {cmd proc_name} [array get cmds] {
        if { $cmd == $pcmd } {
            $proc_name
        }
    }
    exit 0
}

# TODO: need a more simple way, reduce dependency
proc do_list {} {
    puts [exec cat /home/ash/.ssh/config | gawk -f/home/ash/Codes/Scripts/etc/list.awk]
    exit 0
}

proc do_help {} {
    set usage_str "Usage:\tgohost <OPTIONS> <HOST>\n\tgohost <HOST> <OPTIONS> \
    \n\nQuick connect to host. SSH and SFTP both are accepted. \
    \n\n<OPTIONS>:\n\t-g, --gbk, --GBK\tUsing 'luit -encoding GBK' \
    \n\t-s, --sftp\t\tUsing 'sftp'\n"
    puts "$usage_str"
    exit 0
}

# TODO: rewrite following logic in one proc
# Print usage
if { $argc == 0 } {
    set IS_ARGS_EMPTY $TRUE
    do_help
}

# Parse arguments
foreach parg $argv {
    if { $parg == "--GBK" || $parg == "--gbk" || $parg == "-g" } {
        set IS_GBK_USED $TRUE
    } elseif { $parg == "--sftp" || $parg == "-s" } {
        set IS_SFTP_USED $TRUE
    } elseif { $parg == "-h" } {
        do_help()
    } elseif { $parg == "list" } {
        set IS_CMD_USED $TRUE
        set CMD "list"
    } else {
        set HOST $parg
    }
}


if { $IS_CMD_USED } {
    do_cmd $CMD
    exit 0
}

foreach phost $HOST_P2_LIST {
    if { $phost == $HOST } {
        set P "$P2"
    }
}

foreach phost $HOST_P3_LIST {
    if { $phost == $HOST } {
        set P "$P3"
    }
}

if { $IS_SFTP_USED } {
    set CMD "sftp"
} else {
    set CMD "ssh"
}
if { $IS_GBK_USED } {
    set CTR_PREFIX "luit -encoding GBK"
} else {
    set CTR_PREFIX ""
}

# Do spawn
set SPAWN_ACTION "$CTR_PREFIX $CMD $HOST"
spawn {*}$SPAWN_ACTION

sleep 1
expect {
    timeout {
        send_user "timeout\n"
        exit 1
    }
    "*password*" {
        send    "$P\r\n"
        sleep   1
        expect {
            timeout {
                send_user "timeout\n"
                exit 1
            }
            "*$*"       interact
            "*sftp>*"   interact
        }
    }
}
