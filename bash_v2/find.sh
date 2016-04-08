#!/bin/sh

for i in {1..100} ; do curl -s -I https://www.raspberrypi.org/ ; done \
    | grep X-Served-By | cut -d”:” -f 2 | sort | uniq


