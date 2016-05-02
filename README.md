# x-served-by finder

*This repository accompanies a blog post, please read it before continuing.*

> [Node.js vs. Bash – Apr First Raspberry PI Challenge](http://blog.alexellis.io/april-1st-node-js-vs-bash/)

The challenge: Reveal all the web-server nodes hidden behind a load-balancer by checking for the `X-Served-By` header.

### Open invitation

You will find a few solutions in Node.js, Bash and Go. This is an open invitation for your contribution. Solve the problem the way that feels most natural to you, in whatever programming language you like then:

* Fork the repository
* Push up your changes into a new folder with a brief README.md file
* Ideally push a Dockerfile so that we can test the changes easily and include them in an automated build.
* Raise a pull request (PR) and I will merge it.
* Update the *Examples so far* section of the main README.md file.
* Update the CONTRIBUTORS.md file with your Github username and fork.

This is a chance to contribute to an open-source project without having to over-commit your time or worry about pushing a flashy feature to an established code-base.

### Examples so far:

* [/node_v1](node_v1)
* [/node_v2](node_v2)
* [/bash_v1](bash_v1)
* [/bash_v2](bash_v2)
* [/go_v1](go_v1)
* [/go_v2](go_v2)
* [/java_v1](java_v1)
* [/java_v2](java_v2)
* [/clojure_v1](clojure_v1)
* [/make_v1](make_v1)
* [/ruby_v1](ruby_v1)
* [/prolog_v1](prolog_v1)

### Tips for contributing

#### Using a fake server, instead of RaspberryPI.org

> Update: You may find that running the code results in two VMs being returned instead of the full set. I've also included a fake endpoint in the Github repo. You can test against this without going to the public Internet. Run in fakeendpoint with Node.js then point to http://localhost:3000/

If you are using Docker then you can make use of a pre-built image:

```
$ docker pull alexellis2/xservedbyfinder-endpoint
$ docker run -d -p 3000:3000 alexellis2/xservedbyfinder-endpoint
```

Without Docker:

* Install Node.js (4.x) if you do not already have it.
* Run the test server:

```
$ cd fakeendpoint/
$ node app.js
Listening on port 3000
```

* Then update your URL to the IP address of your machine or http://localhost:3000
* If you are using Docker then an environmental variable may be useful for passing different URLs.

You will now have a close simulation of the RaspberryPI.org website on the day as mentioned in the blog post.

> [Node.js vs. Bash – Apr First Raspberry PI Challenge](http://blog.alexellis.io/april-1st-node-js-vs-bash/)

#### Extra points

* Passing or configuring the URL by environmental variable.

* Adding a Dockerfile

You can extra kudos for adding a `Dockerfile`. This means anyone who wants to run your example can do so with zero fuss. I'd also like to include them in a CI build at a later date.

Several Dockerfiles are already included, please look through the examples if you need an example.
