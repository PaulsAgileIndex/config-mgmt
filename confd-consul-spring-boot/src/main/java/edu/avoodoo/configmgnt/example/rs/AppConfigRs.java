package edu.avoodoo.configmgnt.example.rs;

import java.util.Map;

import javax.ws.rs.PathParam;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import edu.avoodoo.configmgnt.example.config.AppConfig;

/**
 * Controller / Resource which handles request from REST clients
 * and re-loads configurations on invocation.
 * 
 * @author Frank Sprich (a|voodoo)
 */
@RestController
public class AppConfigRs {
	
	private static final Logger LOG = Logger.getLogger(AppConfigRs.class);
	
	@RequestMapping(method = RequestMethod.GET, path = "/configmgmt/example/showConfig")
	public Map<String, String> showConfig(@PathParam("reset")boolean reset) {	
		if (reset) {
			AppConfig.reset();
		}
		String appConfig = AppConfig.print();
		LOG.info(appConfig);
		return AppConfig.getProperties();
	}
	
	@RequestMapping(method = RequestMethod.GET, path = "/configmgmt/example/reloadConfig")
	public boolean reloadConfig() {	
		try {
			AppConfig.reset();
			String appConfig = AppConfig.print();
			LOG.info(appConfig);
			return true;
		}
		catch (Exception e) {
			return false;
		}
	}
	
	@RequestMapping(method = RequestMethod.GET, path = "/configmgmt/example/isalive")
	public Response isAlive() {
		LOG.info("ALL OK!");
		return Response.ok(true).build();
	}

}
