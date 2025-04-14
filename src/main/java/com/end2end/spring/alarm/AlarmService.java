package com.end2end.spring.alarm;

import com.end2end.spring.approval.dao.ApprovalDAO;
import com.end2end.spring.approval.dto.ApprovalDTO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.mail.dao.MailDAO;
import com.end2end.spring.mail.dto.EmailAddressUserDTO;
import com.end2end.spring.works.dao.ProjectDAO;
import com.end2end.spring.works.dao.ProjectUserDAO;
import com.end2end.spring.works.dao.ProjectWorkDAO;
import com.end2end.spring.works.dto.ProjectUserDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.List;

@Service
public class AlarmService {
    @Autowired private MailDAO mailDAO;
    @Autowired private ApprovalDAO approvalDAO;
    @Autowired private ProjectWorkDAO projectWorkDAO;
    @Autowired private ProjectUserDAO projectUserDAO;

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
    public void sendProjectAlarm(AlarmType alarmType, String url, int projectId) {
        List<EmployeeDTO> projectUserList = projectUserDAO.selectByprojectId(projectId);

        for (EmployeeDTO employeeDTO : projectUserList) {
            send(AlarmDTO.of(alarmType, employeeDTO.getId(), url), employeeDTO.getId());
        }
    }

    public void sendApproveCheckAlarm(String url, String employeeId) {
        send(AlarmDTO.of(AlarmType.CHECK_APPROVAL, employeeId, url), employeeId);
    }

    public void sendProjectEmergencyCheck(String url, String projectId) {
        //List<ProjectUserDTO> projectUserList = projectDAO.
    }

    private void send(AlarmDTO dto, String employeeId) {
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        dto.setSendTime(timestamp);

        AlarmEndPoint.sendMessage(dto, employeeId);
    }
}
