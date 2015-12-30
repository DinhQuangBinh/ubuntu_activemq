#
# Ubuntu Dockerfile
#
# https://github.com/dockerfile/ubuntu
#

# Pull base image.
FROM ubuntu:14.04

# Install.
RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y byobu curl git htop man unzip vim wget && \
  rm -rf /var/lib/apt/lists/*

# Add files.
ADD root/.bashrc /root/.bashrc
ADD root/.gitconfig /root/.gitconfig
ADD root/.scripts /root/.scripts

# Set environment variables.
ENV HOME /root

# Define working directory.
WORKDIR /root

# Install ActiveMQ
RUN apt-get update
RUN apt-get install -y default-jre-headless activemq
RUN ln -s /etc/activemq/instances-available/main /etc/activemq/instances-enabled/main

# Expose port 27017 from the container to the host
EXPOSE 61613

# Set usr/bin/mongod as the dockerized entry-point application
#CMD ["/usr/bin/sudo", "-u", "activemq", "/usr/bin/activemq"]
