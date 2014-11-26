#!/bin/bash

CACHE_FILE=~/.conky/cache/calendar

if [ "$#" -lt 1 ]; then
  echo
  echo "Used to read calendar events from cache!"
  echo "Usage: $0 [line number]"
  exit 0
fi

if [ ! -f $CACHE_FILE ]; then
  echo "N/A"
  exit 0
fi

line_count=$(wc -l < $CACHE_FILE)

if [ $1 -gt $line_count ]; then
  echo '-'
else
  echo $(cat $CACHE_FILE | awk "NR==$1")
fi
