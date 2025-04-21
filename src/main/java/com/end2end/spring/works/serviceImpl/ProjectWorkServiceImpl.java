package com.end2end.spring.works.serviceImpl;

import com.end2end.spring.alarm.AlarmService;
import com.end2end.spring.alarm.AlarmType;
import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.service.FileService;
import com.end2end.spring.works.dao.ProjectDAO;
import com.end2end.spring.works.dao.ProjectWorkDAO;
import com.end2end.spring.works.dto.ProjectUserDTO;
import com.end2end.spring.works.dto.ProjectWorkDTO;
import com.end2end.spring.works.service.ProjectWorkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

@Service
public class ProjectWorkServiceImpl implements ProjectWorkService {
    @Autowired
    ProjectWorkDAO dao;
    @Autowired
    ProjectDAO pdao;
    @Autowired
    FileService fileService;
    @Autowired
    private AlarmService alarmService;

    @Override
    public List<ProjectWorkDTO> selectAll(int id) {
        return dao.selectAll(id)  ;
    }

    @Override
    public List<ProjectWorkDTO> selectAll() {
        return dao.selectAll()  ;
    }
    @Override
    public void insert(MultipartFile[] files, ProjectWorkDTO dto) throws Exception {
       //게시물 등록
        dao.insert(dto);

        int projectWorkId = dto.getId();
        FileDTO fileDTO = FileDTO.builder()
                .projectWorkId(projectWorkId)
                .build();
        fileService.insert(files, fileDTO);

        alarmService.sendProjectAlarm(
                AlarmType.PROJECT_WORK_CREATE, "/project/detail/" + dto.getProjectId(), dto.getProjectId());
    }

    @Override
    public ProjectUserDTO selectByProjectIdAndEmployeeId(int projectId, String employeeId) {
        //게시물 등록

       return dao.selectByProjectIdAndEmployeeId(projectId,employeeId);

    }
    @Override
    public ProjectWorkDTO selectByworksId(int id){

        return dao.selectByworksId(id);
    }
    @Override
    public ProjectWorkDTO update(ProjectWorkDTO dto) {

        dao.update(dto);

        alarmService.sendProjectAlarm(
                AlarmType.PROJECT_WORK_UPDATE, "/project/detail/" + dto.getProjectId(), dto.getProjectId());

        return dto;
    }

    @Override
    public  int getChartDataCount(int selectedId){
        int total = dao.countTotalWorks(selectedId);
        int finished = dao.countFinishedWorks(selectedId);
//        System.out.println(total);
//        System.out.println(finished);
        if (total == 0) return 0; // 나눗셈 방지
        return (int) Math.round((finished * 100.0) / total);
    }
    @Override
    public int countByState(int selectedId, String state){
        return dao.countByState(selectedId,state);
    }
    @Override
    public int countByType(int selectedId, String type){
        return dao.countByType(selectedId,type);
    }

@Override
public List<ProjectWorkDTO> searchBynameAndTitle(String keyword, int projectId, String searchOption) {
        return dao.searchBynameAndTitle(keyword, projectId,searchOption);
}

//    @Override
//    public void update(MultipartFile[]files,ProjectWorkDTO dto) throws Exception {
//        dao.update(dto);
//        int projectWorkId = dto.getProjectId();
//        FileDTO fileDTO = FileDTO.builder()
//                .projectWorkId(projectWorkId)
//                .build();
//        fileService.insert(files, fileDTO);
//
//    }

@Override
public void endworks(int projectId){
        pdao.endworks(projectId);
}

    @Override
    public int updateState(String state, int workItemId, int projectId) {
        dao.updateState(state,workItemId);
        int total = dao.countTotalWorksByProjectId(projectId);
        int finished = dao.countFinishWorksByProjectId(projectId);

        int result = (total == finished) ? 0 : 1;

        if(result == 0) {
            alarmService.sendProjectCompleteAlarm(projectId);
        } else {
            alarmService.sendProjectWorkStateChangeAlarm(workItemId);
        }

        // 4. 모두 FINISH 상태면 0, 아니면 1 반환
        return result;
    }

    @Override
    public void deleteById(int workId) {

//        System.out.println("서비스 도착"+workId);
    dao.deleteById(workId);
    }

    @Override
    public void toggleState(int id) {
        // select * from POJECT_WORK WHERE id = ${id} => state값 추출

        // String changeValue = (state.eqauls("ON_GOING") ?  "FINISH" : "ON_GOING"
        // update PROJECT_WORK set state = #{state} where id = ${id}

        //아니면 값으로 string state 를 받는 방법도 있음
    }
}
