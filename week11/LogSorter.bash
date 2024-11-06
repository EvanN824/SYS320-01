#!bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$file" | grep ".html" | cut -d' ' -f7 | tr -d "/")
}

function getCurlLogs(){
allLogs=$(cat "$file" | grep "curl" | cut -d' ' -f1,12)
}

function sortLogs()
{
sortedLogs=$(echo "$allLogs" | sort | uniq -c)
}

getCurlLogs
sortLogs
echo "$sortedLogs"
