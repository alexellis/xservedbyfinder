FROM alpine

RUN apk update && apk add curl git bzr 'go=1.5.3-r0' && rm -rf /var/cache/apk/*

ENV GOROOT /usr/lib/go
ENV GOPATH /gopath
ENV GOBIN /gopath/bin
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

ENV URL http://www.raspberrypi.org/

ADD app.go /gopath/
WORKDIR /gopath/

RUN go build app.go
ENTRYPOINT ["/gopath/app"]

