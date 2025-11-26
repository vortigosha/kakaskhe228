#!/usr/bin/env bash

# find app in default paths
CO_PWD=~/Applications/CrossOver.app/Contents/MacOS
test -d "${CO_PWD}" || CO_PWD=/Applications/CrossOver.app/Contents/MacOS

test -d "${CO_PWD}" || (echo 'unable to detect app path. exiting...' && exit)

PWD="${CO_PWD}"
cd "${PWD}"

PROC_NAME='CrossOver'
# get all pids of CrossOver
pids=(`pgrep "${PROC_NAME}"`, `pidof "${PROC_NAME}"`, `ps -Ac | grep -m1 "${PROC_NAME}" | awk '{print $1}'`)
pids=`echo ${pids[*]}|tr ',' ' '`

# kills CrossOver process if it is running
[ "${pids}" ] && kill -9 `echo "${pids}"` > /dev/null 2>&1

if [ -f CrossOver.origin ]; then
  echo 'original file found. Roll it back and exit.'
  mv CrossOver.origin CrossOver
  exit
fi;

echo 'original file not found.'