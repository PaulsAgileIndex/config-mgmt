#!/bin/bash

exec /opt/consul-template/bin/consul-template >>/var/log/consul-template.log 2>&1