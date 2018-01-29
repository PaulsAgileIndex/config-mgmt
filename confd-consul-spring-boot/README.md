# confd-example-spring-boot


![4631850](https://user-images.githubusercontent.com/4631850/35187372-4d18cdf8-fe23-11e7-8ebf-849d35070b8c.jpg)

### Prerequisite
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