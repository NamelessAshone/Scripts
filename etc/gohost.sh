#! /usr/bin/env expect

set HOST    [lindex $argv 0]

set P   "1qaz@WSX"

if {[llength $HOST] == 0} {
    send_user "Usage: gohost <HOST>\n"
    send_user "Avaible host list:\n\tinformix\n\tismp\n"
}

spawn ssh $HOST
sleep 1
send_user $P
expect {
    timeout      {
        send_user "timeout\n";
        exit 1
    }
    "*password*"   {
        send "$P\r\n";
        sleep 1
        expect {
            timeout {
                send_user "timeout\n"
                exit 1
            }
            "*$*" interact
        }
    }
}
