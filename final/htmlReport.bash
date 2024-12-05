#! /bin/bash

echo "<html>" > report.html

echo "<head>" >> report.html
#echo "<title>Access logs with IOC Indicators:</title>"
echo "<style> table, td {border: 1px solid black; } </style>" >> report.html
echo "</head>" >> report.html

echo "<body>" >> report.html
echo "<table>" >> report.html

while read -r line 
do
echo "<tr>" >> report.html
#read -a data <<< "$line"

for i in $line
do
echo "<td>" >> report.html
echo "$i" >> report.html
echo "</td>" >> report.html
done

echo "</tr>" >> report.html
done < report.txt

echo "</table>" >> report.html
echo "</body>" >> report.html
echo "</html>" >> report.html

mv report.html /var/www/html/report.html
