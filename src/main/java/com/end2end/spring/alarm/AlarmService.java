package com.end2end.spring.alarm;

import com.end2end.spring.approval.dao.ApprovalDAO;
import com.end2end.spring.approval.dto.ApprovalDTO;
import com.end2end.spring.mail.dao.MailDAO;
import com.end2end.spring.mail.dto.EmailAddressUserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;

@Service
public class AlarmService {
    @Autowired private MailDAO mailDAO;
    @Autowired private ApprovalDAO approvalDAO;

    public void sendMailAlarm(String url, String email) {
        List<EmailAddressUserDTO> emailAddressUserList =
                mailDAO.selectEmailAddressUserByEmailAddress(email);

        for (EmailAddressUserDTO emailAddressUser : emailAddressUserList) {
            send(AlarmDTO.of(AlarmType.GET_EMAIL, emailAddressUser.getEmployeeId(), url),
                    emailAddressUser.getEmployeeId());
        }
    }

    public void sendApprovalResultAlarm(String url, String approvalId) {
        ApprovalDTO approvalDTO = approvalDAO.selectDTOById(approvalId);

        if (approvalDTO.getState().equals("SUBMIT")) {
            send(AlarmDTO.of(AlarmType.SUBMIT_APPROVAL, approvalDTO.getEmployeeId(), url),
                    approvalDTO.getEmployeeId());
        } else if (approvalDTO.getState().equals("REJECT")) {
            send(AlarmDTO.of(AlarmType.REJECT_APPROVAL, approvalDTO.getEmployeeId(), url),
                    approvalDTO.getEmployeeId());
        }
    }

    public void sendApproveCheckAlarm(String url, String employeeId) {
        send(AlarmDTO.of(AlarmType.CHECK_APPROVAL, employeeId, url), employeeId);
    }

    private void send(AlarmDTO dto, String employeeId) {
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        dto.setSendTime(timestamp);

        AlarmEndPoint.sendMessage(dto, employeeId);
    }
}
