#! /usr/bin/env expect

set HOST        [lindex $argv 0]
set USER        [lindex $argv 1]
set PASSWD      [lindex $argv 2]
set URL         [lindex $argv 3]
set lastslash   [string last "/" $URL]
set lastdot     [string last "." $URL]
incr lastslash;
incr lastdot -1;
set FILE        [string range $URL $lastslash $lastdot]

if {[llength $argv] == 0} {
    send_user "Usage: vpsclone.exp <HOST> <USER> <PASSWD> <FILE-URL>\n"
    send_user "This program download file from <FILE-URL> by <USER>@<HOST>.\n"
    exit 1
}

spawn ssh -q $USER@$HOST

expect {
    timeout     { send_user "Failed to get passwd prompt\n"; exit 1 }
    eof         { send_user "SSH failure for connection from $HOST\n"; exit 1 }
    "*yes"      {
        send "yes\r";
        expect {
            "*password" { send "$PASSWD\r" }
        }
    }
    "*password" { send "$PASSWD\r" }
    "*\$*"      {}
    "*<> "      {}
}


expect {
    timeout { send_user "Login failed. Passwd incorrect\n"; exit 1}
    "*\$ "  {}
    "*\$*"  {}
    "*<> "  {}
    -re "~/ "{}
}

send "git clone $URL\r"
expect {
    "*failed" { send_user "Remote host Git clone failed\n"; exit 1 }
}
send "exit"

spawn git clone $USER@$HOST:$FILE
expect {
    "*password"     {
        send "$PASSWD\r";
        expect {
            "*failed" { send_user "Local host Git clone failed\n"; exit 1}
        }
    }
    "*failed" { send_user "Git clone failed\n"; exit 1}
}

expect {
    "*done"  { send_user "Done"; exit 0 }
}
