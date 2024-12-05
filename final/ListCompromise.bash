#! /bin/bash

logFile="/home/champuser/SYS320-01/final/access.log"
iocFile="/home/champuser/SYS320-01/final/IOC.txt"

report=$(cat "$logFile" | egrep -i -f IOC.txt | cut -d ' ' -f 1,4,7 | tr -d '[')
echo "$report" > report.txt 
