#!/bin/sh

# iptables -I FORWARD 1 -p tcp -d <ip> --dport 22 -m limit --limit 12/hour --limit-burst 1 -j LOG --log-prefix "WOL_LOG: " --log-level 7
# crontab: */2 * * * * /etc/wol.sh
#
# /etc/fwknop/access.conf
# SOURCE                 ANY
# OPEN_PORTS             tcp/22
# KEY_BASE64             CHANGEME
# HMAC_KEY_BASE64        CHANGEME
# REQUIRE_SOURCE_ADDRESS Y
# FORCE_NAT              <ip> 22

LOGS=`logread -t -l 50`
LAST_WOL_TRIGGER=`echo "$LOGS" | grep "WOL_LOG:" | tail -n 1 | awk '{ print $6 }' | sed -ne 's/^\[\([0-9]*\)\.[0-9]*\]$/\1/p'`
if [ -n "$LAST_WOL_TRIGGER" ]; then
  LAST_WOL_SENT=`echo "$LOGS" | grep "Sent Wake-On-LAN" | tail -n 1 | awk '{ print $6 }' | sed -ne 's/^\[\([0-9]*\)\.[0-9]*\]$/\1/p'`

  if [ -z "$LAST_WOL_SENT" ] || [ "$LAST_WOL_TRIGGER" -gt "$LAST_WOL_SENT" ]; then
    etherwake -i br-lan <mac>
    logger "Sent Wake-On-LAN"
  fi
fi
