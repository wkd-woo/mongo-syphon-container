# base OS image
FROM ubuntu:20.04

# Update package lists
RUN apt-get update && apt-get upgrade -y --fix-missing

# No need user interaction
ARG DEBIAN_FRONTEND=noninter`active

# Install required packages MongoSyphon
RUN apt-get install -y openjdk-8-jdk maven git curl jq

# git clone MongoSyphon & build
WORKDIR /engineer
RUN git clone https://github.com/johnlpage/MongoSyphon.git
RUN cd /engineer/MongoSyphon && mvn clean package

# Expose ports
EXPOSE 22 80 3306 8080 27017 30000

# Start a shell by default
CMD ["/bin/bash"]