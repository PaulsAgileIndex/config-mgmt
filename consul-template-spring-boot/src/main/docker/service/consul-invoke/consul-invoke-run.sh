#!/bin/bash -x

   #############################################################
   ##                                                         ##
   ##  Nice!!!     (ironically)                               ##
   ##                                                         ##
   ##  Consul-template does not get Consuls value at startup! ##
   ##  Which mean that one hat to render a watched key that   ##
   ##  in Consul so that Consul-template renders the target   ##
   ##                                                         ##
   ##  Sometimes efficiency comes before functionality        ##
   ##  Bad ... so bad...!                                     ##
   ##                                                         ##
   #############################################################


exec ./consul-invoke-service.sh >>/var/log/consul-invoke.log 2>&1