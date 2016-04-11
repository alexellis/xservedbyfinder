# x-served-by finder

*This repository accompanies a blog post*

> [Node.js vs. Bash – Apr First Raspberry PI Challenge](http://blog.alexellis.io/april-1st-node-js-vs-bash/)

The task: Reveal all the web-server nodes hidden behind a load-balancer by checking for the `X-Served-By` header.

### Open invitation

You will find a few solutions in Node.js, Bash and Go. This is an open invitation for your contribution. Solve the problem the way that feels most natural to you, in whatever programming language you like then:

* Fork the repository
* Push up your changes into a new folder with a brief README.md file
* Ideally push a Dockerfile so that we can test the changes easily and include them in a CI build.
* Raise a pull request (PR) and I will merge it.

This is a chance to contribute to an open-source project without having to over-commit your time or worry about pushing a flashy feature to an established code-base.

### Examples so far:

* [/node_v1](node_v1)
* [/node_v2](node_v2)
* [/bash_v1](bash_v1)
* [/bash_v2](bash_v2)
* [/go_v1](go_v1)
* [/go_v2](go_v2)

### Tips for contributing

#### Using a fake server, instead of RaspberryPI.org

> Update: You may find that running the code results in two VMs being returned instead of the full set. I've also included a fake endpoint in the Github repo. You can test against this without going to the public Internet. Run in fakeendpoint with Node.js then point to http://localhost:3000/


* Install Node.js if you do not already have it.
* Run the test server, called: fakeendpoint

```
cd fakeendpoint
npm Install

node app.js
```

* Then update your URL to the IP address of your machine or http://localhost:3000

You will now have a close simulation of the RaspberryPI.org website on the day as mentioned in the blog post.

> [Node.js vs. Bash – Apr First Raspberry PI Challenge](http://blog.alexellis.io/april-1st-node-js-vs-bash/)

#### Dockerfile

If you can add a Dockerfile that will help me make sure anyone else who wants to run your code will have everything they need.

For an example check out the go_v1 solution's Dockerfile.
