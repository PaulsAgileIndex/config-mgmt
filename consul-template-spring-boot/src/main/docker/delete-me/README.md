# Reminder to Myself

In the very first attempts to use consul-template I'd had some problems with services 
due to my misunderstanding of consul-template.

The content of this folder (name: **delete-me**) is the leftover of these attempts.
I let this be part of the repository as a marker to do the same mistakes never again.

In my current implementation I let the consul-template supervise the SpringBoot application. 
See also the [start.sh](https://github.com/PaulsAgileIndex/config-mgmt/blob/master/consul-template-spring-boot/src/main/docker/service/start-app/start.sh) 

```
#!/bin/bash

consul-template \
    -consul-addr=$CONSUL_NODE \
    -template "$TEMPLATE:$SPRING_BOOT_HOME/config/application-$STAGE.properties" \
    -log-level=debug >> $SPRING_BOOT_HOME/consul-template.log 2>&1 \
    -wait=5s \
    -exec "java -jar $SPRING_BOOT_HOME/${ARTIFACT_NAME}.${ARTIFACT_FILE_EXTENSION} --spring.profiles.active=$STAGE --spring.config.location=$SPRING_BOOT_HOME/config"
```

which is called by the following code in the [Dockerfile](https://github.com/PaulsAgileIndex/config-mgmt/blob/master/consul-template-spring-boot/Dockerfile)

```
ENTRYPOINT ["/opt/java/spring-boot/start.sh"]
``` 