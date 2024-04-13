#!/bin/bash

if [ -z $1 ];then
	echo "mkcee: please give a name for the program"
	exit 1
fi

PROG_NAME=$1
PROG_NAME=$(echo "${PROG_NAME}" | tr -d "\n" | tr -s [:space:] "_" | tr -d [:digit:] | tr -s [:upper:] [:lower:])
HEADER_NAME=$(echo "${PROG_NAME}" | tr [:lower:] [:upper:])

# initializing files and dirs
mkdir -p ${PROG_NAME}
cd ${PROG_NAME}
mkdir -p hdr src

# hdr/prog
echo "#ifndef __${HEADER_NAME}_H
	#define __${HEADER_NAME}_H 1
#endif
" >> hdr/${PROG_NAME}.h

# src/prog
echo "#ifndef __${HEADER_NAME}_H
	#include \"../hdr/${PROG_NAME}.h\"
#endif
" >> src/${PROG_NAME}.c

# src/main
echo "#ifndef __${HEADER_NAME}_H
	#include \"../hdr/${PROG_NAME}.h\"
#endif

#ifndef __STDIO_H
	#include <stdio.h>
#endif

int main(int argc,char **argv){
	// add code here (if you're a prick and need guidance)
	puts(\"fuck you, from ${PROG_NAME}!\");
	return 0;
}
" >> src/main.c

# <---- Makefile ------------------------------------
# Alternatively : copy a Makefile template and just edit it line by line
echo "CC=gcc
PROGNAME=${PROG_NAME}
run_args=shit lord
                                   
.PHONY: link_all make_bin clean run
">> Makefile

echo "link_all : main \$(PROGNAME)
	\$(CC) -o bin/\$(PROGNAME) bin/*.o
">> Makefile

echo "run: link_all
	./bin/\$(PROGNAME)
">> Makefile

echo "main : make_bin src/main.c
	\$(CC) -c src/main.c -o bin/main.o
" >> Makefile

echo "\$(PROGNAME) : make_bin src/\$(PROGNAME).c
	gcc -c src/\$(PROGNAME).c -o bin/\$(PROGNAME).o
">> Makefile

echo "make_bin:
	mkdir -p bin
" >> Makefile

echo "clean:
	rm -rf bin/
	echo 'cleaned'
" >> Makefile

# -------------------------------------------------->
echo "$PROG_NAME initialized."
