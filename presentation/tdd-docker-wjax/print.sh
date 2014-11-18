#!/bin/bash
TAG=wjax2014
CID=$1
LOCATION="WJAX Munich and ConLi Mannheim"
TITLE="Docker TDD"
DATE=`date +'%Y'`
COPYRIGHT="${DATE} &lt;peter.rossbach@bee42.com&gt;, @PRossbach und &lt;andreas.schmidt@cassini.de&gt;, @aschmidt75 - ${LOCATION}"
docker exec -ti ${CID} /bin/bash -c "cd print ; COPYRIGHT=\"$COPYRIGHT\" ./print.sh /build/docker-tdd-${TAG}-PeterRossbach.pdf"
docker exec -ti ${CID} /bin/bash -c "cd print ; ./exif.sh /build/docker-tdd-${TAG}-PeterRossbach.pdf '${TITLE}'"
