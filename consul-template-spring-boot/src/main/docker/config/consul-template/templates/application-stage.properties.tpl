## {{ $prefix := (env "STAGE") }}

	##########################################################
	##    Template Mechanism:                               ##
	##                                                      ##
	##    !!! IMPORTANT !!!                                 ##
	##                                                      ##
	##    consul-tempalte does not have the same -prefix    ##
	##    functionality like confd which results in the     ##
	##    first two lines of this script.                   ## 
	##                                                      ##
	##    ----------------------------------------------    ##
	##                                                      ##
	##    Spring Application:                               ##
	##                                                      ##
	##    This property file will be set on                 ##
	##    an environment path on the executing computer.    ##
	##                                                      ##
	##    Target is to amend this file with                 ## 
	##    'consul-template' for the different stages        ##
	##    (dev, test, uat, prod).                           ##
	##                                                      ##
	##########################################################


##########################################################
##    Base info for application and                     ##
##    configuration management                          ##
##########################################################
base.info.deployed.application={{key (print $prefix "/base/info/deployed/application")}} (origin:consul-template)
base.info.deployed.stage={{key (print $prefix "/base/info/deployed/stage")}} (origin:consul-template)


##########################################################
##    Application Specific Properties: global (static)  ##
##########################################################
app.important.var3=globalVar3 (origin:consul-template)
app.important.var4=globalVar4 (origin:consul-template)


##########################################################
##    Stage Specific Properties: consul-tempalte        ##
##########################################################
app.important.service.ip={{key (print $prefix "/app/important/service/ip")}} (origin:consul-template)
app.important.db.url={{key (print $prefix "/app/important/db/url")}} (origin:consul-template)
app.important.db.user={{key (print $prefix "/app/important/db/user")}} (origin:consul-template)


