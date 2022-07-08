kkk#!/bin/bash

#  Version : 1.0
#  Author : Pablo Salinas
#  Description : This Script works to scan ports over an IP or domain and it saves the result into a CSV file - Desgined to educational purposes 

#Variables
empty=""

#Arguments for the script
while [ "$1" != "" ]; do
	case "$1" in
		-t | --target )		target="$2";	shift;;
	esac
	shift
done

#If not argument returns help message
if [[ $target == $empty ]]; then
	echo "Please specify an IP or Domain -t or --target"
	exit
fi

# ping to the target
ping -c 1 $target > /dev/null 


clear

# conditional to check 
if test $? -eq 0
then
        echo "<<<<<<<<<<<<<<< BASH SCANPORT >>>>>>>>>>>>>>>>>>>>>>>"
        echo "Execution time: $(date)"
        echo "*****************************************************"
        function scan(){
                bash -c "echo  $'\e[1;35m'[*]$'\e[0m' port scan over $port in progress"
                #Scans ports displays open ports
                for port in $(seq 1 65536); do
                        timeout 1 bash -c "echo > /dev/tcp/$target/$port" >/dev/null 2>&1 && bash -c "echo    $target,$port,open " >> $target.csv && bash -c "echo    $'\e[1;32m'             [+] $port $'\e[0m' --is open"  &
                done
                    }
        scan
echo ""
echo "Results in >>> $target.csv"
else
        echo "************************************************************************"
        bash -c "echo $'\e[1;36m'[-]$'\e[0m'  The IP or domain does not exist"
        exit

fi
