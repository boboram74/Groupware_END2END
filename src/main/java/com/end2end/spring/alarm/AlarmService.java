package com.end2end.spring.alarm;

import com.end2end.spring.approval.dao.ApprovalDAO;
import com.end2end.spring.approval.dto.ApprovalDTO;
import com.end2end.spring.board.dao.BoardDAO;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.mail.dao.MailDAO;
import com.end2end.spring.mail.dto.MailURLDTO;
import com.end2end.spring.schedule.dao.CalendarUserDAO;
import com.end2end.spring.schedule.dao.ScheduleDAO;
import com.end2end.spring.schedule.dto.CalendarDTO;
import com.end2end.spring.schedule.dto.CalendarUserDTO;
import com.end2end.spring.works.dao.ProjectUserDAO;
import com.end2end.spring.works.dao.ProjectWorkDAO;
import com.end2end.spring.works.dto.ProjectWorkDTO;
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
    @Autowired private CalendarUserDAO calendarUserDAO;
    @Autowired private ScheduleDAO scheduleDAO;
    @Autowired private BoardDAO boardDAO;

    public void sendNewLoginIpAlarm(String employeeId) {
        send(AlarmDTO.of(AlarmType.LOGIN, employeeId, "/login/history/1"), employeeId);
    }

    public void sendMailAlarm(int emailId) {
        List<MailURLDTO> mailURLDTO = mailDAO.selectMailURLById(emailId);

        for(MailURLDTO dto : mailURLDTO) {
            String url = String.format("/mail/%d/%d", dto.getId(), dto.getEmailStateId());
            send(AlarmDTO.of(AlarmType.GET_EMAIL, dto.getEmployeeId(), url), dto.getEmployeeId());
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

    public void sendProjectAlarm(AlarmType alarmType, String url, int projectId) {
        List<EmployeeDTO> projectUserList = projectUserDAO.selectByprojectId(projectId);

        for (EmployeeDTO employeeDTO : projectUserList) {
            send(AlarmDTO.of(alarmType, employeeDTO.getId(), url), employeeDTO.getId());
        }
    }

    public void sendProjectWorkStateChangeAlarm(int projectWorkId) {
        ProjectWorkDTO projectWorkDTO = projectWorkDAO.selectByworksId(projectWorkId);

        AlarmType alarmType = null;
        if (projectWorkDTO.getState().equals("ONGOING")) {
            alarmType = AlarmType.PROJECT_WORK_ONGOING;
        } else if (projectWorkDTO.getState().equals("FINISH")) {
            alarmType = AlarmType.PROJECT_WORK_FINISH;
        } else {
            return;
        }

        List<EmployeeDTO> projectUserList = projectUserDAO.selectByprojectId(projectWorkDTO.getProjectId());

        for (EmployeeDTO employeeDTO : projectUserList) {
            send(AlarmDTO.of(alarmType, employeeDTO.getId(), "/project/detail/" + projectWorkDTO.getProjectId()),
                    employeeDTO.getId());
        }
    }

    public void sendCalendarCreateAlarm(int calendarId) {
        List<CalendarUserDTO> calendarUserList = calendarUserDAO.selectByCalendarId(calendarId);

        for (CalendarUserDTO calendarUserDTO : calendarUserList) {
            String employeeId = calendarUserDTO.getEmployeeId();
            send(AlarmDTO.of(AlarmType.CALENDAR_CREATE, employeeId, "/calendar/list"), employeeId);
        }
    }

    public void sendCalendarUpdateStateAlarm(AlarmType alarmType, String employeeId) {
        send(AlarmDTO.of(alarmType, employeeId, "/calendar/list"), employeeId);
    }

    public void sendScheduleAlarm(int calendarId) {
        List<CalendarUserDTO> calendarUserDTOList = calendarUserDAO.selectByCalendarId(calendarId);

        for (CalendarUserDTO calendarUserDTO : calendarUserDTOList) {
            String employeeId = calendarUserDTO.getEmployeeId();
            send(AlarmDTO.of(AlarmType.SCHEDULE_CREATE, employeeId, "/schedule/list"), employeeId);
        }
    }

    public void sendAddReplyAlarm(int boardId) {
        String employeeId = boardDAO.selectById(boardId).getEmployeeId();
        send(AlarmDTO.of(AlarmType.GET_REPLY, employeeId, "/board/detail/" + boardId), employeeId);
    }

    private void send(AlarmDTO dto, String employeeId) {
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        dto.setSendTime(timestamp);

        AlarmEndPoint.sendMessage(dto, employeeId);
    }
}
