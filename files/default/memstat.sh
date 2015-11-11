#!/bin/bash

if [ "$#" != 1 ]; then
        arg=1
else
        shift
        arg=$@
fi

/usr/bin/sar -rSB $arg 1 | awk -v host=$(hostname) '(!/^$/){if($0 && !/Linux/){if($0){$1="";$2="";if(/pgpgin/)now=strftime("%s ");if(NR>3 && NR%9==3){if(/pgpgin/){print "HostName", "TimeStamp " header"\n" host, now val;header=""; val=""}else {print host, now header"\n" host, now val;header=""; val=""}};if(NR%3==0) {header=header" "$0;}; if(NR%3==1) val=val" "$0; }}}'
