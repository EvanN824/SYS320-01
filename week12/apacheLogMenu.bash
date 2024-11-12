#! /bin/bash

logFile="/var/log/apache2/access.log"
iocFile="/home/champuser/SYS320-01/week12/ioc.txt"

function displayAllLogs(){
	cat "$logFile"
}

function displayOnlyIPs(){
        cat "$logFile" | cut -d ' ' -f 1 | sort -n | uniq -c
}

# function: displayOnlyPages:
# like displayOnlyIPs - but only pages
function displayOnlyPages(){
	cat "$logFile" | cut -d ' ' -f 7 | sort -n | uniq -c
}


function histogram(){

	local visitsPerDay=$(cat "$logFile" | cut -d " " -f 4,1 | tr -d '['  | sort \
                              | uniq)
	# This is for debugging, print here to see what it does to continue:
	# echo "$visitsPerDay"

        :> newtemp.txt  # what :> does is in slides
	echo "$visitsPerDay" | while read -r line;
	do
		local withoutHours=$(echo "$line" | cut -d " " -f 2 \
                                     | cut -d ":" -f 1)
		local IP=$(echo "$line" | cut -d  " " -f 1)

		local newLine="$IP $withoutHours"
		echo "$IP $withoutHours" >> newtemp.txt
	done
	cat "newtemp.txt" | sort -n | uniq -c
}

function frequentVisitors(){
	local histograms=$(histogram)
	:>newtemp.txt
	echo "$histograms" | while read -r line;
	do
		num=$(echo "$line" | cut -d " " -f 1)
		if [[ $num -gt 5 ]]; then
			echo "$line" | cut -d " " -f 1,2,3 >> newtemp.txt
		fi
	done
	cat "newtemp.txt" | sort -n
}

function suspiciousVisitors(){

	cat "$logFile" | egrep -i -f ioc.txt | cut -d '' -f1 | sort -n | uniq -c

}

while :
do
	echo "PLease select an option:"
	echo "[1] Display all Logs"
	echo "[2] Display only IPS"
	echo "[3]  Display only pages visited"
	echo "[4] Histogram"
	echo "[5] Display Frequent visitors"
	echo "[6] Display Suspicious visitors"
	echo "[7] Quit"

	read userInput
	echo ""

	if [[ "$userInput" == "7" ]]; then
		echo "Goodbye"		
		break

	elif [[ "$userInput" == "1" ]]; then
		echo "Displaying all logs:"
		displayAllLogs

	elif [[ "$userInput" == "2" ]]; then
		echo "Displaying only IPS:"
		displayOnlyIPs

	# Display only pages visited
	elif [[ "$userInput" == "3" ]]; then
		echo "Displaying only Pages:"
		displayOnlyPages

	elif [[ "$userInput" == "4" ]]; then
		echo "Histogram:"
		histogram

	elif [[ "$userInput" == "5" ]]; then
		echo "Displaying Frequent Visitors"
		frequentVisitors

	elif [[ "$userInput" == "6" ]]; then
		echo "Displaying Suspicious Visitors"
		suspiciousVisitors

	else
		echo "Invalid input, please try again"
	fi
done
