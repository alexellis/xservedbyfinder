#!/bin/sh

for i in {1..100} ; do HEAD -E https://www.raspberrypi.org/ ; done | grep X-Served-By | sort | uniq
