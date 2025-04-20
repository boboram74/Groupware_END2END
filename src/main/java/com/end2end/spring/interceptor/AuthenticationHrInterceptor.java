package com.end2end.spring.interceptor;

import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.util.UnauthorizedException;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Component
public class AuthenticationHrInterceptor implements HandlerInterceptor {
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        HttpSession session = request.getSession(false);
        if(session != null) {
            EmployeeDTO employee = (EmployeeDTO) session.getAttribute("employee");
            if(employee.getDepartmentName().equals("인사팀") && !employee.getRole().equals("NO_AUTH")) {
                return true;
            }
        }

        throw new UnauthorizedException("접근 권한이 없습니다.");
    }
}
