#!/bin/bash
DATE=`date +'%Y%m%d%H%M'`
DECK=docker-tdd
EDITION_TAG=wjax2014
EDITION_TAG2=conli2014
if [ ! "x" == "x`docker ps -a | grep $DECK`" ]; then
  docker stop $DECK
  docker rm $DECK
fi

mkdir -p build
PWD=`pwd`
mkdir -p build/md
cp slides.md build/md
docker run -ti --rm -v $PWD/images:/opt/presentation/images -v  $PWD/build/md:/opt/presentation/lib/md -v $PWD/build:/build -p 8000:8000 rossbachp/presentation /bin/bash -c "grunt package && mv reveal-js-presentation.zip /build/$DECK.zip"
tar -czf build/tomcat-reference.tar.gz --exclude .DS_Store --exclude .gitignore tomcat-reference
cd build
mkdir -p $DECK
cp tomcat-reference.tar.gz $DECK
cd $DECK
#you must have zip installed - apt-get install -y zip
unzip ../$DECK.zip
cd ..
tar czf slidefire.tar.gz $DECK
rm -rf build/$DECK.zip
rm -rf build/$DECK
rm -rf build/md

COPYDATE=`date +'%Y'`
cp ../LICENSE LICENSE
cat <<EOT >Dockerfile
FROM rossbachp/slidefire
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>
ADD LICENSE /etc/LICENSE
RUN echo "slidefire" >/etc/provisioned && date >>/etc/provisioned && echo >>/etc/provisioned && echo " Copyright ${COPYDATE} by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned
EOT

docker build -t=rossbachp/$DECK .
docker tag --force=true rossbachp/$DECK rossbachp/$DECK:$EDITION_TAG
docker tag --force=true rossbachp/$DECK rossbachp/$DECK:$EDITION_TAG2
docker tag --force=true rossbachp/$DECK rossbachp/$DECK:$DATE
