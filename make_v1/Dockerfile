FROM alpine:edge
RUN apk add --update make bash curl && rm -rf /var/cache/apk/*
ADD ./Makefile ./
ADD ./*.sh ./
RUN chmod +x *.sh

CMD ["make", "-j", "4"]
