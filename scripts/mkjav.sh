#!/usr/bin/bash
if [[ -z $1 ]]; then
	echo "mkjav: please provide project's name"
	exit 1
fi

mkdir $1
cd $1

if [[ -z $2 ]];then
	NAMESPACE="amirh"
else
	NAMESPACE=$2
fi

PROGNAME=$1

# TODO lower&snake_case PROGNAME and NAMESPACE

# structure
mkdir -p src/com/${NAMESPACE}/${PROGNAME}/model
mkdir -p src/com/${NAMESPACE}/${PROGNAME}/view
mkdir -p src/com/${NAMESPACE}/${PROGNAME}/control
mkdir lib


echo "package com.${NAMESPACE}.${PROGNAME};

public class Main{
	
	public static void main(String[] args){

		// TODO edit this dude, obviously!
		System.out.println(\"GO FUCK YOURSELF, BASH, SERIOUSLY, FUCK YOU!!!!!\");
	}

}
">src/com/${NAMESPACE}/${PROGNAME}/Main.java

# settings
echo "#!/usr/bin/bash

# arbitrary values
PROGNAME=$1
NAMESPACE=$NAMESPACE

# compile/jvm options
LIB_PATH=lib
BIN_PATH=bin
MAIN_CLASS=com/${NAMESPACE}/${PROGNAME}/Main

# set to 'y' for logging
LOG_RUN='n'
LOG_COMPILE='n' 

# log paths
LOG_RUN_PATH=./.run.log
LOG_COMPILE_PATH=./.compile.log
">.settings
# chmod +x .settings.sh

# get pre-compile needed filenames
echo "#!/usr/bin/bash
find . -name "*.java" > .jclasses.txt
" > .find_java_files.sh
chmod +x .find_java_files.sh

# compile script
echo "#!/usr/bin/bash
source .settings
./.find_java_files.sh
if [[ \${LOG_COMPILE} == 'y' ]];then
	javac -cp \${LIB_PATH} -d \${BIN_PATH} @.jclasses.txt 2>./.compile.log || echo \"compile failed, see ./compile.log\"
else
	javac -cp \${LIB_PATH} -d \${BIN_PATH} @.jclasses.txt
fi
echo \"[compiled]\"
">compile.sh
chmod +x compile.sh

# run script
echo "#!/usr/bin/bash
source .settings
if [[ ! -d \${LIB_PATH} ]];then
	echo \"\${LIB_PATH} does not exist!\"
fi

if [[ ! -d \${BIN_PATH} || ! -f \${BIN_PATH}/\${MAIN_CLASS}.class ]];then
	echo \"program has not beend compiled, plese run ./compile\"
fi

if [[ \${LOG_RUN} == 'y' ]];then
	java -cp \${BIN_PATH}:\${LIB_PATH} \${MAIN_CLASS} 2>./.run.log || echo \"run failed, see .run.log\"
else
	java -cp \${BIN_PATH}:\${LIB_PATH} \${MAIN_CLASS}
fi

">run.sh
chmod +x run.sh

# clean script
echo "#!/usr/bin/bash
source ./.settings
rm -rf \${BIN_PATH}
rm -f .jclasses.txt
rm -f \${LOG_RUN_PATH}
rm -f \${LOG_COMPILE_PATH}
" > clean.sh
chmod +x clean.sh
echo "$1 initialized!"
