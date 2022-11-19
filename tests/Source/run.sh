#!/usr/bin/env bash

zenity_bin=$(which zenity)

if [[ -z $zenity_bin ]] ; then
  echo "Zenity was not found in PATH. Is it installed?"
  exit 1
fi

$zenity_bin --question --text="Greetings $USER!\\n💥💥💥\\nHas it been a good Delve so far?"