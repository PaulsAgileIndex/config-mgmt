#!/bin/bash -x

exec curl -X GET http://localhost:8080/configmgmt/example/refresh >>/var/log/rest-invoke.log 2>&1
 