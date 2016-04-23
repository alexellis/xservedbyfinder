Java

* Simple java implementation (single threaded)
* Docker noob here - I will try to come up with a Dockerfile later.
* The program hits this URL by default: https://www.raspberrypi.org/blog/the-little-computer-that-could/
* If you want to try a different URL, you can set it in an env variable called "targetUrl"
* To run this program:
	- javac App.java
	- java App
	- If you are behind a proxy: java -Dhttps.proxyHost=<PROXY_HOST> -Dhttps.proxyPort=<PROXY_PORT> App

