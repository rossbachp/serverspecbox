FROM debian:7.6

MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

ENV DEBIAN_FRONTEND noninteractive
ENV APT_JAVA_VERSION 8u40~b09-1
ENV APT_WGET_VERSION 1.15-1+b1
ENV APT_PROCPS_VERSION 2:3.3.9-8
ENV APT_UNZIP_VERSION 6.0-12
ENV APT_CURL_VERSION 7.38.0-2

RUN \
  echo "deb http://ftp.us.debian.org/debian sid main" >> /etc/apt/sources.list && \
  apt-get update -yq && \
  apt-get install -yqq openjdk-8-jre-headless=${APT_JAVA_VERSION} \
    wget=${APT_WGET_VERSION} \
    curl=${APT_CURL_VERSION} \
    unzip=${APT_UNZIP_VERSION} \
    procps=${APT_PROCPS_VERSION} && \
  rm -rf /var/lib/apt/lists/*

ENV TOMCAT_MAJOR_VERSION 8
ENV TOMCAT_MINOR_VERSION 8.0.14
ENV CATALINA_HOME /opt/tomcat

ENV PATH $PATH:$CATALINA_HOME/bin

# INSTALL TOMCAT
RUN wget -q https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz && \
  wget -qO- https://www.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz.md5 | md5sum -c - && \
  tar zxf apache-tomcat-*.tar.gz && \
  rm apache-tomcat-*.tar.gz && \
  mv apache-tomcat* ${CATALINA_HOME}

# Remove unneeded apps and files
RUN \
  rm -rf ${CATALINA_HOME}/webapps/examples \
  ${CATALINA_HOME}/webapps/docs \
  ${CATALINA_HOME}/webapps/ROOT \
  ${CATALINA_HOME}/webapps/host-manager \
  ${CATALINA_HOME}/RELEASE-NOTES \
  ${CATALINA_HOME}/RUNNING.txt \
  ${CATALINA_HOME}/bin/*.bat \
  ${CATALINA_HOME}/bin/*.tar.gz

RUN groupadd -r tomcat -g 4242 && \
  useradd -u 4242 -r -g tomcat -d ${CATALINA_HOME} -s /bin/bash -c "Docker image user" tomcat && \
  chown -R tomcat:tomcat ${CATALINA_HOME}

RUN apt-get clean autoclean && \
    apt-get autoremove -y && \
    rm -rf /var/lib/{apt,dpkg,cache,log}/

WORKDIR /opt/tomcat

EXPOSE 8080
EXPOSE 8009

VOLUME /opt/tomcat/webapps

USER tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
