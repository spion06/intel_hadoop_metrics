#!/bin/bash

if [ "$#" != 1 ]; then
        arg=1
else
        shift
        arg=$@
fi

/usr/bin/vmstat -n $arg 1 | awk -v host=$(hostname) '(!/procs/) && (!/^$/){now=strftime("%s ");if($0 && !/Linux/) if(/swpd/){print "HostName","TimeStamp",$0} else{ print host,now $0}}'
