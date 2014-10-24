# Trible-D: testdriven docker development


## slides and examples

The slides based on `rossbachp/presentation` image

```bash
./run.sh
http://localhost:8000
```

## build a distribution

```bash
tar -czf tomcat-reference.tar.gz --exclude .DS_Store --exclude .gitignore tomcat-reference
docker build -t="rossbachp/tdd-with-docker-slides" .
DATE=`date +'%Y%m%d%H%M'`
ID=$(docker inspect -f "{{.Id}}" rossbachp/tdd-with-docker-slides)
docker tag $ID rossbachp/tdd-with-docker-slides:$DATE
docker push rossbachp/tdd-with-docker-slides
```

## run this

```bash
docker pull rossbachp/tdd-with-docker-slides
docker run -d -ti -p 8000:8000 rossbachp/tdd-with-docker-slides
```
Open your browser with `http://localhost:8000` start your TDD development with docker. You must have installed ruby 2.1.2 and bundler at your docker host!

## Example reference

look at folder `tomcat-reference`

## ToDo
  * Build a runtime container with lighttpd setup!
  * Only serve static result!
  * setup only a data volume scratch container

```
tar cv --files-from /dev/null | docker import - scratch

cat >>!
FROM scratch
COPY true-asm /true
CMD ["/true"]
!>Dockerfile

## Links

  * It use a [Docker](https://www.docker.com/)'s
  * [look at my personal apache tomcat build](https://registry.hub.docker.com/u/rossbachp/apache-tomcat8/) published to the public [Docker Registry](https://registry.hub.docker.com/).

## Good Luck
Have fun with this tomcat images and give feedback!

Peter
