# DOCKER-VERSION 1.10

FROM clojure:alpine

# Install the jar file
RUN mkdir -p /usr/src/xservedbyfinder
COPY target/xservedbyfinder.jar /usr/src/xservedbyfinder/
CMD ["java", "-jar", "/usr/src/xservedbyfinder/xservedbyfinder.jar"]
