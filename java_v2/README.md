java_v2

Author: Alex Ellis

## Running through Docker:

### Build the image first:

```
$ docker build -t java_v2 .
```

### Run the image

Here httpUrl is passed as a docker-machine container running fakeendpoint:

```
$ docker run -e httpUrl=http://192.168.99.100:3000 java_v2
```

Alternatively if a proxy is required:

```
$ docker run -e proxyHost=192.168.0.1 -e proxyPort=3128 java_v2
```

