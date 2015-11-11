#!/bin/bash

echo MapCount ReduceCount
echo $[$(ps aux | grep _m_ | wc -l) - 1] $[$(ps aux | grep _r_ | wc -l) - 1]
