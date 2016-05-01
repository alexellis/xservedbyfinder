# Rust

An example written using [Rust](https://www.rust-lang.org).

## Pre requisites

1. Docker.
2. Rust Docker image => `docker pull schickling/rust`

## Running

```
docker run --rm -v $PWD:/source schickling/rust cargo run -- 127.0.0.1:3000
```

On Windows you will need to replace $PWD with the absolute path of the
root folder of this solution.

Alternatively, you can build an image from the Dockerfile and run a new container
based on it:

```
docker build --tag="chrisneave/rust_v1" .

docker run --rm chrisneave/rust_v1 127.0.0.1:3000
```
