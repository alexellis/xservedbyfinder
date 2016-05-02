FROM schickling/rust:latest
MAINTAINER Chris Neave <chrispneave@gmail.com>

COPY . /source
WORKDIR /source
RUN cargo build

ENTRYPOINT ["cargo", "run"]
