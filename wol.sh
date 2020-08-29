#!/bin/sh

# crontab: */2 * * * * /etc/wol.sh
#
# /etc/fwknop/access.conf
# SOURCE                 ANY
# OPEN_PORTS             tcp/<port>
# KEY_BASE64             CHANGEME
# HMAC_KEY_BASE64        CHANGEME
# REQUIRE_SOURCE_ADDRESS Y
# FORCE_NAT              <ip> 22

LOGS=`logread -t -l 50`
LAST_WOL_TRIGGER=`echo "$LOGS" | grep "Added FORWARD rule to FWKNOP_FORWARD.* tcp/<port>," | tail -n 1 | awk '{ print $6 }' | sed -ne 's/^\[\([0-9]*\)\.[0-9]*\]$/\1/p'`
if [ -n "$LAST_WOL_TRIGGER" ]; then
  LAST_WOL_SENT=`echo "$LOGS" | grep "Sent Wake-On-LAN" | tail -n 1 | awk '{ print $6 }' | sed -ne 's/^\[\([0-9]*\)\.[0-9]*\]$/\1/p'`

  if [ -z "$LAST_WOL_SENT" ] || [ "$LAST_WOL_TRIGGER" -gt "$LAST_WOL_SENT" ]; then
    etherwake -i br-lan <mac>
    logger "Sent Wake-On-LAN"
  fi
fi
