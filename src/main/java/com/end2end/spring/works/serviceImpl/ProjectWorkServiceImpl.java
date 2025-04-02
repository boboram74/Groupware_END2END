package com.end2end.spring.works.serviceImpl;

import com.end2end.spring.board.dto.BoardCategoryDTO;
import com.end2end.spring.works.dto.ProjectWorkDTO;
import com.end2end.spring.works.service.ProjectWorkService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ProjectWorkServiceImpl implements ProjectWorkService {


    @Override
    public List<ProjectWorkDTO> selectAll() {
        return null;
    }

    @Override
    public List<ProjectWorkDTO> selectByEmployeeId(String employeeId) {
        return null;
    }

    @Override
    public void insert(ProjectWorkDTO dto) {

    }

    @Override
    public void update(ProjectWorkDTO dto) {

    }

    @Override
    public void deleteById(int id) {

    }

    @Override
    public void toggleState(int id) {
        // select * from POJECT_WORK WHERE id = ${id} => state값 추출

        // String changeValue = (state.eqauls("ON_GOING") ?  "FINISH" : "ON_GOING"
        // update PROJECT_WORK set state = #{state} where id = ${id}

        //아니면 값으로 string state 를 받는 방법도 있음
    }
}
