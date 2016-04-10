#!/bin/sh

if [ $2 ];
then
echo Sending env..
	docker run -e URL=$2 xservedbyfinder:go_v1 $1
else
	docker run xservedbyfinder:go_v1 $1
fi
