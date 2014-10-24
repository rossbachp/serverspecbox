#!/bin/bash
tar -czf tomcat-reference.tar.gz --exclude .DS_Store --exclude .gitignore tomcat-reference
docker build -t="rossbachp/tdd-with-docker-slides" .
DATE=`date +'%Y%m%d%H%M'`
ID=$(docker inspect -f "{{.Id}}" rossbachp/tdd-with-docker-slides)
docker tag $ID rossbachp/tdd-with-docker-slides:$DATE
#docker push rossbachp/tdd-with-docker-slides
