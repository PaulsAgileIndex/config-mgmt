package edu.avoodoo.configmgnt.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * SpringBoot main class. Just run this application with
 * context menu: Run As -> JavaApplication.
 * 
 * After Maven build run: "java -jar confd-example-spring-boot.jar"
 * 
 * @author Frank Sprich (a|voodoo)
 */
@SpringBootApplication
public class ConfdExampleApp {

	public static void main(String[] args) {
		SpringApplication.run(ConfdExampleApp.class, args);
	}
	
}
