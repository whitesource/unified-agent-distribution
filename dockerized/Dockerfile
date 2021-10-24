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

### Install wget, curl, git, unzip, gnupg, locales
RUN apt-get update && \
	apt-get -y install \
      curl \
      git \
      gnupg \
      locales  \
      unzip \
      wget \
    && locale-gen en_US.UTF-8 && \
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
ARG MAVEN_VERSION_SHA=CE50B1C91364CB77EFE3776F756A6D92B76D9038B0A0782F7D53ACF1E997A14D
ARG MAVEN_BASE_URL=https://apache.osuosl.org/maven/maven-3/${MAVEN_VERSION}/binaries
ENV MAVEN_HOME /usr/share/maven
ENV MAVEN_CONFIG ${WSS_USER_HOME}/.m2

RUN mkdir -p /usr/share/maven /usr/share/maven/ref && \
	curl -fsSL -o /tmp/apache-maven.tar.gz ${MAVEN_BASE_URL}/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
	echo "${MAVEN_VERSION_SHA}  /tmp/apache-maven.tar.gz" | sha256sum -c - && \
	tar -xzf /tmp/apache-maven.tar.gz -C /usr/share/maven --strip-components=1 && \
	rm -f /tmp/apache-maven.tar.gz && \
	ln -s /usr/share/maven/bin/mvn /usr/bin/mvn && \
	mkdir -p -m 777 ${WSS_USER_HOME}/.m2/repository && \
	chown -R ${WSS_USER}:${WSS_GROUP} ${WSS_USER_HOME}/.m2 && \
	rm -rf /tmp/*


### Install Node.js (12.19.0) + NPM (6.14.8)
RUN apt-get update && \
	curl -sL https://deb.nodesource.com/setup_12.x | bash && \
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

ARG GRADLE_VERSION=6.0.1

### Install Gradle
RUN wget -q https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip && \
    unzip gradle-${GRADLE_VERSION}-bin.zip -d /opt && \
    rm gradle-${GRADLE_VERSION}-bin.zip

### Set Gradle in the environment variables
ENV GRADLE_HOME /opt/gradle-${GRADLE_VERSION}
ENV PATH $PATH:/opt/gradle-${GRADLE_VERSION}/bin


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


### Install Conda (python)
#USER ${WSS_USER}
#RUN cd ${WSS_USER_HOME} && \
#    wget https://repo.anaconda.com/archive/Anaconda3-2021.05-Linux-x86_64.sh && \
#    bash Anaconda3-2021.05-Linux-x86_64.sh -b && \
#    rm Anaconda3-2021.05-Linux-x86_64.sh
#
#USER root
#RUN echo '#!/usr/bin/env bash' >> /usr/bin/conda && \
#    echo 'source ${WSS_USER_HOME}/anaconda3/etc/profile.d/conda.sh' >> /usr/bin/conda && \
#    echo '${WSS_USER_HOME}/anaconda3/bin/conda "$@"' >> /usr/bin/conda && \
#    chmod +x /usr/bin/conda


#### Install Poetry (python)
#### requires python3.X version matching the projects (defaults to python3.6)
#### sed command sets the default selected python-executable used by poetry to be 'python3'
#ENV POETRY_HOME ${WSS_USER_HOME}/.poetry
#RUN curl -sSLO https://raw.githubusercontent.com/python-poetry/poetry/master/get-poetry.py && \
#	sed -i 's/allowed_executa11bles = \["python", "python3"\]/allowed_executables = \["python3", "python"\]/g' get-poetry.py && \
#	python3 get-poetry.py --yes --version 1.0.5 && \
#	chown -R ${WSS_USER}:${WSS_GROUP} ${WSS_USER_HOME}/.poetry && \
#	rm -rf get-poetry.py
#ENV PATH ${WSS_USER_HOME}/.poetry/bin:${PATH}


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
# ARG GOLANG_VERSION=1.17.1
#USER ${WSS_USER}
#RUN mkdir -p ${WSS_USER_HOME}/goroot && \
#   curl https://storage.googleapis.com/golang/go${GOLANG_VERSION}.linux-amd64.tar.gz | tar xvzf - -C ${WSS_USER_HOME}/goroot --strip-components=1
### Set GO environment variables
#ENV GOROOT ${WSS_USER_HOME}/goroot
#ENV GOPATH ${WSS_USER_HOME}/gopath
#ENV PATH $GOROOT/bin:$GOPATH/bin:$PATH
### Install package managers
#
#RUN go install github.com/tools/godep@latest
#RUN go install github.com/LK4D4/vndr@latest
#RUN go install  github.com/kardianos/govendor@latest
#
##All Deparacted/archived go package managers
## RUN go install  github.com/gpmgo/gopm@latest
## RUN go install  github.com/golang/dep/cmd/dep@latest
## RUN go install github.com/Masterminds/glide@latest
## RUN curl https://glide.sh/get | sh
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
# ARG SCALA_VERSION=2.12.6
#RUN wget https://downloads.lightbend.com/scala/${SCALA_VERSION}/scala-${SCALA_VERSION}.deb --no-check-certificate && \
#	dpkg -i scala-${SCALA_VERSION}.deb && \
#	rm scala-${SCALA_VERSION}.deb
### Install SBT
#RUN wget https://github.com/sbt/sbt/releases/download/v1.5.1/sbt-1.5.1.tgz && \
#	tar xzvf sbt-1.5.1.tgz -C /usr/share/ && \
#	update-alternatives --install /usr/bin/sbt sbt /usr/share/sbt/bin/sbt 9998
#ENV SBT_HOME /usr/share/sbt/bin/
#ENV PATH $PATH:$SBT_HOME


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
#RUN wget https://packages.erlang-solutions.com/erlang-solutions_2.0_all.deb && \
#	dpkg -i erlang-solutions_2.0_all.deb && \
#	apt-get update && \
#	apt-get install esl-erlang -y && \
#	apt-get install elixir -y && \
#	mix local.hex --force && \
#	rm erlang-solutions_2.0_all.deb && \
#	apt-get clean && \
#	rm -rf /var/lib/apt/lists/* && \
#	rm -rf /tmp/*


#### Install Cocoapods
#RUN gem install cocoapods -v 1.10.2
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
# ARG HASKELL_GHC_VERSION=8.6.5
# ARG CABAL_VERSION=3.2
#RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 063DAB2BDC0B3F9FCEBC378BFF3AEACEF6F88286 && \
#	echo "deb http://ppa.launchpad.net/hvr/ghc/ubuntu bionic main " | tee /etc/apt/sources.list.d/ppa_hvr_ghc.list && \
#	apt-get update && \
#	apt-get install -y ghc-${HASKELL_GHC_VERSION} cabal-install-${CABAL_VERSION} && \
#	PATH="/opt/ghc/bin:${PATH}" && \
#	cabal update && \
#	apt-get clean && \
#	rm -rf /var/lib/apt/lists/* && \
#	rm -rf /tmp/*
#ENV PATH /opt/ghc/bin:$PATH


#### Install dotnet cli and Nuget
#RUN wget -q https://packages.microsoft.com/config/ubuntu/18.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb && \
#	dpkg -i packages-microsoft-prod.deb && \
#	apt-get update && \
#	apt-get install -y apt-transport-https && \
#	apt-get install -y dotnet-sdk-2.2 && \
#	apt-get install -y dotnet-sdk-3.1 && \
#	apt-get install -y dotnet-sdk-5.0 && \
#	rm packages-microsoft-prod.deb && \
#	apt-get clean && \
#	rm -rf /var/lib/apt/lists/* && \
#	rm -rf /tmp/*


#### Install Mono
#RUN apt-get update && \
#    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
#    apt-get install -y --no-install-recommends apt-transport-https ca-certificates && \
#    echo "deb https://download.mono-project.com/repo/ubuntu bionic main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
#    apt-get update && \
#    apt-get install -y mono-devel && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/* && \
#    rm -rf /tmp/*

#### Install Nuget CLI
#RUN TMP=/tmp/nuget  && \
#    LIB=/usr/local/lib && \
#    BIN=/usr/local/bin && \
#    rm -rf $TMP $LIB/nuget $BIN/nuget && \
#    mkdir -p $TMP && \
#    cd $TMP && \
#    wget -O nuget.zip https://www.nuget.org/api/v2/package/NuGet.CommandLine/5.10.0 && \
#	unzip nuget.zip && \
#    install -d $LIB/nuget  && \
#    install ./tools/NuGet.exe $LIB/nuget/ && \
#	echo '#!/usr/bin/env bash\nexec mono /usr/local/lib/nuget/NuGet.exe "$@"\n' > $BIN/nuget && \
#	chmod a+x $BIN/nuget && \
#	rm -rf $TMP


## Install Paket
#RUN mozroots --import --sync && \
#    TMP=/tmp/paket/src  && \
#    LIB=/usr/local/lib && \
#    BIN=/usr/local/bin && \
#    rm -rf $TMP && \
#    mkdir -p $TMP && \
#    cd $TMP && \
#    wget -O paket.zip https://www.nuget.org/api/v2/package/Paket/5.257.0 && \
#    unzip paket.zip && \
#    rm -rf $LIB/paket && \
#    install -d $LIB/paket  && \
#    install ./tools/paket.exe $LIB/paket/ && \
#    rm -rf $BIN/paket && \
#    echo $'!/usr/bin/env bash exec mono\n\
#    exec mono /usr/local/lib/paket/paket.exe "$@"\n'\
#    >> $BIN/paket && \
#    chmod a+x $BIN/paket


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

### copy data to the image
# COPY wss wss
# COPY <data-dir> Data

### base command
# CMD java -jar ./wss/wss-unified-agent.jar -c ./wss/wss-unified-agent.config -d ./Data`