#!/bin/bash

cpu_freq=$(sudo powermetrics -i 1000 -n 1 -s cpu_power \
    | grep "System Average frequency as fraction of nominal" \
    | awk '{sum += substr($8, 1, length($8)-1)} END {print sum/NR}')

load1=$(uptime | rg -o "load average: (.*?)," -r "\$1")

load1round=$( printf "%.0f" $load1 )

echo " $load1round / $cpu_freq%"
