# POSTMAN

## Configuration
The given integration tests are using the key ``{{confd-example-spring-boot}}`` which has 
to be present in POSTMAN.  

The environment has to be chosen with the drop down on the **POSTMAN** GUI.  
 
   
### Example
```
http://{{confd-example-spring-boot}}:8080/configmgmt/example/showConfig?reset=true
```  
 
   
### Alternative 1
```
http://localhost:8080/configmgmt/example/showConfig?reset=true
```  
 
   
### Alternative 2 *(192.168.91.129 IP from my local Ubuntu VM)*
```
http://192.168.91.129:8080/configmgmt/example/showConfig?reset=true
```