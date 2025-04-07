package com.end2end.spring.works.serviceImpl;

import com.end2end.spring.works.dao.ProjectDAO;
import com.end2end.spring.works.dao.ProjectUserDAO;
import com.end2end.spring.works.dto.ProjectDTO;
import com.end2end.spring.works.dto.ProjectUserDTO;
import com.end2end.spring.works.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ProjectServiceImpl implements ProjectService {

    @Autowired
    private ProjectDAO projectDao;
    @Autowired
    private ProjectUserDAO projectUserDao;

    @Override
    public List<ProjectDTO> selectAll() {
        return projectDao.selectAll();
    }

    @Override
    public Map<String, Integer> getProjectStatistics() {
        List<ProjectDTO> projects = selectAll();
        Map<String, Integer> stats = new HashMap<>();
        // 실제로 projects 데이터를 사용해서 통계 계산
        int ongoing = 0;
        int completed = 0;

        for (ProjectDTO project : projects) {
            if ("진행중".equals(project.getStatus())) {
                ongoing++;
            } else if ("완료".equals(project.getStatus())) {
                completed++;
            }
        }
        stats.put("진행중", ongoing);
        stats.put("완료", completed);
        stats.put("전체", projects.size());
        return stats;
    }
//    @Override
//    public ProjectDTO getProjectById(int id) {
//        // 프로젝트 정보를 데이터베이스에서 조회
//        Project project = projectRepository.findById(id)
//                .orElseThrow(() -> new RuntimeException("프로젝트를 찾을 수 없습니다."));
//        // Entity를 DTO로 변환
//        ProjectDTO projectDTO = new ProjectDTO();
//        projectDTO.setId(project.getId());
//        projectDTO.setTitle(project.getTitle());
//        projectDTO.setContent(project.getContent());
//        projectDTO.setStartDate(project.getStartDate());
//        projectDTO.setEndDate(project.getEndDate());
//        // 필요한 다른 필드들도 설정
//
//        return projectDTO;
//
//    }
    @Override
    public void insert(ProjectDTO dto, ProjectUserDTO udto) {
        projectDao.insert(dto);
        projectUserDao.insert(udto);
    }


//    public void insert(ProjectDTO dto, ProjectUserDTO udto) {
//        // String departmentId = departmentDAO.selectByName("연구팀"); 부서 가져올수있는 테이블 dao에 메서드 추가하기 !
////        if (!"Team_Leader".equals(employeeDTO.getRole()) && (departmentId.equals(employeeDTO.getDepartmentId()))) {
////            throw new RuntimeException("프로젝트 생성 권한이 없습니다.");}
//// 개발팀 팀리더가 아닌 경우 생성불가 코드인데 다른테이블 dao에 메서드 생성하기 전까지 주석처리
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
    public List<ProjectDTO> selectByName(String name) {

        return  projectDao.selectByName(name);
    }




}
