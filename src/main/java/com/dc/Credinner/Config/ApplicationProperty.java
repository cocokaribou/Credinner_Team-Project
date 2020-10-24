package com.dc.Credinner.Config;

import java.util.Properties;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class ApplicationProperty {

	private static final Logger log = LoggerFactory.getLogger(ApplicationProperty.class);

	static Properties props = new Properties();

	static {
		try {
			
			props.load(Thread.currentThread().getContextClassLoader().getResourceAsStream("/props/App.properties"));
		} catch (Exception e) {
			if (log.isWarnEnabled())
				log.warn(e.toString());
			else
				e.printStackTrace();
		}
	}
	
	public static Properties getInstance(){
		return props;
	}
	
	public static String get(String key) {
		return props.getProperty(key);
	}
	
	public static int getInt(String key) {
		return Integer.parseInt(props.getProperty(key));
	}
	
	public static boolean getBoolean(String key) {
		return Boolean.valueOf(props.getProperty(key)).booleanValue();
	}
	
}