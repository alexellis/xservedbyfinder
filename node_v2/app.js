# Also times each request
# Stops after given amount of requests

var request = require('request');
var async = require('async');

var found = [];
var times = {};

var maxCalls=process.argv[2] && Number(process.argv[2]) || 10;
var totalCalls = 0;

function tally() {
  console.log("\nTallying data");
  var sortedFound = found.sort();
  var totalRequests =0;
  sortedFound.forEach(function(foundServer) {
    var entry = times[foundServer];
    entry.average = (entry.runningTotal / entry.responses).toFixed(2);
    totalRequests += entry.responses;
  });
  sortedFound.forEach(function(server) {
    console.log("[" + server + "]\t" + times[server].average + " ms (avg)");
  });

  console.log("Total requests: " + totalRequests);

  process.exit();
}

async.until(function() {
  return totalCalls >= maxCalls;
}, function(cb) {
  var ticksStart = new Date().getTime();
  
request.head("https://www.raspberrypi.org/blog/the-little-computer-that-could/",
    function(err, res, body) {
      var ticksEnd = new Date().getTime();

      var servedBy = res.headers['x-served-by'];
      if(found.indexOf(servedBy)==-1){
        found.push(servedBy);
        times[servedBy] = {runningTotal: 0, responses: 0}
      }

      var total = ticksEnd - ticksStart;
      times[servedBy]["responses"] = times[servedBy]["responses"] +1;
      times[servedBy]["runningTotal"] =times[servedBy]["runningTotal"] + total;
      process.stdout.write(".")
      totalCalls = totalCalls +1;

      cb();
    });
}, function() {
  tally();
});

process.on('SIGINT', function() {
  tally();
})

