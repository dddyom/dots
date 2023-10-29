#! /bin/bash

UPDATES=$(checkupdates)

if [ -n "$UPDATES" ]; then
  NOTIFY_TEXT=$(printf "Have you updated:\n$UPDATES")
  notify-send "$NOTIFY_TEXT" 
fi



