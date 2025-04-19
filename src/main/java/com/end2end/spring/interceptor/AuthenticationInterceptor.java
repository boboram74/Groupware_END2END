package com.end2end.spring.interceptor;

import com.end2end.spring.employee.dto.EmployeeDTO;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthenticationInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession(false);
        EmployeeDTO employee = (EmployeeDTO)session.getAttribute("employee");
        if(employee != null) { return true; }
        response.sendRedirect("/error");
        return false;
    }
}