package com.end2end.spring.interceptor;

import com.end2end.spring.employee.dto.EmployeeDTO;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class AuthenticationAdminInterceptor implements HandlerInterceptor {
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);

        if(session != null) {
            EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
            if(employee.getRole().equals("ADMIN")) {
                return true;
            }

            response.sendRedirect(request.getContextPath() + "/error");
            return false;
        }
        return false;
    }
}
