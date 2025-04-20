package com.end2end.spring.config;

import com.end2end.spring.interceptor.AccessDenyInterceptor;
import com.end2end.spring.interceptor.AuthenticationInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {
    @Autowired private AuthenticationInterceptor authenticationInterceptor;
    @Autowired private AccessDenyInterceptor accessDenyInterceptor;

    @Override
    public void addInterceptors(org.springframework.web.servlet.config.annotation.InterceptorRegistry registry) {
        registry.addInterceptor(authenticationInterceptor)
                .addPathPatterns("/**")
                .excludePathPatterns("/login");
    }
}
