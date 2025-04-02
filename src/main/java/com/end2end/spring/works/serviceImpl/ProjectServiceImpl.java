package com.end2end.spring.works.serviceImpl;



import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.works.dao.ProjectDAO;
import com.end2end.spring.works.dao.ProjectUserDAO;
import com.end2end.spring.works.dto.ProjectDTO;
import com.end2end.spring.works.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProjectServiceImpl implements ProjectService {

    @Autowired
    private ProjectDAO projectDao;
    @Autowired
    private ProjectUserDAO projectUserDao;


    @Override
    public List<ProjectDTO> selectAll() {

        return null;
    }

    @Override
    public List<ProjectDTO> selectByEmployeeId(String employeeId) {

        return null;
    }

    @Override
    public void insert(String name, List<String> employeeId, EmployeeDTO employeeDTO) {
        // String departmentId = departmentDAO.selectByName("연구팀"); 부서 가져올수있는 테이블 dao에 메서드 추가하기 !
//        if (!"Team_Leader".equals(employeeDTO.getRole()) && (departmentId.equals(employeeDTO.getDepartmentId()))) {
//            throw new RuntimeException("프로젝트 생성 권한이 없습니다.");}
// 개발팀 팀리더가 아닌 경우 생성불가 코드인데 다른테이블 dao에 메서드 생성하기 전까지 주석처리
            // 1. project inert (name)

             projectDao.insert(name);

            // 2. employee list -> project_user insert (employeeList, projectId)

             projectUserDao.insert(employeeId);

    }


}
