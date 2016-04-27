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

The count of iterations will default to 25. To change this, set the ITERATIONS environment variable on the docker command line.

    docker run -e "TARGET_URL=https://www.raspberrypi.org/blog/the-little-computer-that-could/" -e "ITERATIONS=50" sktb/xservedby_prolog

*Note: Works fine against the test server but there's some kind of incompatibility between the SWI-Prolog http_open library and the RaspberryPi.Org server. SWI-Prolog throws an exception reading the http headers which I have yet to identify. Testing via an http proxy works fine, so it's possibly a character set or encoding issue.*
