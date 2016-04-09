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
 var delay = Math.floor((Math.random() * 35) + 30)
 process.stdout.write(".");
 setTimeout(function() {
   var nodeNumber = Math.floor((Math.random() * nodes.length) + 1);
   var node = nodes[nodeNumber-1];

   res.setHeader('Content-Type', 'text/html');
   res.setHeader("X-Served-By", "Raspberry Pi " + node);
   res.writeHead(200);
   res.end("<html>Here is the blog.</html>\n");
  }, delay);
});

server.listen(3000);

console.log("Listening on port 3000");
