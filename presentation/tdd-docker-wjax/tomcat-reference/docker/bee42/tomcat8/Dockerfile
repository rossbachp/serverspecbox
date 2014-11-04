FROM ubuntu:14.04
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>


RUN apt-get update && \
    apt-get install -yq openjdk-7-jre-headless

ENV TOMCAT_MAJOR_VERSION 8
ENV TOMCAT_MINOR_VERSION 8.0.14
ENV CATALINA_HOME /opt/tomcat

RUN apt-get install -yq wget

RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
    wget -qO- https://www.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
    tar zxf apache-tomcat-*.tar.gz && \
    rm apache-tomcat-*.tar.gz && \
    mv apache-tomcat* ${CATALINA_HOME}

RUN adduser --disabled-password --quiet tomcat && \
    echo 'tomcat:tomcat' | chpasswd
USER tomcat

WORKDIR /opt/tomcat

EXPOSE 8080
EXPOSE 8009

CMD ["/opt/tomcat/bin/catalina.sh run"]
