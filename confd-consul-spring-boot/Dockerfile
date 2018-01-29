#FROM ubuntu:16.04
FROM phusion/baseimage:0.9.22
## https://hub.docker.com/r/phusion/baseimage/

MAINTAINER Frank Sprich <frank.sprich@gmail.com>

CMD ["/sbin/my_init"]

## Install curl, ifconfig and nslookup (curl/net-tools/dnsutils)
RUN apt-get update && \
    apt-get install -y apt-utils && \	
    apt-get install -y curl && \
	apt-get install -y net-tools && \
	apt-get install -y dnsutils && \
	apt-get install -y iputils-ping && \
	apt-get clean

# Install Java
RUN apt-get update && \
    apt-get install -y openjdk-8-jre-headless && \
    apt-get clean

RUN java -version

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre

RUN apt-get update && \
	apt-get install -y wget && \
	apt-get install -y unzip && \
	apt-get install -y git && \
	apt-get install -y curl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


ENV APPLICATION_HOME /opt/java/spring-boot/confd-example	
WORKDIR $APPLICATION_HOME 
## Add the default global config property file
ADD src/main/docker/config/default.global.config.properties $APPLICATION_HOME/global.config.properties
## The application depends on GLOBAL_CONFIG_HOME env var
ENV GLOBAL_CONFIG_HOME $APPLICATION_HOME/global.config.properties	
	
	
## Install confd	
RUN mkdir -p /opt/confd/bin	
ENV CONFD_HOME /opt/confd/bin
ENV CONFD_TOML /etc/confd/conf.d/
ENV CONFD_TEMPL /etc/confd/templates/
#WORKDIR $CONFD_HOME
RUN	curl -L https://github.com/kelseyhightower/confd/releases/download/v0.13.0/confd-0.13.0-linux-amd64 -o $CONFD_HOME/confd && \
	chmod +x $CONFD_HOME/confd	
ENV PATH="/opt/confd/bin:${PATH}"	
## Create the confdirectories. It is where template resource configs and source templates are stored
RUN mkdir -p $CONFD_TOML && \
	mkdir -p $CONFD_TEMPL	
ADD src/main/docker/config/confd/conf.d/global.config.properties.toml $CONFD_TOML/global.config.properties.toml
ADD src/main/docker/config/confd/templates/global.config.properties.tmpl $CONFD_TEMPL/global.config.properties.tmpl
## Replace APPLICATION_HOME into confd .toml file
RUN sed -i 's#<replace>#'"$APPLICATION_HOME"'#g'  $CONFD_TOML/global.config.properties.toml
		

## Create Runit Service: confd
COPY src/main/docker/service/confd/confd.sh /etc/service/confd/run
RUN chmod +x /etc/service/confd/run		

## Create Runit Service: confd-consul-spring-boot (Java SpringBoot Application) 
ARG ARTIFACT_NAME
ARG ARTIFACT_FILE_EXTENSION
##Using ARG alone means your variable is visible at build time, not at runtime.
##https://stackoverflow.com/a/33936014
ENV ARTIFACT_NAME=${ARTIFACT_NAME} 
ENV ARTIFACT_FILE_EXTENSION=${ARTIFACT_FILE_EXTENSION} 
ADD target/${ARTIFACT_NAME}.${ARTIFACT_FILE_EXTENSION} $APPLICATION_HOME/$ARTIFACT_NAME.$ARTIFACT_FILE_EXTENSION
COPY src/main/docker/service/startapp/start.sh /etc/service/startapp/run
RUN chmod +x /etc/service/startapp/run		

