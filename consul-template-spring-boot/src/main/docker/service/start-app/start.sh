#!/bin/bash

consul-template \
	-consul-addr=$CONSUL_NODE \
	-template "$TEMPLATE:$GLOBAL_CONFIG" \
	-log-level=debug >> $SPRING_BOOT_HOME/consul-template.log 2>&1 \
	-wait=5s \
	-exec "java -jar $SPRING_BOOT_HOME/${ARTIFACT_NAME}.${ARTIFACT_FILE_EXTENSION} --spring.config.location=$GLOBAL_CONFIG"