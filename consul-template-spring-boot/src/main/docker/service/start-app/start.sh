#!/bin/bash

consul-template \
	-consul-addr=$CONSUL_NODE \
	-template "/opt/java/spring-boot/global.application.properties.tpl:/opt/java/spring-boot/global.application.properties" \
	-log-level=debug >> /opt/java/spring-boot/consul-template.log 2>&1 \
	-wait=5s \
	-exec "java -jar /opt/java/spring-boot/consul-template-spring-boot.jar --spring.config.location=/opt/java/spring-boot/global.application.properties"