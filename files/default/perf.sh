#!/bin/bash

script_dir=$(dirname $0)
perf_tmp=$script_dir/perftmp
[[ ! -d $perf_tmp ]] && mkdir -p $perf_tmp
i=$(date +%s)
perf_file=$perf_tmp/$i
perf record -a -F 1000 -o $perf_file sleep 1 2> /dev/null
(perf report -i $perf_file 2>/dev/null) 1>&1 | awk -v outfile=$i -v host=$(hostname) '(!/^#/ && !/^$/){if($1 >= 0.01)print host,outfile,$0 }' | sed -e 's/\s\+//7g' -e 's/%//g' 
rm -f $perf_file
