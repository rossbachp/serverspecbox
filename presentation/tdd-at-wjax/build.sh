#!/bin/bash
tar -czf tomcat-reference.tar.gz --exclude .DS_Store --exclude .gitignore tomcat-reference
docker build -t="rossbachp/tdd-at-wjax" .
DATE=`date +'%Y%m%d%H%M'`
ID=$(docker inspect -f "{{.Id}}" rossbachp/tdd-at-wjax)
docker tag $ID rossbachp/tdd-at-wjax:$DATE
#docker push rossbachp/tdd-at-wjax
