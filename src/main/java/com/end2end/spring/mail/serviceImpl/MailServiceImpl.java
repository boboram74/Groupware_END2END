package com.end2end.spring.mail.serviceImpl;

import com.end2end.spring.alarm.AlarmService;
import com.end2end.spring.mail.dao.MailDAO;
import com.end2end.spring.mail.dto.*;
import com.end2end.spring.mail.service.MailService;
import com.end2end.spring.util.Statics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MailServiceImpl implements MailService {

    @Autowired
    private MailDAO mailDAO;
    @Autowired private AlarmService alarmService;

    @Transactional
    @Override
    public List<MailPersonalListDTO> selectByEmployeeId(String employeeId) {
        return mailDAO.selectByEmployeeId(employeeId);
    }

    @Transactional
    @Override
    public MailDetailDTO selectByEmail(String email) {
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

    @Transactional
    @Override
    public int getRecordTotalCount(String employeeId) {
        return mailDAO.getRecordTotalCount(employeeId);
    }

    @Transactional
    @Override
    public int getRecordImportantTotalCount(String employeeId) {
        return mailDAO.getRecordImportantTotalCount(employeeId);
    }

    @Transactional
    @Override
    public int getRecordSendTotalCount(String employeeId) {
        return mailDAO.getRecordSendTotalCount(employeeId);
    }

    @Transactional
    @Override
    public int getRecordReadCount(String employeeId) {
        return mailDAO.getRecordReadCount(employeeId);
    }

    @Transactional
    @Override
    public int getRecordReceiveReadCount(String employeeId) {
        return mailDAO.getRecordReceiveReadCount(employeeId);
    }

    @Transactional
    @Override
    public int getRecordReceiveCount(String employeeId) {
        return mailDAO.getRecordReceiveCount(employeeId);
    }

    @Transactional
    @Override
    public int getRecordTrashCount(String employeeId) {
        return mailDAO.getRecordTrashCount(employeeId);
    }

    @Transactional
    @Override
    public String selectDepartment(String employeeId) {
        return mailDAO.selectDepartment(employeeId);
    }

    @Transactional
    @Override
    public List<MailListDTO> selectFromto(int start, int end, String employeeId) {
        return mailDAO.selectFromto(start, end, employeeId);
    }

    @Transactional
    @Override
    public List<MailListDTO> selectFromtoImportant(int start, int end, String employeeId) {
        return mailDAO.selectFromtoImportant(start, end, employeeId);
    }

    @Transactional
    @Override
    public List<SendMailListDTO> selectFromtoSendList(int start, int end, String employeeId) {
        return mailDAO.selectFromtoSendList(start, end, employeeId);
    }

    @Transactional
    @Override
    public List<MailListDTO> selectFromtoReceiveList(int start, int end, String employeeId) {
        return mailDAO.selectFromtoReceiveList(start, end, employeeId);
    }

    @Transactional
    @Override
    public List<MailListDTO> selectFromtoTrashList(int start, int end, String employeeId) {
        return mailDAO.selectFromtoTrashList(start, end, employeeId);
    }

    @Transactional
    @Override
    public int insertReadYn(int esId) {
        return mailDAO.insertReadYn(esId);
    }

    @Transactional
    @Override
    public int updateImportant(ImportYnDTO dto) {
        return mailDAO.updateImportant(dto);
    }

    @Transactional
    @Override
    public int insertReadYnAll(List<Integer> esids) {
        int totalUpdated = 0;
        for (Integer esid : esids) {
            totalUpdated += mailDAO.insertReadYn(esid);
        }
        return totalUpdated;
    }

    @Transactional
    @Override
    public int trashAll(List<Integer> esids) {
        int totalUpdated = 0;
        for (Integer esid : esids) {
            totalUpdated += mailDAO.insertTrashCan(esid);
        }
        return totalUpdated;
    }

    @Transactional
    @Override
    public int deleteAll(List<Integer> esids) {
        int totalUpdated = 0;
        for (Integer esid : esids) {
            totalUpdated += mailDAO.insertDelete(esid);
        }
        return totalUpdated;
    }

    @Transactional
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
            List<MailListDTO> teamMail = this.selectFromto(start, end, employeeId);
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
            List<MailListDTO> teamMail = this.selectFromtoImportant(start, end, employeeId);
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
            result.put("list", teamMail);
            result.put("startNavi", startNavi);
            result.put("endNavi", endNavi);
            result.put("needPrev", needPrev);
            result.put("needNext", needNext);
            result.put("recordTotalCount",recordTotalCount);
            result.put("recordReadCount",recordReadCount);
        } else if (action.equals("receiveList")) {
            int recordTotalCount = this.getRecordReceiveCount(employeeId);
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
            List<MailListDTO> teamMail = this.selectFromtoReceiveList(start, end, employeeId);
            result.put("list", teamMail);
            result.put("startNavi", startNavi);
            result.put("endNavi", endNavi);
            result.put("needPrev", needPrev);
            result.put("needNext", needNext);
            result.put("recordTotalCount",recordTotalCount);
            result.put("recordReadCount",recordReadCount);
        } else if(action.equals("trashList")) {
            int recordTotalCount = this.getRecordTrashCount(employeeId);
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
            List<MailListDTO> teamMail = this.selectFromtoTrashList(start, end, employeeId);
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

    @Override
    public void sendMailAlarm(int mailId, String email) {
        MailURLDTO mailURLDTO = mailDAO.selectMailURLById(mailId);

        String url = String.format("/mail/%d/%d", mailURLDTO.getId(), mailURLDTO.getEmailStateId());

        List<EmailAddressUserDTO> emailAddressUserDTOList =
                mailDAO.selectEmailAddressUserByEmailAddress(email);

        for(EmailAddressUserDTO emailAddressUserDTO : emailAddressUserDTOList) {
            String employeeId = emailAddressUserDTO.getEmployeeId();
            alarmService.sendMailAlarm(url, employeeId);
        }
    }
}
