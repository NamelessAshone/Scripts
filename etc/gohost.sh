#! /usr/bin/env expect

set HOST        [lindex $argv 0]
set ENCODING    [lindex $argv 1]
set IS_SFTP     [lindex $argv 2]
set P           "1qaz@WSX"
set P2          "INtd!@#123"

if { [llength $HOST] == 0} {
    send_user "Usage: gohost <HOST> [ gbk | GBK ]\n"
    send_user "Add argument GBK/gbk to connecting <host> with GBK encoding. This feature POWERED BY 'luit'."
    send_user "Avaible host list:\n\tinformix\n\tismp\n"
}

if { $HOST == "hdh" } {
    set P "$P2"
}
if { $IS_SFTP == "SFTP" || $IS_SFTP == "sftp"} {
    spawn sftp $HOST
} else {
    if { $ENCODING == "GBK" || $ENCODING == "gbk" } {
        spawn luit -encoding GBK ssh $HOST
    } else {
        spawn ssh $HOST
    }
}

sleep 1
# send_user $P
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
            "*sftp>*" interact
        }
    }
}
