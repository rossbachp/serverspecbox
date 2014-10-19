FROM ubuntu:14.04
RUN apt-get -yqq update && apt-get install -yqq apache2
RUN mkdir -p /var/lock/apache2 /var/run/apache2 /var/log/apache2
EXPOSE 80
CMD ["/usr/sbin/apachectl", "-DFOREGROUND"]
