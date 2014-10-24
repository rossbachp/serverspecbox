FROM ubuntu:14.04
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

ENV JAVAVERSION 7

# Install Java.
RUN \
  apt-get update && \
  apt-get install -y openjdk-${JAVAVERSION}-jre

RUN adduser --disabled-password --quiet javadev && \
  echo 'javadev:javadev' | chpasswd

USER javadev

WORKDIR /home/javadev

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-${JAVAVERSION}-openjdk-amd64

# Define default command.
CMD ["/bin/bash"]
