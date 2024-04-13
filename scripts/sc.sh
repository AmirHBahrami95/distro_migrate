#!/bin/bash
echo $1 | tr -t [:upper:] [:lower:] | tr -t " " "_"
