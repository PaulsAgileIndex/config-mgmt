package edu.avoodoo.configmgnt.example.rs;

import java.util.Map;

import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.env.Environment;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import edu.avoodoo.configmgnt.example.config.AppConfig;


/**
 * Controller / Resource which handles request from REST clients and re-loads
 * configurations on invocation.
 * 
 * @author Frank Sprich (a|voodoo)
 */
@RestController
public class AppConfigRs {

	private static final Logger LOG = Logger.getLogger(AppConfigRs.class);

	@Value("${app.important.db.user}")
	private String user;

	@Autowired
	Environment env;

	@RequestMapping(method = RequestMethod.GET, path = "/configmgmt/example/showConfig")
	public Map<String, Object> showConfig() {
		
		String appConfig = AppConfig.print(env);
		LOG.info(appConfig);
		
		return AppConfig.getProperties(env);
	}
	
	
	@RequestMapping(method = RequestMethod.GET, path = "/configmgmt/example/isalive")
	public Response isAlive() {
		LOG.info("ALL OK!");
		return Response.ok(true).build();
	}

}
