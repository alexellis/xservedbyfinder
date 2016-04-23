# xservedbyfinder

_a solution in Clojure_

This solution lazily computes the distinct servers randomly selected and returned in *X-Served-By* headers. It demonstrates two interesting clojure idioms: lazy sequences and tail recursion. The function ``sample-attempts`` encapsulates the logic that determines how many attempts you make at finding a new value before you decide you have enough confidence to stop hunting for another.

## Usage

To run this, download and install [leiningen](http://leiningen.org). Then go to the folder containing this README and type

    lein run
    
The url defaults to http://localhost:3000, but you can provide an alternate URL by defining the environment variable TARGET_URL.

For Docker, create an uberjar with

    lein uberjar
    

Create the image.

    docker build -t xservedbyfinder .
    
Then run it.

You can provide an alternate url with the ``-e`` option. For example, 

    docker run xservedbyfinder -e TARGET_URL=https://www.raspberrypi.org/blog/the-little-computer-that-could/

