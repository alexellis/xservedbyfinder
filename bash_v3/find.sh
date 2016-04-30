#!/bin/bash
if [ ${BASH_VERSINFO[0]} -lt 4 ]; then
    echo "Running docker container with bash version >= 4 ..."
    docker run -ti --rm=true -v ${PWD}:/usr/src/find ko1nksm/bash:4.3 /usr/src/find/find.sh
else
    declare -A dict
    for i in {0..100}; do
        exec 3<>/dev/tcp/172.17.0.1/3000
        echo -e "HEAD / HTTP/1.1\r\nConnection: close\r\n\r\n" >&3
        while IFS='' read -r line; do
            if [[ ${#line} -gt 12 && ${line:0:12} = 'X-Served-By:' ]]; then
                key=$(expr match "$line" 'X-Served-By: \(.\+\)')
                key="${key//[[:space:]]/ }"
                dict[$key]=1
                break
            fi
        done <&3
    done

    for K in "${!dict[@]}"; do
        echo $K;
    done
fi