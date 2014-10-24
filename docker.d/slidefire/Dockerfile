FROM progrium/busybox
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

RUN opkg-install base-files bash lighttpd
ADD index.html /www/index.html
ONBUILD ADD slidefire.tar.gz /www
EXPOSE 80

CMD ["lighttpd", "-D","-f", "/etc/lighttpd/lighttpd.conf"]
