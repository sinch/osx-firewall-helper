#!/usr/bin/env bash
set -e # exit on all errors

# Setup sensible default settings for OS X Application Firewall
#
# IMPORTANT: socketfilterfw must be executed with `sudo`
#
# LOGGING: tail -f /var/log/appfirewall.log

SFFW="/usr/libexec/ApplicationFirewall/socketfilterfw"

sudo $SFFW --setallowsigned on
sudo $SFFW --setblockall off
sudo $SFFW --setloggingmode off
sudo $SFFW --setstealthmode off
sudo $SFFW --setglobalstate on # Must be the last one.
