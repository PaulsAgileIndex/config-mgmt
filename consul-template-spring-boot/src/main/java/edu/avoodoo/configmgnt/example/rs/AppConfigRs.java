package edu.avoodoo.configmgnt.example.rs;

import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

/**
 * Controller / Resource which handles request from REST clients
 * and re-loads configurations on invocation.
 * 
 * @author Frank Sprich (a|voodoo)
 */
@RestController
public class AppConfigRs {
	
	private static final Logger LOG = Logger.getLogger(AppConfigRs.class);

	
	 @Value("${app.important.db.user}")
	 private String user;
	
	@RequestMapping(method = RequestMethod.GET, path = "/configmgmt/example/isalive")
	public Response isAlive() {
		LOG.info("ALL OK!"  +"user: " + user);
		return Response.ok(true).build();
	}
	
	@RequestMapping(method = RequestMethod.GET, path = "/configmgmt/example/refresh")
	public Response refresh() {
		LOG.info("...a new brezze!" +"user: " + user);
		
		return Response.ok(true).build();
	}

}
