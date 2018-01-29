#!/bin/bash
## http://www.mricho.com/confd-and-docker-separating-config-and-code-for-containers/
set -e

confd -onetime -backend env

echo "Starting SpringBoot app: confd-example"

exec java -jar $ARTIFACT
