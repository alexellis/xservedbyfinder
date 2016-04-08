var request = require('request');
var async = require('async');

var found = [];

async.until(function() {
  return false;
}, function(cb) {
  request.head("https://www.raspberrypi.org/blog/the-little-computer-that-could/",
    function(err,res,body) {
      var servedBy = res.headers['x-served-by'];
      if(found.indexOf(servedBy)==-1){
        console.log("" + servedBy);
        found.push(servedBy);
      }
      process.stdout.write(".");
      cb();
    });
});
