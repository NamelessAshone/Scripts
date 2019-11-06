#! /usr/bin/env expect

set P               "1qaz@WSX"
set P2              "INtd!@#123"
set FALSE           0
set TRUE            1
set IS_GBK_USED     $FALSE
set IS_SFTP_USED    $FALSE
# Host using P2
set HOST_P2_LIST    {hdh bms bms-ykdhyh yyht}

# Print usage
if { $argc == 0 } {
    send_user "Usage:\tgohost <OPTIONS> <HOST>\n\tgohost <HOST> <OPTIONS>"
    send_user "\n\nQuick connect to host. SSH and SFTP both are accepted."
    send_user "\n\n<OPTIONS>:\n\t-g, --gbk, --GBK\tUsing 'luit -encoding GBK'"
    send_user "\n\t-s, --sftp\t\tUsing 'sftp'"
    send_user "\n"
    exit 0
}

# Parse arguments
foreach parg $argv {
    if { $parg == "--GBK" || $parg == "--gbk" || $parg == "-g" } {
        set IS_GBK_USED $TRUE
    } elseif { $parg == "--sftp" || $parg == "-s" } {
        set IS_SFTP_USED $TRUE
    } else {
        set HOST $parg
    }
}

foreach phost $HOST_P2_LIST {
    if { $phost == $HOST } {
        set P "$P2"
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
