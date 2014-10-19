# Serverspec/specinfra nsenter backend port 2


## Information available
  * [infrabricks Blog Artikel]( http://www.infrabricks.de/blog/2014/09/10/docker-container-mit-serverspec-testen/)
  * [specinfra_nsenter_prototype]( https://gist.githubusercontent.com/aschmidt75/bb38d971e4f47172e2de/raw/350f9419159ffba282496f90232110e06b77cf69/specinfra_nsenter_prototype)

## work with on a serverspec/specinfra patch

``` bash
$ git add .
$ git commit -m "your change"
$ touch wercker.yml
$ bundle exec rake build
$ sudo gem install --local pkg/$( ls -tr1 pkg | tail -1)
```

## Check nsenter pull request
```bash
$ vagrant ssh
$ cd /vagrant/docker.d/httpd
$ docker build -t=rossbachp/httpd .
$ export CID=`docker run -tdi rossbachp/httpd`
9367d023570d4670ca1d12aa431bb826a131a1dcc0b02797a90372489d7927a6
$ export NSENTER_PID=`docker inspect -f '{{ .State.Pid }}' $CID`
$ cd /vargant/spec.d/nsenter
$ rake
/usr/bin/ruby1.9.1 -I/var/lib/gems/1.9.1/gems/rspec-support-3.1.2/lib:/var/lib/gems/1.9.1/gems/rspec-core-3.1.7/lib /var/lib/gems/1.9.1/gems/rspec-core-3.1.7/exe/rspec --pattern spec/localhost/\*_spec.rb
3930

Package "apache2"
nsenter_exec! sudo /bin/sh -c dpkg-query\ -f\ \'\$\{Status\}\'\ -W\ apache2\ \|\ grep\ -E\ \'\^\(install\|hold\)\ ok\ installed\$\'
  should be installed

Finished in 0.14203 seconds (files took 0.68118 seconds to load)
1 example, 0 failures

```
## more examples

look at directory `spec.d/tomcat`

## todo

  * Implement this with ruby docker API
```
if NSENTER_PID empty
# check docker_enter
NSENTER_PID=`docker inspect -f '{{ .State.Pid }}' #{DOCKER_CID}`
```
  * more working examples
  * add testcase
  * add an implementation that use docker 1.3 `docker exec`
  * check with docker container
  * look add package check `openjdk-8-jre-headless:amd64` failure

Regards
Peter
