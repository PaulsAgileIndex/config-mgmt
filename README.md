# config-mgmt

## Motivation

So far everybody is aware that stage specific configuration properties (stages: local, dev, test, uat, prod) must reside outside the application. The application itself in agreement with the CI/CD principles should be built only once but run everywhere. This is to ensure that we are not comparing apples with bananas in other words that the same piece of software is passing the multiple quality gates on the way to production. 

In the past I have seen multiple approaches for configuration management. The most of them results in problems or at least in huge effort maintaining stage specific configuration.  

### Some Bad Experiences  
 - **Bash Scripting**: The scripts where maintained from a developer holding the scripts locally on his shared drive. A new deployment (new components and configuration) took most of the time around half a day.
 - **Stage Specific Build**: One of my past projects uses this technique where the configuration of each stage has to be known at build time (non CI/CD compliant). This results in one piece of software for every stage applied within the project.
 - **Wired Bash Scripting**: In one of my offshore experiences in a multi-million Dollar project they used multiple non-automated scripts. One of my colleague (the build master) executed it without any up-to-date documentation. Hopefully he hasn't messed up with his local bus driver so far. Building the software and bringing it to "dev" stage took around half a week (Build 2-3h / Deployment 2-3d).  
 ![4631850](https://user-images.githubusercontent.com/4631850/35187372-4d18cdf8-fe23-11e7-8ebf-849d35070b8c.jpg)
 - **Un-/Repacking the Application**: An approach which works good at least in my experience but has some drawbacks. It also depends on inhouse scripting to replace the stage specific properties. Quality gates are passed not by the same piece of software.
 - **None**: One other offshore experience (at its time one of Europe biggest projects) didn't have the ability to be deployed to different stages. A development cycle took two weeks after that one guy copied the jars to the stage by hand and made changes locally on his laptop (Grrrr...!). 


## Situation

This repository contains a series of configuration management examples which I'm using as blue prints for my own projects or at least to get some experience with the different technologies.  
I'm using Docker, confd, Consul, SpringBoot. I will use build-in capabilities as well as custom made implementations inside the different sub-repositories. 

- Dockerized [confd-consul-spring-boot](https://github.com/PaulsAgileIndex/config-mgmt/tree/master/confd-consul-spring-boot) application (**confd** as template, Consul as backend, SpringBoot, custom property mechanism)

- Dockerized [consul-template-spring-boot](https://github.com/PaulsAgileIndex/config-mgmt/tree/master/consul-template-spring-boot) application (**Consul** as template and backend provider, SpringBoot, Spring config mechanism)


## Feedback

Please feel free to ask me any question or to give me some feedback on it.


## Work Assignment
Have fun...!

## Remove unused images
```
docker rmi -f $(docker images | grep "<none>" | awk "{print \$3}")
```
