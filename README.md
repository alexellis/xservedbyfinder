# xservedbyfinder

*Accompanies blog post*

[Node.js vs. Bash – Apr First Raspberry PI Challenge](http://blog.alexellis.io/april-1st-node-js-vs-bash/)

Find all the web-servers behind a load-balancer through the `X-Served-By` header.

#### Examples

* node_v1
* node_v2
* bash_v1
* bash_v2

#### Contributing

Please fork and submit new code examples in your favorite programming language.

* Use fakeendpoint (run with node) to enable a local test server simulating the setup from April 1st on RaspberryPi.org.
* Create a folder with the code solution
 * Ideally add a Dockerfile for easy execution/setup
 * Add a README.md file to the new folder

#### Using a fake server, instead of RaspberryPI.org

> Update: You may find that running the code results in two VMs being returned instead of the full set. I've also included a fake endpoint in the Github repo. You can test against this without going to the public Internet. Run in fakeendpoint run app.js then point to http://localhost:3000/

* Install node.js if you do not already have it.
* Run the test server, called: fakeendpoint

```
cd fakeendpoint
npm Install

node app.js
```

* Then update your URL to the IP address of your machine or http://localhost:3000
