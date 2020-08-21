#!/bin/sh

# iptables -I FORWARD 1 -p tcp -d <ip> --dport 22 -m limit --limit 30/hour --limit-burst 1 -j LOG --log-prefix "WOL_LOG: " --log-level 7
# crontab: */2 * * * * /etc/wol.sh
#
# To attempt to avoid waking up from random port attacks:
# * Wait for two SSH requests within 6 minutes
# * Ensure that etherwake was not sent after the last SSH request

LOGS=`logread -t -l 50`
LAST_TWO_WOL_TRIGGERS=`\
    echo "$LOGS" | \
    grep "WOL_LOG:" | \
    tail -n 2 | \
    awk '{ print $6 }' | \
    sed -ne 's/^\[\([0-9]*\)\.[0-9]*\]$/\1/p'`

WOL_TRIGGERS_LINES=`echo "$LAST_TWO_WOL_TRIGGERS" | wc -l`
if [ "$WOL_TRIGGERS_LINES" -ne "2" ]; then
  exit 0
fi

WOL_LINE_1=`echo "$LAST_TWO_WOL_TRIGGERS" | head -n 1`

LAST_WOL_SENT=`\
    echo "$LOGS" | \
    grep "Sent Wake-On-LAN" | \
    tail -n 1 | \
    awk '{ print $6 }' | \
    sed -ne 's/^\[\([0-9]*\)\.[0-9]*\]$/\1/p'`
if [ -n "$LAST_WOL_SENT" ] && [ "$WOL_LINE_1" -lt "$LAST_WOL_SENT" ]; then
  exit 0
fi

NOW=`date +%s`
COMPARE=`expr $NOW - 360` # In seconds
if [ "$WOL_LINE_1" -ge "$COMPARE" ]; then
  etherwake -i br-lan <mac>
  logger "Sent Wake-On-LAN"
fi
