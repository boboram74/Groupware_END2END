package com.end2end.spring.mail.serviceImpl;

import com.end2end.spring.mail.dao.MailDAO;
import com.end2end.spring.mail.dto.*;
import com.end2end.spring.mail.service.MailService;
import com.end2end.spring.util.Statics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MailServiceImpl implements MailService {

    @Autowired
    private MailDAO mailDAO;

    @Override
    public List<MailPersonalListDTO> selectByEmployeeId(String employeeId) {
        // TODO: 해당 id의 사원의 모든 메일을 출력
        return mailDAO.selectByEmployeeId(employeeId);
    }

    @Override
    public MailDetailDTO selectByEmail(String email) {
        // TODO: 해당 email에 해당하는 모든 메일을 출력
        return mailDAO.selectByEmail(email);
    }

    @Override
    public List<MailPersonalListDTO> search() {
        // TODO: 검색 결과에 따른 모든 메일 출력
        return null;
    }

    @Override
    public void insert(MailPersonalListDTO mailListDTO) {
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

    @Override
    public int getRecordTotalCount(String employeeId) {
        return mailDAO.getRecordTotalCount(employeeId);
    }

    @Override
    public int getRecordImportantTotalCount(String employeeId) {
        return mailDAO.getRecordImportantTotalCount(employeeId);
    }

    @Override
    public int getRecordSendTotalCount(String employeeId) {
        return mailDAO.getRecordSendTotalCount(employeeId);
    }

    @Override
    public int getRecordReadCount(String employeeId) {
        return mailDAO.getRecordReadCount(employeeId);
    }

    @Override
    public String selectDepartment(String employeeId) {
        return mailDAO.selectDepartment(employeeId);
    }

    @Override
    public List<MailTeamListDTO> selectFromto(int start, int end, String employeeId) {
        return mailDAO.selectFromto(start, end, employeeId);
    }

    @Override
    public List<MailTeamListDTO> selectFromtoImportant(int start, int end, String employeeId) {
        return mailDAO.selectFromtoImportant(start, end, employeeId);
    }

    @Override
    public List<SendMailListDTO> selectFromtoSendList(int start, int end, String employeeId) {
        return mailDAO.selectFromtoSendList(start, end, employeeId);
    }

    @Override
    public int insertReadYn(int esId) {
        return mailDAO.insertReadYn(esId);
    }

    @Override
    public int updateImportant(ImportYnDTO dto) {
        return mailDAO.updateImportant(dto);
    }

    @Override
    public int insertReadYnAll(List<Integer> esids) {
        int totalUpdated = 0;
        for (Integer esid : esids) {
            totalUpdated += mailDAO.insertReadYn(esid);
            System.out.println("읽음표시 : " + esid);
        }
        return totalUpdated;
    }

    @Override
    public int trashAll(List<Integer> esids) {
        int totalUpdated = 0;
        for (Integer esid : esids) {
            totalUpdated += mailDAO.insertTrashCan(esid);
            System.out.println("휴지통 : " + esid);
        }
        return totalUpdated;
    }

    @Override
    public Map<String, Object> getPageList(int cpage, String employeeId, String action) {

        int recordReadCount = this.getRecordReadCount(employeeId);
        Map<String, Object> result = new HashMap<>();

        if (action.equals("listAll")) {
            int recordTotalCount = this.getRecordTotalCount(employeeId);
            int pageTotalCount = (recordTotalCount % Statics.recordCountPerPage > 0)
                    ? recordTotalCount / Statics.recordCountPerPage + 1
                    : recordTotalCount / Statics.recordCountPerPage;
            if (cpage < 1) cpage = 1;
            else if (cpage > pageTotalCount) cpage = pageTotalCount;
            int end = cpage * Statics.recordCountPerPage;
            int start = end - (Statics.recordCountPerPage - 1);
            int startNavi = (cpage - 1) / Statics.naaviCountPerPage * Statics.naaviCountPerPage + 1;
            int endNavi = startNavi + Statics.naaviCountPerPage - 1;
            if (endNavi > pageTotalCount) endNavi = pageTotalCount;
            boolean needPrev = startNavi != 1;
            boolean needNext = endNavi != pageTotalCount;
            List<MailTeamListDTO> teamMail = this.selectFromto(start, end, employeeId);
            result.put("list", teamMail);
            result.put("startNavi", startNavi);
            result.put("endNavi", endNavi);
            result.put("needPrev", needPrev);
            result.put("needNext", needNext);
            result.put("recordTotalCount",recordTotalCount);
            result.put("recordReadCount",recordReadCount);
        } else if (action.equals("important")) {
            int recordTotalCount = this.getRecordImportantTotalCount(employeeId);
            int pageTotalCount = (recordTotalCount % Statics.recordCountPerPage > 0)
                    ? recordTotalCount / Statics.recordCountPerPage + 1
                    : recordTotalCount / Statics.recordCountPerPage;
            if (cpage < 1) cpage = 1;
            else if (cpage > pageTotalCount) cpage = pageTotalCount;
            int end = cpage * Statics.recordCountPerPage;
            int start = end - (Statics.recordCountPerPage - 1);
            int startNavi = (cpage - 1) / Statics.naaviCountPerPage * Statics.naaviCountPerPage + 1;
            int endNavi = startNavi + Statics.naaviCountPerPage - 1;
            if (endNavi > pageTotalCount) endNavi = pageTotalCount;
            boolean needPrev = startNavi != 1;
            boolean needNext = endNavi != pageTotalCount;
            List<MailTeamListDTO> teamMail = this.selectFromtoImportant(start, end, employeeId);
            result.put("list", teamMail);
            result.put("startNavi", startNavi);
            result.put("endNavi", endNavi);
            result.put("needPrev", needPrev);
            result.put("needNext", needNext);
            result.put("recordTotalCount",recordTotalCount);
            result.put("recordReadCount",recordReadCount);
        } else if (action.equals("sendList")) {
            int recordTotalCount = this.getRecordSendTotalCount(employeeId);
            int pageTotalCount = (recordTotalCount % Statics.recordCountPerPage > 0)
                    ? recordTotalCount / Statics.recordCountPerPage + 1
                    : recordTotalCount / Statics.recordCountPerPage;
            if (cpage < 1) cpage = 1;
            else if (cpage > pageTotalCount) cpage = pageTotalCount;
            int end = cpage * Statics.recordCountPerPage;
            int start = end - (Statics.recordCountPerPage - 1);
            int startNavi = (cpage - 1) / Statics.naaviCountPerPage * Statics.naaviCountPerPage + 1;
            int endNavi = startNavi + Statics.naaviCountPerPage - 1;
            if (endNavi > pageTotalCount) endNavi = pageTotalCount;
            boolean needPrev = startNavi != 1;
            boolean needNext = endNavi != pageTotalCount;
            List<SendMailListDTO> teamMail = this.selectFromtoSendList(start, end, employeeId);
            for (SendMailListDTO dto : teamMail) {
                System.out.println("ID: " + dto.getId());
                System.out.println("File Count: " + dto.getFileCount());
                System.out.println("Recipient Email Address: " + dto.getRecipientemailaddress());
                System.out.println("Title: " + dto.getTitle());
                System.out.println("Regdate: " + dto.getRegdate());
                System.out.println("------------------------");
            }
            result.put("list", teamMail);
            result.put("startNavi", startNavi);
            result.put("endNavi", endNavi);
            result.put("needPrev", needPrev);
            result.put("needNext", needNext);
            result.put("recordTotalCount",recordTotalCount);
            result.put("recordReadCount",recordReadCount);
        }
        return result;
    }
}
