#!/bin/bash


load1=$(uptime | rg -o "load average: (.*?)," -r "\$1")

load1round=$( printf "%.0f" $load1 )

echo $load1round
