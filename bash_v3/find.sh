#!/bin/bash
host=${1:-www.raspberrypi.org}
port=${2:-80}

if [ ${BASH_VERSINFO[0]} -lt 4 ]; then
    echo "Running docker container with bash version >= 4 ..."
    docker run -ti --rm=true -v ${PWD}:/usr/src/find ko1nksm/bash:4.3 /usr/src/find/find.sh $host $port
    exit
fi

req="HEAD / HTTP/1.1\r\nHost: ${host}\r\nConnection: close\r\n\r\n"
declare -A dict
exec 3<>/dev/tcp/${host}/${port}
echo -e "${req}" >&3
proto=https
while IFS='' read -r line; do
    if [[ ${#line} -gt 12 && ${line:0:12} = 'X-Served-By:' ]]; then
        proto=http
        key=${line:13}
        key="${key//[[:space:]]/ }"
        dict[$key]=1
    fi
done <&3

if [ $proto = 'http' ];then
    echo "http"
    for i in {0..100}; do
        exec 3<>/dev/tcp/${host}/${port}
        echo -e "${req}" >&3
        while IFS='' read -r line; do
            if [[ ${#line} -gt 12 && ${line:0:12} = 'X-Served-By:' ]]; then
                key=${line:13}
                key="${key//[[:space:]]/ }"
                # TODO: save file as name instead. overwrites if existing. slow?
                dict[$key]=1
                break
            fi
        done <&3
    done
else
    echo "https"
    req="HEAD / HTTP/1.1\r\nHost: ${host}\r\n"
    close="${req}Connection: close\r\n\r\n"
    while IFS='' read -r line; do
        # TODO: trim start instead since we know it starts with X-Served...
        if [[ ${#line} -gt 12 && ${line:0:12} = 'X-Served-By:' ]]; then
            key=${line:13}
            #key="${key//[[:space:]]/ }"
            # TODO: save file as name instead. overwrites if existing. slow?
            dict[$key]=1
            continue
        fi
    done < <((for i in {0..100};do echo -e "${req}\r\n";done;echo -e "${close}") \
        |openssl s_client -ign_eof -connect ${host}:443 -CAfile /etc/ssl/certs/ca-certificates.crt 2> /dev/null)
fi

for K in "${!dict[@]}"; do
    echo $K;
done
