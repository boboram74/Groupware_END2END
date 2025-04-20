package com.end2end.spring.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CORSConfig implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/**")
                .allowedOrigins("http://221.150.27.169", "http://10.10.55.9", "http://10.5.5.1", "http://34.70.179.192")
                .allowedMethods("*")
                .allowedHeaders("*");
    }

}