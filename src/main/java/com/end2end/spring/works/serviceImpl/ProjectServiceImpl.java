package com.end2end.spring.works.serviceImpl;

import com.end2end.spring.alarm.AlarmService;
import com.end2end.spring.alarm.AlarmType;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.works.dao.ProjectDAO;
import com.end2end.spring.works.dao.ProjectUserDAO;
import com.end2end.spring.works.dto.*;
import com.end2end.spring.works.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import java.util.ArrayList;
import java.util.List;

@Service
public class ProjectServiceImpl implements ProjectService {

    @Autowired
    private ProjectDAO projectDao;
    @Autowired
    private ProjectUserDAO projectUserDao;
    @Autowired
    private AlarmService alarmService;


    //    @Override
//    public Map<String, Integer> getProjectStatistics() {
//        List<ProjectDTO> projects = selectAll();
//        Map<String, Integer> stats = new HashMap<>();
//        // 실제로 projects 데이터를 사용해서 통계 계산
//        int ongoing = 0;
//        int completed = 0;
//
//        for (ProjectDTO project : projects) {
//            if ("진행중".equals(project.getStatus())) {
//                ongoing++;
//            } else if ("완료".equals(project.getStatus())) {
//                completed++;
//            }
//        }
//        stats.put("진행중", ongoing);
//        stats.put("완료", completed);
//        stats.put("전체", projects.size());
//        return stats;
//    }


    @Transactional
    @Override
    public void insert(ProjectInsertDTO dto) {
        ProjectDTO projectDTO = ProjectDTO.builder()
                .name(dto.getTitle())
                .deadLine(dto.getDeadLine())
                .build();
        // 프로젝트 삽입
        projectDao.insert(projectDTO);
//    for(int i = 0 ; i < dto.getEmployeeId().size() ; i++) {
//        ProjectUserDTO projectUserDTO = new ProjectUserDTO(dto.getEmployeeId().get(i), projectDTO.getId());
//        projectUserDao.insert(projectUserDTO);
//    }
        for (String employeeId : dto.getEmployeeId()) {
            ProjectUserDTO projectUserDTO = ProjectUserDTO.builder()
                    .employeeId(employeeId)
                    .projectId(projectDTO.getId())
                    .build();
            projectUserDao.insert(projectUserDTO);
        }

        alarmService.sendProjectAlarm(
                AlarmType.PROJECT_CREATE, "/project/detail/" + projectDTO.getId(), projectDTO.getId());
    }

    @Override
    public ProjectDTO findLatestProject(){
        return projectDao.findLatestProject();
    }
@Override
public List<EmployeeDTO> getMembersByProjectId(int projectId){
        return projectDao.getMembersByProjectId(projectId);
}
    @Override
    public List<ProjectSelectDTO> selectAllProject() {
        List<ProjectDTO> projectDTO = projectDao.selectAll();
        // SELECT * FROM PROJECT;

        List<ProjectSelectDTO> result = new ArrayList<>();
        for (ProjectDTO dto : projectDTO) {
            List<EmployeeDTO> projectUserList =
                    projectUserDao.selectByprojectId(dto.getId());
            // SELECT EMPLOYEE.* FROM PROJECT_USER JOIN EMPLOYEE ON PROJECT_USER.EMPLOYEEID = EMPLOYEE.ID WHERE PROJECTID = ?

            List<String>profileImgList = new ArrayList<>();
            for (EmployeeDTO employeeDTO : projectUserList) {
                profileImgList.add(employeeDTO.getProfileImg());
            }

            ProjectSelectDTO projectSelectDTO = ProjectSelectDTO.builder()
                    .id(dto.getId())
                    .name(dto.getName())
                    .hideYn(dto.getHideYn())
                    .status(dto.getStatus())
                    .regDate(dto.getRegDate())
                    .deadLine(dto.getDeadLine())
                    .profileImg(profileImgList)
                    .build();
            result.add(projectSelectDTO);
        }

        return result;
    }


//    public void insert(ProjectDTO dto, ProjectUserDTO udto) {
//        // String departmentId = departmentDAO.selectByName("연구팀"); 부서 가져올수있는 테이블 dao에 메서드 추가하기 !

    /// /        if (!"Team_Leader".equals(employeeDTO.getRole()) && (departmentId.equals(employeeDTO.getDepartmentId()))) {
    /// /            throw new RuntimeException("프로젝트 생성 권한이 없습니다.");}
    /// / 개발팀 팀리더가 아닌 경우 생성불가 코드인데 다른테이블 dao에 메서드 생성하기 전까지 주석처리
//        // 1. project inert (name)
//
//        projectDao.insert(dto);
//
//        // 2. employee list -> project_user insert (employeeList, projectId)
//
//        projectUserDao.insert(udto);
//
//    }
    @Override
    public ProjectDTO selectById(int id) {

        return projectDao.selectById(id);
    }

    @Override
    public void deleteById(int id) {

        projectDao.deleteById(id);
    }

    @Override
    public void update(ProjectDTO dto) {
        // TODO: 프로젝트 수정
    }

    @Override
    public List<ProjectDTO> selectByName(String name) {
        // TODO: 이름으로 검색
        return null;
    }

    @Override
    public List<EmployeeDTO> selectByUser(String name) {
        // TODO: 이름으로 검색
        String target = "%" + name + "%";

        return projectDao.selectByUser(target);
    }



}
