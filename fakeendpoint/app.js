var http = require('http');

var nodes = [
 "a",
 "e",
 "6",
 "12",
 "1a",
 "2",
 "16",
 "1e"
];

var server = http.createServer(function(req, res) {
   var nodeNumber = Math.floor((Math.random() * nodes.length-1) + 0);
   var node = nodes[nodeNumber];
   res.setHeader("X-Served-By", "Raspberry Pi " + node);
   res.write("<html>Here is the blog.</html>\n");
   res.end()
});

server.listen(3000);

console.log("Listening on port 3000");
