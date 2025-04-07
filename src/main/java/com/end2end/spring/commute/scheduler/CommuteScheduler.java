package com.end2end.spring.commute.scheduler;

import com.end2end.spring.commute.dao.SolderingDAO;
import com.end2end.spring.commute.service.CommuteService;
import com.end2end.spring.util.Statics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
public class CommuteScheduler {
    @Autowired private SolderingDAO solderingDAO;

    @Scheduled(cron="0 0 10 * * 1-5")
    public void insertLate() {
        // TODO: 지각자 체크
        solderingDAO.selectByState("LATE");
    }

    @Scheduled(cron="0 59 23 * * 1-5")
    public void insertAbsence() {
        // TODO: 연장 근무를 포함한 전인원 퇴근 체크
        solderingDAO.selectByState("ABSENCE");
    }
}
