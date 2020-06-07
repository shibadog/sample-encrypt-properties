package com.shibadog.sample.encryptproperties;

import javax.annotation.PostConstruct;

import com.ulisesbocchio.jasyptspringboot.annotation.EnableEncryptableProperties;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.SpringApplication;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@EnableEncryptableProperties
public class Application {

	@Value("${test.password}")
	private String password;

	public static void main(String[] args) {
		SpringApplication.run(Application.class, args);
	}

	@PostConstruct
	public void run() {
		log.info(this.password);
	}
}
