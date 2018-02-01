{{$prefix := (env "STAGE")}}
{{key (print $prefix "/reload")}}

	##########################################################
	##    Template Mechanism:                                ##
	##                                                      ##
	##    !!! IMPORTANT !!!                                 ##
	##                                                      ##
	##    consul-tempalte does not have the same -prefix    ##
	##    functionality like confd which results in the     ##
	##    first two lines of this script.                   ## 
	##    It also does not support an initial load of the   ##
	##    values stored in consul. It needs an change       ##
	##    in one of the stored properties on the server to  ##
	##    render the template. A workaround is to send      ##
	##    an initial curl PUT REST request to a watched     ##
	##    variable ($prefix "/reload"). This is done by     ##
	##    the Runit service consul-invoke and its scripts:  ##
	##                                                      ##
	##    @see consul-invoke-service.sh                     ##
	##                                                      ##
	##    ----------------------------------------------    ##
	##    Spring Application:                               ##
	##                                                      ##
	##    This property file will be set on                 ##
	##    an environment path on the executing computer.    ##
	##                                                      ##
	##    The environment variable holding this path is     ##
	##    specified by the local property:                  ##
	##    'base.info.global.override.config.home.env'       ##
	##                                                      ##
	##    See also local file: 'config.properties'          ##
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


