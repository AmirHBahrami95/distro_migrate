#!/usr/bin/bash
if [ -z $1 ] || [ -z $2 ] || [ -z $3 ];then
	echo "usage: ./valsha SHA_PROGNAME FILENAME EXPECTED_HASH"
	echo "(SHA_PROGNAME can be sha512sum | sha256sum | ...)"
	exit
fi

METHOD=$1
FNAME=$2
EXPECTED_HASH=$3
FILE_HASH=$($METHOD $FNAME | awk '{print $1}')

if [ $FILE_HASH != $EXPECTED_HASH ];then 
	echo "!!!!NOT_EQUAL!!!"
else
	echo "[passed]"
fi
