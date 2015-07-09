#!/usr/bin/env bash
set -e # exit on all errors
#
# Script to allow a specific executable to open incoming connections
# by modifying the OS X Application Firewall.
#
# IMPORTANT: socketfilterfw only works with full absolute paths to executables
# IMPORTANT: socketfilterfw must be executed with `sudo`
#
# LOGGING: tail -f /var/log/appfirewall.log

SFFW="/usr/libexec/ApplicationFirewall/socketfilterfw"

if [ "$#" -ne 1 ]; then
    echo "$(basename $0): <path to executable>"
    exit 1
fi

function my_abspath(){
    local fdir="$( cd "$( dirname "$1" )" && pwd )"
    local fname="$(basename "$1")"
    echo "${fdir}/${fname}"
}

MY_EXECUTABLE_PATH=$(my_abspath "$1")

IS_ALREADY_PART_OF_FW=0
set +e
sudo $SFFW --list | grep "$MY_EXECUTABLE_PATH" > /dev/null
if [ $? -eq 0 ]; then
    IS_ALREADY_PART_OF_FW=1
fi
set -e
if [ $IS_ALREADY_PART_OF_FW -eq 1 ]; then
    # The application path is already a part of the firewall.
    # Remove before re-adding 
    sudo $SFFW --remove "$MY_EXECUTABLE_PATH"
fi

sudo $SFFW --add "$MY_EXECUTABLE_PATH"
sudo $SFFW --unblockapp "$MY_EXECUTABLE_PATH"
