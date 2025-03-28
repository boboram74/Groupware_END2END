package com.end2end.spring.mail.serviceImpl;

import com.end2end.spring.mail.dto.MailDTO;
import com.end2end.spring.mail.service.MailService;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MailServiceImpl implements MailService {
    @Override
    public List<MailDTO> selectByEmployeeId(String employeeId) {
        // TODO: 해당 id의 사원의 모든 메일을 출력
        return null;
    }

    @Override
    public List<MailDTO> selectByEmail() {
        // TODO: 해당 email에 해당하는 모든 메일을 출력
        return null;
    }

    @Override
    public List<MailDTO> search() {
        // TODO: 검색 결과에 따른 모든 메일 출력
        return null;
    }

    @Override
    public void insert(MailDTO mailDTO) {
        // TODO: 메일 송신
    }

    @Override
    public void deleteById(int id) {
        // TODO: 해당 id의 메일 삭제
    }

    @Override
    public void toggleTrashYN(int id, boolean isInTrashCan) {
        // TODO: 해당 메일의 휴지통에 넣기/빼기
    }
}
