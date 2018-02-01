FROM phusion/baseimage:0.9.22
## https://hub.docker.com/r/phusion/baseimage/

MAINTAINER Frank Sprich <frank.sprich@gmail.com>

CMD ["/sbin/my_init"]

# Install Java
RUN apt-get update && \
    apt-get install -y openjdk-8-jre-headless && \
    apt-get clean && \
    java -version
    
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre    

RUN apt-get update && \
	apt-get install -y wget && \
	apt-get install -y unzip && \
	apt-get install -y git && \
	apt-get install -y curl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

	
ENV CONSUL_TEMPLATE_VERSION 0.19.4

RUN mkdir -p /opt/consul-template/bin	
ENV CONSUL_TEMPLATE_HOME /opt/consul-template/bin
WORKDIR $CONSUL_TEMPLATE_HOME
ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip $CONSUL_TEMPLATE_HOME/

RUN unzip consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
	rm -rf consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
	mkdir -p /consul-template/config.d && \
	mkdir -p /consul-template/templates
	
ENV PATH="/opt/consul-template/bin:${PATH}"		
ADD src/main/docker/config/consul-template/templates/global.config.properties.tpl /consul-template/templates/global.config.properties.tpl


	
ENV APPLICATION_HOME /opt/java/spring-boot/consul-example	
WORKDIR $APPLICATION_HOME 		
## Add the default global config property file
ADD src/main/docker/config/default.global.application.properties $APPLICATION_HOME/global.application.properties
## The application depends on GLOBAL_CONFIG_HOME env var
ENV GLOBAL_CONFIG_HOME $APPLICATION_HOME/global.application.properties	


	
## Create Runit Service: consul-spring-boot (Java SpringBoot Application)
ARG ARTIFACT_NAME
ARG ARTIFACT_FILE_EXTENSION
##Using ARG alone means your variable is visible at build time, not at runtime.
##https://stackoverflow.com/a/33936014
ENV ARTIFACT_NAME=${ARTIFACT_NAME} 
ENV ARTIFACT_FILE_EXTENSION=${ARTIFACT_FILE_EXTENSION} 
ADD target/${ARTIFACT_NAME}.${ARTIFACT_FILE_EXTENSION} $APPLICATION_HOME/$ARTIFACT_NAME.$ARTIFACT_FILE_EXTENSION


## Create Runit Service: consul-template
## https://github.com/phusion/baseimage-docker#adding-additional-daemons
COPY src/main/docker/service/start-app/start-app-run.sh /etc/service/start-app/run
RUN chmod +x /etc/service/start-app/run

COPY src/main/docker/service/consul-template/consul-template-run.sh /etc/service/consul-template/run
RUN chmod +x /etc/service/consul-template/run	

COPY src/main/docker/service/consul-invoke/consul-invoke-run.sh /etc/service/consul-invoke/run
RUN chmod +x /etc/service/consul-invoke/run	

COPY src/main/docker/service/consul-invoke/consul-invoke-service.sh /etc/service/consul-invoke/consul-invoke-service.sh
RUN chmod +x /etc/service/consul-invoke/consul-invoke-service.sh	

#ENV CONSUL_NODE=localhost
#RUN curl -X PUT -d 'oo' http://$CONSUL_NODE/v1/kv/prod/reload	
#RUN curl -X PUT -d 'yoyo' http://172.17.0.1:8500/v1/kv/prod/reload	
#COPY src/main/docker/service/startapp/once.sh /once.sh
#RUN chmod +x /once.sh
#ENTRYPOINT /once.sh




