# Consul Container


### Run the Container

```
docker run --name=consul --network=bridge -itd -p 8400:8400 -p 8500:8500 -p 8600:53/udp -h node1 progrium/consul -server -bootstrap -ui-dir /ui
```
