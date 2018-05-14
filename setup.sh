#!/bin/sh
htpasswd -b -c /etc/squid/passwords ${AUTH_USER} ${AUTH_PASS}
