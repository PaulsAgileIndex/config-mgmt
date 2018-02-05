package edu.avoodoo.configmgnt.example.config;

import java.text.MessageFormat;
import java.util.Map;
import java.util.Map.Entry;
import java.util.TreeMap;

import org.springframework.core.env.AbstractEnvironment;
import org.springframework.core.env.Environment;
import org.springframework.core.env.MapPropertySource;
import org.springframework.core.env.PropertiesPropertySource;
import org.springframework.core.env.PropertySource;

/**
 * Cache the active (stage specific) properties - for convenience!
 * 
 * @author Frank Sprich (a|voodoo)
 */
public class AppConfig {
	
	private static final String APPLICATION = "base.info.deployed.application";
	private static final String STAGE = "base.info.deployed.stage";	
	
	/**
	 * Prepares a pretty string representation of the properties cache.
	 * 
	 * @return alphabetical ordered properties (key / vale)
	 */
	public static String print(Environment env) {
        StringBuilder sb = new StringBuilder();
		sb.append(MessageFormat.format("\nApplication config [Application: ''{0}''; Stage: ''{1}'']\n", env.getProperty(APPLICATION), env.getProperty(STAGE))); 
		for (Entry<String, Object> entry : getProperties(env).entrySet()) {
			sb.append(MessageFormat.format("\t{0} = {1}\n", entry.getKey(), entry.getValue()));
		}
		return sb.toString();
	}
	
	
	public static Map<String, Object> getProperties(Environment env) {		
		
		/* A TreeMap has a natural order which leads to an alphabetical order of the output */
		TreeMap<String, Object> map = new TreeMap<>();
        for (PropertySource<?> propertySource : ((AbstractEnvironment) env).getPropertySources()) {
            if (propertySource instanceof PropertiesPropertySource) {
            	map.putAll(((MapPropertySource) propertySource).getSource());
            }
        } 
		return map; 
	}

}
