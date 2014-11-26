#!/bin/bash

if [ "$#" -lt 2 ]; then
  echo
  echo "Used to determinate partition size parameters!"
  echo "Usage: $0 [partition name] [size|used|perc]"
  exit 0
fi

CACHE_FILE=~/.conky/cache/rpi_df

if [ ! -f $CACHE_FILE ]; then
  echo "N/A"
  exit 0
fi

parse_df() {
  # function variables
  local to_grep=$1
  local to_awk=$2

  echo $(cat $CACHE_FILE | grep $to_grep | awk "{ print \$$to_awk }")
}

case $2 in
  "size")
    echo $(parse_df $1 2);;
  "used")
    echo $(parse_df $1 3);;
  "perc")
    echo $(parse_df $1 5 | cut -f1 -d"%");;
  *) echo "N/A";;
esac

