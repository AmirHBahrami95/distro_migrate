#!/bin/bash
awk -v alias_name=$1 \
'BEGIN{ \
  if(!alias_name) { \
    alias_name= "^alias\.*"; \
    print_alias=1; \
  } \
  else alias_name= "alias " alias_name "=(\.*)"; \
} \
$0 ~ alias_name{ \
  split($0,pure_shit,"="); \
  if(print_alias) { \
    pure_shit[2]= pure_shit[1] " : " pure_shit[2]; \
    n=split(pure_shit[2],pure_shit,"alias "); \
    pure_shit[2]= pure_shit[1] " " pure_shit[2]; \
  } \
  if(pure_shit[2]) print pure_shit[2]; \
} \
' ~/.bash_alias
