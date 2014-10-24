FROM jpetazzo/dind
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com>

# install supervisor

RUN apt-get -q update && \
  apt-get install -qy supervisor && \
  mkdir -p /var/log/supervisor

# install sshd

RUN apt-get install -y openssh-server && \
  mkdir /var/run/sshd && \
  echo 'root:screencast' |chpasswd && \
  sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config


# Install ruby

# install ruby depend packages
RUN apt-get upgrade -y openssl
RUN apt-get -qy install git-core curl zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev libffi-dev python-software-properties


# build ruby
RUN \
  wget http://ftp.ruby-lang.org/pub/ruby/2.1/ruby-2.1.3.tar.gz && \
  tar xzf ruby-2.1.3.tar.gz && \
  cd ruby-2.1.3 && \
  ./configure --with-readline-dir=/usr/lib/x86_64-linux-gnu/libreadline.so && \
  make && make install && \
  gem install bundler && \
  cd .. && \
  rm -rf ruby-2.1.3 ruby-2.1.3.tar.gz

# install nsenter
ADD docker-enter /usr/local/bin/docker-enter
RUN curl --silent https://www.kernel.org/pub/linux/utils/util-linux/v2.24/util-linux-2.24.tar.gz | tar -zxf- && \
  cd util-linux-2.24 && \
  ./configure --without-ncurses && \
  make nsenter && \
  sudo cp nsenter /usr/local/bin && \
  chmod -x /usr/local/bin/docker-enter

# fuser tool
RUN apt-get -qy install psmisc

# add developer user saphir
RUN adduser --disabled-password --quiet saphir && \
  echo 'saphir:saphir' | chpasswd && \
  usermod -a -G docker saphir && \
  usermod -a -G sudo saphir && \
  echo "export DOCKER_HOST=tcp://0.0.0.0:4444" >>/home/saphir/.bash_aliases && \
  echo "alias d=docker" >>/home/saphir/.bash_aliases && \
  echo "alias de='sudo docker-enter'" >>/home/saphir/.bash_aliases && \
  echo ":set term=ansi" >>/home/saphir/.vimrc && \
  chown saphir:saphir /home/saphir/.bash_aliases /home/saphir/.vimrc

# Configuration supervisord
ADD supervisord-base.conf /etc/supervisor/conf.d/supervisord-base.conf
EXPOSE 9001

# Configuration dind

ENV PORT 4444
ADD supervisord-docker.conf /etc/supervisor/conf.d/supervisord-docker.conf
EXPOSE 4444

ADD supervisord-sshd.conf /etc/supervisor/conf.d/supervisord-sshd.conf
EXPOSE 22

CMD [ "/usr/bin/supervisord" ]
