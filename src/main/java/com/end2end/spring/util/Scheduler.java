package com.end2end.spring.util;

import com.end2end.spring.alarm.AlarmService;
import com.end2end.spring.alarm.AlarmType;
import com.end2end.spring.commute.service.SolderingService;
import com.end2end.spring.commute.service.VacationService;
import com.end2end.spring.employee.dto.EmployeeDTO;
import com.end2end.spring.works.dto.ProjectSelectDTO;
import com.end2end.spring.works.service.ProjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.time.LocalDate;
import java.util.List;

@Component
public class Scheduler {
    @Autowired private SolderingService solderingService;
    @Autowired private VacationService vacationService;
    @Autowired private ProjectService projectService;
    @Autowired private AlarmService alarmService;

    @Scheduled(cron="0 59 23 * * 1-5")
    public void insertSoldering() throws IOException {
        if (HolidayUtil.isHoliday(LocalDate.now())) {
            return;
        }

        solderingService.insertByState("ABSENCE");
        solderingService.insertNotCheck();
    }

    @Scheduled(cron= "0 0 10 * * ?")
    public void vacationInsert() throws Exception {
        vacationService.insertUsableVacationHired1st();
        vacationService.insertUsableVacation();
    }

    @Scheduled(cron="0 36 18 * * ?")
    public void sendDeadLineAlarm() {
        List<ProjectSelectDTO> projectDTOList = projectService.selectAllProject();

        for (ProjectSelectDTO projectDTO : projectDTOList) {
            if (projectDTO.getNearDeadline().equals("Y") && projectDTO.getHideYn().equals("N")) {
                alarmService.sendProjectAlarm(AlarmType.PROJECT_DEADLINE,
                        "/project/detail/" + projectDTO.getId(), projectDTO.getId());
            }
        }
    }
}
