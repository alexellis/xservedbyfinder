xservedbyfinder
===============

Coded in Prolog
---------------

Uses SWI Prolog to execute a recursive predicate 100 times that appends the x-served-by header to a list. Once the counter reaches zero, the list is sorted to make it unique and the written to the console.

Usage

    docker build -t sktb/xservedby_prolog .
    docker run sktb/xservedby_prolog

By default the code will run against [http://localhost:3000/]. To change this, set the TARGET_URL environment variable on the docker command line.

    docker run -e "TARGET_URL=https://www.raspberrypi.org/blog/the-little-computer-that-could/" sktb/xservedby_prolog

*Note: Struggling to get this to work against the RPi server*
