#!/bin/bash
echo "Building docker image:"
cd docker/bee42/tomcat8
docker build -t=bee42/tomcat8 .
echo
cd ../../..
echo "Executing tests:"
bundle exec rspec spec/tomcat_spec.rb

