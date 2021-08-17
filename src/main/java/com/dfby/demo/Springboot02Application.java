package com.dfby.demo;

import org.mybatis.spring.annotation.MapperScan;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


@SpringBootApplication
@MapperScan("com.dfby.demo.mapper")
public class Springboot02Application {

    public static void main(String[] args) {
        Logger logger = (Logger) LoggerFactory.getLogger(Springboot02Application.class);
        //调用 sl4j 的 info() 方法，而非调用 logback 的方法
        logger.info("Hello World~~~~main");
        SpringApplication.run(Springboot02Application.class, args);
    }

}
