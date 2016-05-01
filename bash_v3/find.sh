#!/bin/bash
host=${1:-www.raspberrypi.org}
port=${2:-80}

if [ ${BASH_VERSINFO[0]} -lt 4 ]; then
    echo "Running docker container with bash version >= 4 ..."
    docker run -ti --rm=true -v ${PWD}:/usr/src/find ko1nksm/bash:4.3 /usr/src/find/find.sh
    exit
fi

declare -A dict
# If http
exec 3<>/dev/tcp/${host}/80
echo -e "GET / HTTP/1.1\r\nConnection: close\r\n\r\n" >&3
proto=https
while IFS='' read -r line; do
    echo $line
    if [[ ${#line} -gt 12 && ${line:0:12} = 'X-Served-By:' ]]; then
        echo "http"
        proto=http
        # trim start instead since we know it starts with X-Served...
        key=$(expr match "$line" 'X-Served-By: \(.\+\)')
        key="${key//[[:space:]]/ }"
        # save file as name instead. overwrites if existing. slow?
        dict[$key]=1
    fi
done <&3

echo "..."

if [ $proto = 'http' ];then
    echo "http"
    for i in {0..10}; do
        exec 3<>/dev/tcp/${host}/${port}
        echo -e "GET / HTTP/1.1\r\nConnection: close\r\n\r\n" >&3
        while IFS='' read -r line; do
            echo $line
            if [[ ${#line} -gt 12 && ${line:0:12} = 'X-Served-By:' ]]; then
                key=$(expr match "$line" 'X-Served-By: \(.\+\)')
                key="${key//[[:space:]]/ }"
                dict[$key]=1
                break
            fi
        done <&3
    done
else
    echo -e "HEAD / HTTP/1.1\r\nHost: ${host}\r\nConnection: close\r\n\r\n" | 
    exec 3<>openssl s_client -ign_eof -connect ${host}:443 -CAfile /etc/ssl/certs/ca-certificates.crt 2> /dev/null
    echo -e "GET / HTTP/1.1\r\nConnection: close\r\n\r\n" >&3
    while IFS='' read -r line; do
        echo $line
        if [[ ${#line} -gt 12 && ${line:0:12} = 'X-Served-By:' ]]; then
            key=$(expr match "$line" 'X-Served-By: \(.\+\)')
            key="${key//[[:space:]]/ }"
            dict[$key]=1
            break
        fi
    done <&3
fi

for K in "${!dict[@]}"; do
    echo $K;
done
