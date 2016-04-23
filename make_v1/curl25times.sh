#!/bin/bash

if [ -z $TARGET_URL ]
then
    export TARGET_URL=http://localhost:3000
fi

for i in {1..25} ; do curl -s -I $TARGET_URL ; done | grep X-Served-By | cut -d":" -f 2 | sort | uniq
