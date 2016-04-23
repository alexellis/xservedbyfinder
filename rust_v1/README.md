# Rust

An example written using [Rust](https://www.rust-lang.org).

## Pre requisites

1. Docker.
2. Rust Docker image => `docker pull schickling/rust`

## Running

```
docker run --rm -v $PWD:/source schickling/rust cargo run
```

*Note: On Windows you will need to replace $PWD with the absolute path of the
root folder of this solution*
