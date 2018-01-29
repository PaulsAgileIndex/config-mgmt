# confd-consul-spring-boot


![4631850](https://user-images.githubusercontent.com/4631850/35187372-4d18cdf8-fe23-11e7-8ebf-849d35070b8c.jpg)

So far everybody is aware that stage specific configuration properties (stages: local, dev, test, uat, prod) must reside outside the application. The application itself in agreement with the CI/CD principels should be built only once but run everywhere. This is to ensure that we are not comparing apples with bananas in other words that the same piece of software is passing the multiple quality gates on the way to production. 

In the past if seen multiple approaches for configuration management. The most of them result in problems or at least in huge effort maintaining stage specific configuration. Examples of approaches seen so far:

 - **Bash Scripting**: The scripts where maintained from a developer holding the scripts locally on his shared drive. A new deployment (new components and configuration) took most of the time around half a day.
 - **Stage Specific Build**: One of my past project uses this technique where the configuration of each stage has to be known at build time (non CI/CD compliant). This results in one piece of software for every stage applied within the project.
 - **Wired Bash Scripting**: In one of my offshore experiences in a multi-million Dollar project they used multiple non-automated scripts. One of my colleague (the build master) executed it without any up-to-date documentation. Hopefully he hasn't messed up with his local bus driver so far. Building the software and bringing it to "dev" stage took around one week (Build 2-3h / Deployment 4.5d).
 - **Un-/Repacking the Application**: An approach which works good at least in my experience but has some drawbacks. It also depends on inhouse scripting to replace the stage specific properties. Quality gates are passed not by the same piece of software.


This repository contains a series of configuration management examples which I'm using as blue prints for my own projects or at least to get some experience with the different technologies. 

Please feel free to ask me any question or to give me some feedback on it.

Have fun...



### Build and Run the application
The apllication is 

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
