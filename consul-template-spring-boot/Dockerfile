FROM phusion/baseimage:0.9.22
## https://hub.docker.com/r/phusion/baseimage/

MAINTAINER Frank Sprich <frank.sprich@gmail.com>


## Install Java
RUN apt-get update && \
    apt-get install -y openjdk-8-jre-headless && \
    apt-get clean && \
    java -version    
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/jre    


## Install Utilities (delete after development finished)
RUN apt-get update && \
	apt-get install -y wget && \
	apt-get install -y unzip && \
	apt-get install -y git && \
	apt-get install -y curl && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


## Install consul-template
RUN mkdir -p /opt/consul-template/bin	
ENV CONSUL_TEMPLATE_HOME /opt/consul-template/bin
WORKDIR $CONSUL_TEMPLATE_HOME
ENV CONSUL_TEMPLATE_HOME_VERSION 0.19.4
ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_HOME_VERSION}/consul-template_${CONSUL_TEMPLATE_HOME_VERSION}_linux_amd64.zip $CONSUL_TEMPLATE_HOME/
RUN unzip $CONSUL_TEMPLATE_HOME/consul-template_${CONSUL_TEMPLATE_HOME_VERSION}_linux_amd64.zip && \
	rm -rf $CONSUL_TEMPLATE_HOME/consul-template_${CONSUL_TEMPLATE_HOME_VERSION}_linux_amd64.zip
ENV PATH="${CONSUL_TEMPLATE_HOME}:${PATH}"	


## Install SpringBoot application
WORKDIR /opt/java/spring-boot 
ARG ARTIFACT_NAME
ARG ARTIFACT_FILE_EXTENSION
ENV ARTIFACT_NAME=${ARTIFACT_NAME} 
ENV ARTIFACT_FILE_EXTENSION=${ARTIFACT_FILE_EXTENSION} 
ENV SPRING_BOOT_HOME=/opt/java/spring-boot
ENV GLOBAL_CONFIG $SPRING_BOOT_HOME/config/global.application.properties
ADD target/${ARTIFACT_NAME}.${ARTIFACT_FILE_EXTENSION} $SPRING_BOOT_HOME/$ARTIFACT_NAME.$ARTIFACT_FILE_EXTENSION


## Add the template for consul-template
ENV TEMPLATE=$SPRING_BOOT_HOME/config/tmpl/global.application.properties.tpl
ADD src/main/docker/config/consul-template/templates/global.application.properties.tpl $TEMPLATE


## Start consul-template and start/supervise the SpringBoot application
ADD src/main/docker/service/start-app/start.sh start.sh
RUN chmod +x start.sh
ENTRYPOINT ["/opt/java/spring-boot/start.sh"]


