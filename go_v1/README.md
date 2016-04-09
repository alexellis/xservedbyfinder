Go

I have written the following Go code through trial & error and 'Googling'.

* Update Dockerfile with hard-coded IP address, so that VirtualBox etc can reach test endpoint on your machine.

```
ENV URL http://192.168.64.1:3000
```

or use the live Raspberry PI website


* Build out an image ./build_docker.sh
* Run the example ./run_docker.sh <num_requests>


