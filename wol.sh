#!/bin/sh

# iptables -I FORWARD 1 -p tcp -d <ip> --dport 22 -m limit --limit 12/hour --limit-burst 1 -j LOG --log-prefix "WOL_LOG: " --log-level 7
# crontab: * * * * * /etc/wol.sh

LAST_ACCESS=`logread -t -l 50 | grep "WOL_LOG:" | tail -n 1 | awk '{ print $6 }' | sed -ne 's/^\[\([0-9]*\)\.[0-9]*\]$/\1/p'`
if [ -n $LAST_ACCESS ]; then
  NOW=`date +%s`
  COMPARE=`expr $NOW - 90` # In seconds

  if [ $LAST_ACCESS -ge $COMPARE ]; then
    etherwake -i br-lan <mac>
  fi
fi
