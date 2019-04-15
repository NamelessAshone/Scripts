#! /usr/bin/env expect

if [ -z $VPS_HOST ] || [ -z $VPS_PASSWD ]; then
    echo \$VPS_HOST is undefined.
else
    if [ -z $VPS_PASSWD]; then
        echo \$VPS_PASSWD is undefined.
    fi

fi

ssh ash "wget ${1}"
sftp ash:${1##*/}
