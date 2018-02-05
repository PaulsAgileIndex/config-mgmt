#!/bin/bash -x

## Consul
docker kill consul
docker rm consul

## Stage: dev
docker kill consul-template-spring-boot-dev
docker rm consul-template-spring-boot-dev

## Stage: test
docker kill consul-template-spring-boot-test
docker rm consul-template-spring-boot-test

## Stage: uat
docker kill consul-template-spring-boot-uat
docker rm consul-template-spring-boot-uat

## Stage: prod
docker kill consul-template-spring-boot-prod
docker rm consul-template-spring-boot-prod