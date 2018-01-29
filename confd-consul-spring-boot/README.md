# confd-consul-spring-boot

## Example Application
The application is SpringBoot based but it is using the configuration management approach which one would be using in common JAVA applications. The application offers a REST interface which will print the properties known inside. confd is connecting to a Consul backend and is watching for key/value changes. The application itself and confd are running in one container as two seperate [services](src/main/docker/service/). Therefore I'm using the Docker base image from [phusion/baseimage](https://hub.docker.com/r/phusion/baseimage/)

**Features**
- SpringBoot
- Stage specific configuration 
- confd watching backend
- Consul as backend
- Custom property refresh
- Application local properties could be overridden by global properties


### Build and Run the application
Executing the script [buildAndRunDockerContainer.sh](buildAndRunDockerContainer.sh) creates 5 container. The first one is a Consul container which holds the key/value pairs for every stage the application is deployed to. The remaining four containers are instances of the example application where each is depicting a stage from **dev**, **test**, **uat** to **prod**.

### Integration Test
  1. For easy integration testing use POSTMAN [https://www.getpostman.com/](https://www.getpostman.com/)


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
