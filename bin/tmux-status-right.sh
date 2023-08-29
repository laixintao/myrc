#!/bin/bash


load1=$(uptime | rg -o "load average: (.*?)," -r "\$1")


echo $load1
