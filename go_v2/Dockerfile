FROM alpine

RUN apk update && apk add 'go=1.5.3-r0' && rm -rf /var/cache/apk/*

ENV GOROOT /usr/lib/go
ENV GOPATH /gopath
ENV GOBIN /gopath/bin
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin

ADD *.go /gopath/
WORKDIR /gopath/

RUN go build *.go
ENTRYPOINT ["/gopath/xservedby"]
