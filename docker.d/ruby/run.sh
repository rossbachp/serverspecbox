#!/bin/bash
docker run -d -ti --privileged --volume `pwd`/specs:/home/saphir/specs --volume `pwd`/gems:/home/saphir/gems --volume `pwd`/docker.d:/home/saphir/docker.d -p 4444:4444 -p 2222:22 bee42/ruby-dev
