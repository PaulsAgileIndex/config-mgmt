#!/bin/bash

## Backend Consul
exec /opt/confd/bin/confd -backend consul -watch -prefix $CONFD_PREFIX -node $CONSUL_NODE >>/var/log/confd.log 2>&1
#   
## Backend Environment Variables (onetime, non watch)
#exec /opt/confd/bin/confd -backend env >>/var/log/confd.log 2>&1