#!/usr/bin/bash

if [[ -z $1 ]];then
	echo "give me some ip range, you prick! (only class c)"
	exit 1
fi
	

for ip in {1..255}; do
	ping -c 1 -W 1 $1.$ip 2>/dev/null | grep "64 bytes" | awk '{print $4}' | tr -d ":" &
done
