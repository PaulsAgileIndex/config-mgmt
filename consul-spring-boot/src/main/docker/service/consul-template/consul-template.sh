#!/bin/bash

exec /opt/consul-template/bin/consul-template -consul-addr=$CONSUL_NODE -log-level=debug >>/var/log/consul-template.log 2>&1