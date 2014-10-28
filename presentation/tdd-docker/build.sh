#!/bin/bash
tar -czf tomcat-reference.tar.gz --exclude .DS_Store --exclude .gitignore tomcat-reference
docker build -t="rossbachp/tdd-docker" .
DATE=`date +'%Y%m%d%H%M'`
ID=$(docker inspect -f "{{.Id}}" rossbachp/tdd-docker)
docker tag $ID rossbachp/tdd-docker:$DATE
#docker push rossbachp/tdd-docker
