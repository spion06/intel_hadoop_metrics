#!/bin/bash

if [ "$#" != 1 ]; then
        arg=1
else
        shift
        arg=$@
fi

/usr/bin/mpstat -P ALL $arg 1 | grep -v 'Average' | awk -v host=$(hostname)  '(!/^$/){if($0 &&!/Linux/){$1=""; $2=""; now=strftime("%s "); if($0) if(/CPU/){print "HostName","TimeStamp",$0} else{ print host,now $0}}}'
