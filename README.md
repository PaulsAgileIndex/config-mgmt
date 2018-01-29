# config-mgmt

## Remove unused images
docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")
