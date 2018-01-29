package edu.avoodoo.configmgnt.example.config;

import java.io.FileInputStream;
import java.io.InputStream;
import java.nio.file.Paths;
import java.text.MessageFormat;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Properties;
import java.util.TreeMap;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.log4j.Logger;

/**
 * Configuaration to be used in applications.
 * The application must have a local config.properties file. Properties could also be 
 * 
 * @author Frank Sprich (a|voodoo)
 */
public class AppConfig {

	private static final Logger LOG = Logger.getLogger(AppConfig.class);
	
	private static final String DEFAULT_PROPERTY_FILE = "config.properties";
	
	private static final String APPLICATION = "base.info.deployed.application";
	private static final String STAGE = "base.info.deployed.stage";
	private static final String GLOBAL_OVERRIDE = "base.info.global.override";
	private static final String GLOBAL_CONFIG_HOME_ENV = "base.info.global.override.config.home.env";
	
	private static ConcurrentHashMap<String, String> cache = new ConcurrentHashMap<>();	
	
	/**
	 * Get value from property.
	 * 
	 * @param key Key of the property
	 * @return value (even if null)
	 */
	public static String get(String key) {
		lazyLoad();
		return cache.get(key);
	}
	
	/**
	 * Get value from property and checks for mandatory existance of the property. 
	 * 
	 * @param key the key of the property
	 * @param nullable defines if a RuntimeException is thrown if the property is not found
	 * @return the value of the property
	 */
	public static String get(String key, boolean nullable) {
		lazyLoad();
		String result = cache.get(key);
		if (!nullable && null == result) {
			throw new RuntimeException(MessageFormat.format("No value found in configuration for key ''{0}''", key)) ;
		}
		return result;
	}
	
	/**
	 * Get boolean value from property.
	 * 
	 * @param key the key of the property
	 * @return the value of the property
	 */
	public static Boolean getBoolean(String key) {	
		String str = get(key);
		return Boolean.parseBoolean(str);
	}
	
	/**
	 * Get boolean value from property and checks for mandatory existence of the property.
	 * 
	 * @param key the key of the property
	 * @return the value of the property
	 */
	public static Boolean getBoolean(String key, boolean nullable) {	
		return Boolean.parseBoolean(get(key, nullable));
	}
	
	/**
	 * Reset properties cache by reload properties from local resp. global properties file.
	 */
	public static void reset() {
		init();
	}

	/**
	 * Utility class constructor should be held private.
	 */
	private AppConfig() {
		
	}
	
	/**
	 * Loads cache during first call to {@link #getValue(String, boolean)}
	 */
	private static void lazyLoad() {
		if (cache.isEmpty()) {
			init();
		}
	}
	
	/**
	 * Reload properties from local resp. global properties file.
	 */
	private static void init() {
		loadLocalConfig();
		loadGlobalConfig();
	}
	
	/**
	 * Loads the configuration form the local properties file.
	 */
	private static void loadLocalConfig() {
		ClassLoader cl = Thread.currentThread().getContextClassLoader();
		try(InputStream in = cl.getResourceAsStream(DEFAULT_PROPERTY_FILE)){
			Properties prop = new Properties();
			prop.load(in);
			for (String key : prop.stringPropertyNames()){
				cache.put(key, prop.getProperty(key));
			}
		} catch (Exception e) {
			String msg = MessageFormat.format("Problems loading LOCAL configuration from file ''{0}''!", DEFAULT_PROPERTY_FILE);
			LOG.error(msg, e);
			throw new RuntimeException(msg);
		}
	}
	
	/**
	 * Loads the configuration from a global properties file.
	 * <ul>
	 * <li>The local property 'base.info.global.override' must be set to true (locally) to override properties from outside
	 * <li>The local property 'base.info.global.override' cannot be overriden from outside
	 * </ul>
	 */
	private static void loadGlobalConfig() {
		if (getBoolean(GLOBAL_OVERRIDE)) {
			String configFilePath = System.getenv(get(GLOBAL_CONFIG_HOME_ENV, false));			
			try(InputStream in = new FileInputStream(Paths.get(configFilePath).toFile())){
				Properties prop = new Properties();
				prop.load(in);
				for (String key : prop.stringPropertyNames()){
					if (GLOBAL_OVERRIDE.equals(key) || GLOBAL_OVERRIDE.equals(key)) { // Do not override the override flag from outside!						
						LOG.warn(MessageFormat.format("Do not override the override flag ''{0}'' from outside! "
								+ "Current value is ''{1}'' specified in local file ''{2}''. "
								+ "The global override flag is currently also specified in the global properties file ''{3}''", GLOBAL_OVERRIDE, get(GLOBAL_OVERRIDE), DEFAULT_PROPERTY_FILE, configFilePath));
					}
					else {
						cache.put(key, prop.getProperty(key));
					}
				}
			}
			catch (Exception e) {
				String msg = MessageFormat.format("Problems loading GLOBAL configuration from file ''{0}''. Path is based on environment variable ''{1}''.", configFilePath, get(GLOBAL_CONFIG_HOME_ENV));
				LOG.error(msg, e);
				throw new RuntimeException(msg);
			}
		}
		else {
			LOG.warn(MessageFormat.format("GLOBAL configuration override is not configured. LOCAL property ''{0}'' must be set to ''true'' in LOCAL file ''{1}''", GLOBAL_OVERRIDE, DEFAULT_PROPERTY_FILE));
		}
	}
	
	/**
	 * Prepares a pretty string representation of the properties cache.
	 * 
	 * @return alphabetical ordered properties (key / vale)
	 */
	public static String print() {		
		StringBuilder sb = new StringBuilder();
		sb.append(MessageFormat.format("\nApplication config [Application: ''{0}''; Stage: ''{1}'']\n", get(APPLICATION), get(STAGE))); 
		
		/* A TreeMap has a natural order which leads to an alphabetical order of the output */
		TreeMap<String, String> map = new TreeMap<>();
		map.putAll(cache);
		for (Entry<String, String> entry : map.entrySet()) {
			sb.append(MessageFormat.format("\t{0} = {1}\n", entry.getKey(), entry.getValue()));
		}

		return sb.toString();
	}
	
	public static Map<String, String> getProperties() {
		/* A TreeMap has a natural order which leads to order of  the output (alphabetical) */
		TreeMap<String, String> map = new TreeMap<>();
		map.putAll(cache);
		return map;
	}

}
