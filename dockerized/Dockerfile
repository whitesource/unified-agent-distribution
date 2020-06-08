FROM ubuntu:18.04

# Image containing:
# base Ubuntu:18.04
# 1.  utility apps
# 2.  Java (1.8)
# 3.  Maven (3.5.4)
# 4.  Node.js (8.9.4)
# 5.  NPM (5.6.0)
# 6.  Yarn (1.5.1)
# 7.  Bower (1.8.2)
# 8.  Gradle (6.0.1)
# 9.  python 2.7 + 3.6 + pip + pip3 + pipenv
# 10. [optional] python 3.7
# 11. [optional] python 3.8
# 12. Poetry (python)
# 13. Ruby, rbenv and ruby-build
# 14. Go (1.12.6)
# 15. Scala 2.12.6, Sbt 1.1.6
# 16. PHP (7.2)
# 17. Composer
# 18. PHP Plugins
# 19. Mix, Hex, Erlang and Elixir
# 20. Cocoapods (1.5.3)
# 21. R + Packrat
# 22. Haskel + Cabal
# 23. Paket
# 24. dotnet-sdk-2.2,dotnet cli and NuGet
# 25. Cargo

ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME       /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH 	    	$JAVA_HOME/bin:$PATH
ENV LANGUAGE	en_US.UTF-8
ENV LANG    	en_US.UTF-8
ENV LC_ALL  	en_US.UTF-8

### Install wget, curl, git, unzip, gnupg, locales, rpm
RUN apt-get update && \
	apt-get -y install wget curl git unzip gnupg locales rpm && \
	locale-gen en_US.UTF-8 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/*

### add a new group + user without root premmsions
ENV WSS_GROUP wss-group
ENV WSS_USER wss-scanner
ENV WSS_USER_HOME=/home/${WSS_USER}

RUN groupadd ${WSS_GROUP} && \
	useradd --gid ${WSS_GROUP} --groups 0 --shell /bin/bash --home-dir ${WSS_USER_HOME} --create-home ${WSS_USER} && \
	passwd -d ${WSS_USER}


### Install Java openjdk 8
RUN echo "deb http://ppa.launchpad.net/openjdk-r/ppa/ubuntu bionic main" | tee /etc/apt/sources.list.d/ppa_openjdk-r.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys DA1A4A13543B466853BAF164EB9B1D8886F44E2A && \
    apt-get update && \
    apt-get -y install openjdk-8-jdk && \
    apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/*


### Install Maven (3.5.4)
ARG MAVEN_VERSION=3.5.4
ARG SHA=CE50B1C91364CB77EFE3776F756A6D92B76D9038B0A0782F7D53ACF1E997A14D
ARG BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries

RUN mkdir -p /usr/share/maven /usr/share/maven/ref && \
	curl -fsSL -o /tmp/apache-maven.tar.gz ${BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
	echo "${SHA}  /tmp/apache-maven.tar.gz" | sha256sum -c - && \
	tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 && \
	rm -f /tmp/apache-maven.tar.gz && \
	ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
	mkdir -p -m 777 ${WSS_USER_HOME}/.m2/repository && \
	chown -R ${WSS_USER}:${WSS_GROUP} ${WSS_USER_HOME}/.m2 && \
	rm -rf /tmp/*

ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG ${WSS_USER_HOME}/.m2


### Install Node.js (8.9.4) + NPM (5.6.0)
RUN apt-get update && \
	curl -sL https://deb.nodesource.com/setup_8.x | bash && \
    apt-get install -y nodejs build-essential && \
    apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/*

### Install Yarn
RUN npm i -g yarn@1.5.1

#### Install Bower + provide premmsions
#RUN npm i -g bower --allow-root && \
#	echo '{ "allow_root": true }' > ${WSS_USER_HOME}/.bowerrc && \
#	chown -R ${WSS_USER}:${WSS_GROUP} ${WSS_USER_HOME}/.bowerrc


### Install Gradle
RUN wget -q https://services.gradle.org/distributions/gradle-6.0.1-bin.zip && \
    unzip gradle-6.0.1-bin.zip -d /opt && \
    rm gradle-6.0.1-bin.zip
### Set Gradle in the environment variables
ENV GRADLE_HOME /opt/gradle-6.0.1
ENV PATH $PATH:/opt/gradle-6.0.1/bin


### Install all the python2.7 + python3.6 packages
RUN apt-get update && \
	apt-get install -y python3-pip python3.6-venv && \
    apt-get install -y python-pip && \
    pip3 install pipenv && \
    apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/*

# python utilities
RUN python -m pip install --upgrade pip && \
    python3 -m pip install --upgrade pip && \
    python -m pip install virtualenv && \
    python3 -m pip install virtualenv

#### optional: python3.7 (used with UA flag: 'python.path')
#RUN apt-get update && \
#    apt-get install -y python3.7 python3.7-venv && \
#    python3.7 -m pip install --upgrade pip && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/* && \
#    rm -rf /tmp/*
#### optional: python3.8 (used with UA flag: 'python.path')
#RUN apt-get update && \
#    apt-get install -y python3.8 python3.8-venv && \
#    python3.8 -m pip install --upgrade pip && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/* && \
#    rm -rf /tmp/*

#### Install Poetry (python)
#### requires python3.X version matching the projects (defaults to python3.6)
#RUN curl -sSLO https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py && \
#    python3 get-poetry.py --yes --version 1.0.5 && \
#    rm -rf get-poetry.py

#### Install Ruby
#RUN apt-get update && \
#	apt-get install -y ruby ruby-dev ruby-bundler && \
#    apt-get clean && \
#	rm -rf /var/lib/apt/lists/* && \
#	rm -rf /tmp/*


#### Install rbenv and ruby-build
### or maybe be saved to /etc/profile instead of /etc/profile.d/
#RUN git clone https://github.com/sstephenson/rbenv.git ${WSS_USER_HOME}/.rbenv; \
#	git clone https://github.com/sstephenson/ruby-build.git ${WSS_USER_HOME}/.rbenv/plugins/ruby-build; \
#	${WSS_USER_HOME}/.rbenv/plugins/ruby-build/install.sh && \
#	echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh && \
#	echo 'eval "$(rbenv init -)"' >> ${WSS_USER_HOME}/.bashrc && \
#	chown -R ${WSS_USER}:${WSS_GROUP} ${WSS_USER_HOME}/.rbenv ${WSS_USER_HOME}/.bashrc
#ENV PATH ${WSS_USER_HOME}/.rbenv/bin:$PATH


#### Install GO:
#USER ${WSS_USER}
#RUN mkdir -p ${WSS_USER_HOME}/goroot && \
#    curl https://storage.googleapis.com/golang/go1.12.6.linux-amd64.tar.gz | tar xvzf - -C ${WSS_USER_HOME}/goroot --strip-components=1
### Set GO environment variables
#ENV GOROOT ${WSS_USER_HOME}/goroot
#ENV GOPATH ${WSS_USER_HOME}/gopath
#ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH
### Install package managers
#RUN go get -u github.com/golang/dep/cmd/dep
#RUN go get github.com/tools/godep
#RUN go get github.com/LK4D4/vndr
#RUN go get -u github.com/kardianos/govendor
#RUN go get -u github.com/gpmgo/gopm
#RUN go get github.com/Masterminds/glide
#USER root


#### Important note ###
#### uncomment for:
####    Scala
####    SBT
####    Mix/ Hex/ Erlang/ Elixir
####    dotnet/nuget cli's
#RUN apt-get update && \
#	apt-get install -y --force-yes build-essential && \
#	apt-get install -y --force-yes zlib1g-dev libssl-dev libreadline-dev libyaml-dev libxml2-dev libxslt-dev && \
#	apt-get clean && \
#	rm -rf /var/lib/apt/lists/* && \
#	rm -rf /tmp/*


#### Install Scala
#RUN wget https://downloads.lightbend.com/scala/2.12.6/scala-2.12.6.deb --no-check-certificate && \
#	dpkg -i scala-2.12.6.deb && \
#	rm scala-2.12.6.deb
### Install SBT
#RUN curl -L -o sbt.deb http://dl.bintray.com/sbt/debian/sbt-1.1.6.deb && \
#	dpkg -i sbt.deb && \
#	rm sbt.deb
#RUN apt-get update && \
#	apt-get install -y sbt && \
#	apt-get clean && \
#	rm -rf /var/lib/apt/lists/* && \
#	rm -rf /tmp/*


#### Install PHP
#RUN apt-get update && \
#	apt-get install -y php7.2 && \
#	apt-get clean && \
#	rm -rf /var/lib/apt/lists/* && \
#	rm -rf /tmp/*
### Install Composer
#RUN curl -s https://getcomposer.org/installer | php
#RUN mv composer.phar /usr/local/bin/composer
### Install PHP Plugins
#RUN apt-get update && \
#	apt-get install -y php7.2-mbstring && \
#	apt-get install -y php7.2-dom && \
#	apt-get clean && \
#	rm -rf /var/lib/apt/lists/* && \
#	rm -rf /tmp/*


#### Install Mix/ Hex/ Erlang/ Elixir
#RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb && \
#	dpkg -i erlang-solutions_1.0_all.deb && \
#	apt-get update && \
#	apt-get install esl-erlang -y && \
#	apt-get install elixir -y && \
#	mix local.hex --force && \
#	rm erlang-solutions_1.0_all.deb && \
#	apt-get clean && \
#	rm -rf /var/lib/apt/lists/* && \
#	rm -rf /tmp/*


#### Install Cocoapods
#RUN gem install cocoapods
#RUN adduser cocoapods
#USER cocoapods
#RUN pod setup
#USER root


#### Install R and Packrat
#RUN apt-get update && \
#	apt-get install -y r-base libopenblas-base r-base gdebi && \
#	wget https://download1.rstudio.org/rstudio-xenial-1.1.419-amd64.deb && \
#	gdebi rstudio-xenial-1.1.419-amd64.deb && \
#	rm rstudio-xenial-1.1.419-amd64.deb && \
#	R -e 'install.packages("packrat" , repos="http://cran.us.r-project.org");'  && \
#	apt-get clean && \
#	rm -rf /var/lib/apt/lists/* && \
#	rm -rf /tmp/*


#### Install Cabal
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 063DAB2BDC0B3F9FCEBC378BFF3AEACEF6F88286 && \
#	echo "deb http://ppa.launchpad.net/hvr/ghc/ubuntu bionic main " | tee /etc/apt/sources.list.d/ppa_hvr_ghc.list && \
#	apt-get update && \
#	apt-get install -y ghc-8.6.5 cabal-install-3.2 && \
#	PATH="/opt/ghc/bin:${PATH}" && \
#	cabal update && \
#	apt-get clean && \
#	rm -rf /var/lib/apt/lists/* && \
#	rm -rf /tmp/*
#ENV PATH /opt/ghc/bin:$PATH


#### Install Paket
#RUN apt-get update && \
#	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
#	apt-get install -y --no-install-recommends apt-transport-https ca-certificates && \
#	echo "deb https://download.mono-project.com/repo/ubuntu bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
#	apt-get update && \
#	apt-get install -y mono-devel && \
#	apt-get clean && \
#	rm -rf /var/lib/apt/lists/* && \
#	rm -rf /tmp/*


#RUN mozroots --import --sync && \
#	git clone https://github.com/fsprojects/Paket.git && \
#	cd Paket && \
#	./build.sh && \
#	./install.sh


#### Install dotnet cli and Nuget
#RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
#	dpkg -i packages-microsoft-prod.deb && \
#	apt-get update && \
#	apt-get install -y apt-transport-https && \
#	apt-get install -y dotnet-sdk-2.2 && \
#	apt-get install -y dotnet-sdk-3.1 && \
#	apt-get install -y nuget && \
#	rm packages-microsoft-prod.deb && \
#	apt-get clean && \
#	rm -rf /var/lib/apt/lists/* && \
#	rm -rf /tmp/*


#### Install Cargo
#ENV HOME ${WSS_USER_HOME}
#RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
#	chown -R ${WSS_USER}:${WSS_GROUP} ${WSS_USER_HOME}/.cargo && \
#	chown -R ${WSS_USER}:${WSS_GROUP} ${WSS_USER_HOME}/.rustup && \
#	rm -rf /tmp/*
#ENV PATH $HOME/.cargo/bin:$PATH
#ENV HOME /root



### Switch User ###
ENV HOME ${WSS_USER_HOME}
WORKDIR ${WSS_USER_HOME}
USER ${WSS_USER}
