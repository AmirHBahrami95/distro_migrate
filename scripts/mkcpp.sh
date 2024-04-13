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
mkdir -p h src

# hdr/prog
echo "#ifndef LIBS_H
	#define LIBS_H 1
	// put library #include statements here
	#include <iostream>
#endif
" >> h/libs.h

# src/main
echo "#ifndef LIBS_H
	#include \"../h/libs.h\"
#endif

int main(){
	
	std::cout<<\"${PROG_NAME}: compiled with c++ \"<<__cplusplus/100<<std::endl;
	std::cout<<\"--by $(whoami) \"<<std::endl;

	return 0;
}
" >> src/main.cpp

# <---- Makefile ------------------------------------
# Alternatively : copy a Makefile template and just edit it line by line
echo "CC= g++
PROGNAME= ${PROG_NAME}
PROD_FLAGS= -O2 -DNDEBUG
DEBUG_FLAGS= -ggdb
COMPILER_FLAGS= -pedantic-errors -std=c++17 -Wall -Wextra -Weffc++ -Wconversion -Wsign-conversion
CLASSNAMES= main
run_args= shit lord

.PHONY: dev prod run make_bin clean run to_prod to_dev deb_flgs

#-----------------------------MAIN---------------------------->

dev: to_dev \$(CLASSNAMES)
	\$(CC) \$(BUILD_FLAGS) -o bin/\$(PROGNAME) bin/*.o

prod: to_prod \$(CLASSNAMES)
	\$(CC) \$(BUILD_FLAGS) -o bin/\$(PROGNAME) bin/*.o

run: dev
	./bin/\$(PROGNAME)

run_prod: prod
	./bin/\$(PROGNAME)

#-----------------------------CLASSES---------------------------->

main : make_bin src/main.cpp
	\$(CC) \$(COMPILER_FLAGS) \$(BUILD_FLAGS) -c src/main.cpp -o bin/main.o

#-----------------------------ARBITRARY---------------------------->

make_bin:
	mkdir -p bin

to_prod:
	\$(eval BUILD_FLAGS= \$(PROD_FLAGS))

to_dev:
	\$(eval BUILD_FLAGS= \$(DEBUG_FLAGS))

clean:
	rm -rf bin/
	echo 'cleaned'
" >> Makefile

# -------------------------------------------------->
echo "$PROG_NAME initialized."
