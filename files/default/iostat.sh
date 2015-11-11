#!/bin/bash

if [ "$#" != 1 ]; then
        arg=1
else
        shift
        arg=$@
fi

/usr/bin/iostat -x -k -d -y $arg 1 | awk -v host=$(hostname) '(!/^$/){now=strftime("%s ");if(/Device:/){print "HostName","TimeStamp", $0} else{ if($0 && !/Linux/) print host, now $0}}'
