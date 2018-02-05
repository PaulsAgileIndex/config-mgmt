#!/bin/bash

consul-template \
	-consul-addr=$CONSUL_NODE \
	-template "$TEMPLATE:$SPRING_BOOT_HOME/config/application-$STAGE.properties" \
	-log-level=debug >> $SPRING_BOOT_HOME/consul-template.log 2>&1 \
	-wait=5s \
	-exec "java -jar $SPRING_BOOT_HOME/${ARTIFACT_NAME}.${ARTIFACT_FILE_EXTENSION} --spring.profiles.active=$STAGE --spring.config.location=$SPRING_BOOT_HOME/config"