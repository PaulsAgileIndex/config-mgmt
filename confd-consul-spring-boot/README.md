# confd-consul-spring-boot

## Example Application
The application is SpringBoot based but it is using the configuration management approach which one would be using in common JAVA applications. The application offers a REST interface which will print the properties known inside. confd is connecting to a Consul backend and is watching for key/value changes. The application itself and confd are running in one container as two seperate [services](src/main/docker/service/). Therefore I'm using the Docker base image from [phusion/baseimage](https://hub.docker.com/r/phusion/baseimage/)

**Features**
- **SpringBoot**
- Stage specific configuration 
- **confd** watching backend
- **Consul** as backend
- Custom property refresh
- Application local properties could be overridden by global properties


### Build and Run the application
**Build**  
Executing the script [buildAndRunDockerContainer.sh](buildAndRunDockerContainer.sh) invokes a Maven build which creates the Docker image for the example application. It [Dockerfile](https://github.com/PaulsAgileIndex/config-mgmt/blob/master/confd-consul-spring-boot/Dockerfile) installes Java, cURL, confd and the example SpringBoot application as well some other utilities to the image - *...could be less in future iterations*.

**Run**  
The [script](buildAndRunDockerContainer.sh) also creates 5 containers. The first one is a Consul container which holds the key/value pairs for every stage the application is deployed to. Therefore it leverages confd's prefix mechanism which utilizes Consul's hierarchical key/value storage. The remaining four containers are instances of the example application where each is depicting a stage from **dev**, **test**, **uat** to **prod**.  

Part of [buildAndRunDockerContainer.sh](buildAndRunDockerContainer.sh)
```
docker run 
-itd 
-p 8080:8080 
-e"CONFD_PREFIX=dev" 
-e"CONSUL_NODE=172.17.0.1:8500" 
--name=confd-consul-spring-boot-dev 
--network=bridge avoodoo/confd-consul-spring-boot:1.0-SNAPSHOT
```
To which stage the example application is deployed to is managed by ``-e"CONFD_PREFIX=dev"``. The backend node is given to the container via ``-e"CONSUL_NODE=172.17.0.1:8500"``. Multiple nodes could be provided comma separated. In my case the IP ``172.17.0.1`` is the IP from ``docker0``

### Integration Test
**POSTMAN**  
For easy integration test one can use POSTMAN [https://www.getpostman.com/](https://www.getpostman.com/). The file [confd-example.postman_collection.json](https://github.com/PaulsAgileIndex/config-mgmt/blob/master/confd-consul-spring-boot/postman/confd-example.postman_collection.json) contains a collection of REST calles which could be executed against the deployed example application in its different stages. The stages use different Ports for differentiation (dev:**8080**, test:**8081**, uat:**8082**, prod:**8083****)
  
Request for Stage *dev*  
```
http://localhost:8080/configmgmt/example/showConfig?reset=true
```

**cURL**  
Not so pretty but possible is the usage of cURL.  
  
Request for Stage *prod*  
```
curl http://localhost:8083/configmgmt/example/showConfig?reset=true -X GET
```


### Run the Application from Eclipse

  1. Add Lombok to Eclipse as described above
  2. Navigate to ``edu.avoodoo.configmgnt.example.ConfdExampleApp``
  3. Context menu: **``Run As``** -> **``Java Application``**


### Run the Application from CLI

  1. Navigate to ${project.basedir}
  2. Execute **``mvn spring-boot:run``**


### Integration Test with POSTMAN

 1. Run the Application (SpringBoot)
 2. Import to POSTMAN ``${project.basedir}/postman/confd-example.postman_collection.json`` 
 3. Execute request ``reloadConfig`` or ``isAlive`` 
 4. Check result
 
### Run the Container

```
docker run --name=confd-example-spring-boot --network=bridge -itd -p 8080:8080 -e"APPLICATION_STAGE=popoproduction" avoodoo/confd-example-spring-boot:1.0-SNAPSHOT
```
 
### Useful Linux Commands

**Remove Unused Images**  

```
docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")
```

**Find File**  

```
find / -type f -name ""
## If you want to match more files
find / -type f -iname "filename*"
```
