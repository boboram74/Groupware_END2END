package com.end2end.spring.works.serviceImpl;

import com.end2end.spring.file.dto.FileDTO;
import com.end2end.spring.file.service.FileService;
import com.end2end.spring.works.dao.ProjectWorkDAO;
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
    FileService fileService;

    @Override
    public List<ProjectWorkDTO> selectAll(int id) {
        return dao.selectAll(id)  ;
    }


    @Override
    public void insert(MultipartFile[] files, ProjectWorkDTO dto) throws Exception {
       //게시물 등록
        dao.insert(dto);

        int projectWorkId = dto.getProjectId();
        FileDTO fileDTO = FileDTO.builder()
                .projectWorkId(projectWorkId)
                .build();
        fileService.insert(files, fileDTO);
    }

    @Override
    public String selectByProjectIdAndEmployeeId(int projectId, String employeeId) {
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

        return dto;
    }

    @Override
    public   int getChartDataCount(int id){
        int total = dao.countTotalWorks(id);
        int finished = dao.countFinishedWorks(id);
        if (total == 0) return 0; // 나눗셈 방지
        return (int) Math.round((finished * 100.0) / total);
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
    public void updateState(String state, int workItemId) {
        dao.updateState(state,workItemId);
    }

    @Override
    public void deleteById(int workId) {

        System.out.println("서비스 도착"+workId);
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
