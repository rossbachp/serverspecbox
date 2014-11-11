#!/bin/bash
tar -czf tomcat-reference.tar.gz --exclude .DS_Store --exclude .gitignore tomcat-reference
docker build -t="rossbachp/docker-tdd" .
DATE=`date +'%Y%m%d%H%M'`
ID=$(docker inspect -f "{{.Id}}" rossbachp/docker-tdd)
docker tag $ID rossbachp/docker-tdd:$DATE
#docker push rossbachp/docker-tdd
