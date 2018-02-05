#!/bin/bash

exec /opt/consul-template/bin/consul-template \
	-consul-addr=$CONSUL_NODE \
	-template "/opt/java/spring-boot/global.config.properties.tpl:$GLOBAL_CONFIG_HOME" \
	-log-level=debug >>/var/log/consul-template.log 2>&1
