#!/bin/bash -x


## http://kchard.github.io/runit-quickstart/
#for i in {1..30}
while true
do
	file=$GLOBAL_CONFIG_HOME
	if  [ ! -s "$file" ]; then 
    	echo "file does not exist, or is empty!"
    	
    	#now=$(date "+%Y%m%d%H%M%S") 
    	curl -X PUT -d "--- now ---" http://$CONSUL_NODE/v1/kv/$STAGE/reload
    	sleep 10s
 	else
    	sleep 10s
 	fi 	
done

echo "Oh no I crashed..."
exit 1