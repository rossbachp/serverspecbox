#!/bin/bash
docker run -d -ti -p 8004:8000 -v `pwd`/images:/opt/presentation/images -v `pwd`:/opt/presentation/lib/md rossbachp/presentation
