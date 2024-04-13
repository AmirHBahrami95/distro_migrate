#!/usr/bin/bash
pwdname=$(pwd | awk 'BEGIN{FS="/"} {print $NF;}')
rm ~/${pwdname} 2>/dev/null
ln -s -t ~ $(pwd)
echo "${pwdname} -> $(pwd)"
