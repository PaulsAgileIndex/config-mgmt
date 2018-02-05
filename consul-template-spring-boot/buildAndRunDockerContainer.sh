#!/bin/bash -x

cat << EOF

   #############################################################
   ##                                                         ##
   ##  In the current version I do NOT use volumes for        ##
   ##  Consul Server.                                         ##
   ##                                                         ##
   ##  I'm using a local volume for Consul which brings       ##
   ##  problems during restart.                               ##                         
   ##  "$CONSUL_HOST_VOLUME/raft/peers.json" has to be        ##
   ##  deleted on Consul restart (re-elect Quorum)!           ##
   ##  https://www.consul.io/docs/guides/outage.html          ##
   ##                                                         ##
   #############################################################
	
EOF

docker kill consul
docker rm consul
## With a volume created on your local machine (host)
#export CONSUL_HOST_VOLUME=/var/data/consul/data
#mkdir -p $CONSUL_HOST_VOLUME
#rm -f $CONSUL_HOST_VOLUME/raft/peers.json
#docker run --name=consul --network=bridge -itd -p 8400:8400 -p 8500:8500 -p 8600:53/udp -v $CONSUL_HOST_VOLUME:/data -h node1 progrium/consul -server -bootstrap -ui-dir /ui

## Without a volume on the host
docker run --name=consul --network=bridge -itd -p 8400:8400 -p 8500:8500 -p 8600:53/udp  -h node1 progrium/consul -server -bootstrap -ui-dir /ui


cat << EOF

	
   #############################################################
   ##                                                         ##
   ##  Building the Docker image for the application:         ##
   ##                                                         ##
   ##  consul-spring-boot                                     ##
   ##                                                         ##
   #############################################################

EOF
mvn clean install -DskipTests
## If this script is executed with sudo change the owner to your user e.g. "frank" or start Eclipse with root. 
## Otherwise there could be a poblem to delete or override the target fodler content from Eclipse.
#chown "frank":"frank" target -R


cat << EOF

   #############################################################
   ##                                                         ##
   ##  Add key/value to Consul for the stages:                ##
   ##                                                         ##
   ##  dev                                                    ##
   ##  test                                                   ##
   ##  uat                                                    ##
   ##  prod                                                   ##
   ##                                                         ##
   #############################################################

EOF

## Stage: dev
curl -X PUT -d 'Configuration Management Blueprint (dev)' http://localhost:8500/v1/kv/dev/base/info/deployed/application
curl -X PUT -d 'dev' http://localhost:8500/v1/kv/dev/base/info/deployed/stage
curl -X PUT -d '1.1.1.1' http://localhost:8500/v1/kv/dev/app/important/service/ip
curl -X PUT -d 'www.somewhere.com/consul-template/dev' http://localhost:8500/v1/kv/dev/app/important/db/url
curl -X PUT -d 'frank@dev' http://localhost:8500/v1/kv/dev/app/important/db/user

## Stage: test
curl -X PUT -d 'Configuration Management Blueprint (test)' http://localhost:8500/v1/kv/test/base/info/deployed/application
curl -X PUT -d 'test' http://localhost:8500/v1/kv/test/base/info/deployed/stage
curl -X PUT -d '2.2.2.2' http://localhost:8500/v1/kv/test/app/important/service/ip
curl -X PUT -d 'www.somewhere.com/consul-template/test' http://localhost:8500/v1/kv/test/app/important/db/url
curl -X PUT -d 'frank@test' http://localhost:8500/v1/kv/test/app/important/db/user

## Stage: uat
curl -X PUT -d 'Configuration Management Blueprint (uat)' http://localhost:8500/v1/kv/uat/base/info/deployed/application
curl -X PUT -d 'uat' http://localhost:8500/v1/kv/uat/base/info/deployed/stage
curl -X PUT -d '3.3.3.3' http://localhost:8500/v1/kv/uat/app/important/service/ip
curl -X PUT -d 'www.somewhere.com/consul-template/uat' http://localhost:8500/v1/kv/uat/app/important/db/url
curl -X PUT -d 'frank@uat' http://localhost:8500/v1/kv/uat/app/important/db/user

## Stage: prod
curl -X PUT -d 'Configuration Management Blueprint (prod)' http://localhost:8500/v1/kv/prod/base/info/deployed/application
curl -X PUT -d 'prod' http://localhost:8500/v1/kv/prod/base/info/deployed/stage
curl -X PUT -d '4.4.4.4' http://localhost:8500/v1/kv/prod/app/important/service/ip
curl -X PUT -d 'www.somewhere.com/consul-template/prod' http://localhost:8500/v1/kv/prod/app/important/db/url
curl -X PUT -d 'frank@prod' http://localhost:8500/v1/kv/prod/app/important/db/user

cat << EOF

	
   #############################################################
   ##                                                         ##
   ##  Start application "consul-template-spring-boot"        ##
   ##  for stages:                                            ##
   ##                                                         ##
   ##  dev  (8080)                                            ##
   ##  test (8081)                                            ##
   ##  uat  (8082)                                            ##
   ##  prod (8083)                                            ##
   ##                                                         ##
   #############################################################

EOF

## Stage: dev
docker kill consul-template-spring-boot-dev
docker rm consul-template-spring-boot-dev
docker run -dit -p 8080:8080 -e"STAGE=dev" -e"CONSUL_NODE=172.17.0.1:8500" --name=consul-template-spring-boot-dev --network=bridge avoodoo/consul-template-spring-boot:1.0-SNAPSHOT
## Stage: test
docker kill consul-template-spring-boot-test
docker rm consul-template-spring-boot-test
docker run -itd -p 8081:8080 -e"STAGE=test" -e"CONSUL_NODE=172.17.0.1:8500" --name=consul-template-spring-boot-test --network=bridge avoodoo/consul-template-spring-boot:1.0-SNAPSHOT
## Stage: uat
docker kill consul-template-spring-boot-uat
docker rm consul-template-spring-boot-uat
docker run -itd -p 8082:8080 -e"STAGE=uat" -e"CONSUL_NODE=172.17.0.1:8500" --name=consul-template-spring-boot-uat --network=bridge avoodoo/consul-template-spring-boot:1.0-SNAPSHOT
## Stage: prod
docker kill consul-template-spring-boot-prod
docker rm consul-template-spring-boot-prod
docker run -itd -p 8083:8080 -e"STAGE=prod" -e"CONSUL_NODE=172.17.0.1:8500" --name=consul-template-spring-boot-prod --network=bridge avoodoo/consul-template-spring-boot:1.0-SNAPSHOT

cat << EOF

	
   #############################################################
   ##                                                         ##
   ##  Let Docker some time to start the container before     ##
   ##  testing with e.g. POSTMAN                              ##
   ##                                                         ##
   ##  dev  (8080)                                            ##
   ##  test (8081)                                            ##
   ##  uat  (8082)                                            ##
   ##  prod (8083)                                            ##
   ##                                                         ##
   ##  My machine need around 30s to set up.                  ##
   ##                                                         ##
   ##  i7-7500U 2.70GHz XPS13 9360 (64-bit)                   ##
   ##  16.0 GB                                                ##
   ##                                                         ##
   ##  ...so please WAIT?!                                    ##
   ##                                                         ##
   #############################################################

EOF

sleep 30s

cat << EOF

	
   #############################################################
   ##                                                         ##
   ##  ....READY!                                             ##
   ##                                                         ##
   #############################################################

EOF

docker ps

docker exec -it consul-template-spring-boot-prod bash

