#!/bin/sh
set -e
route delete -net default -interface ppp0
route add -net default -interface en0
route add -net 38.97.6.5 -interface ppp0
route add -net 172.16.0.0 -netmask 255.240.0.0 -interface ppp0
