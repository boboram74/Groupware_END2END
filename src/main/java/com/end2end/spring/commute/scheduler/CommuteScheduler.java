package com.end2end.spring.commute.scheduler;

import com.end2end.spring.commute.dao.SolderingDAO;
import com.end2end.spring.commute.service.CommuteService;
import com.end2end.spring.commute.service.SolderingService;
import com.end2end.spring.util.Statics;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.time.LocalDateTime;

@Component
public class CommuteScheduler {
    @Autowired private SolderingService solderingService;

    @Scheduled(cron="0 59 23 * * 1-5")
    public void insertSoldering() {
        solderingService.insertByState("ABSENCE");
        solderingService.insertNotCheck();
    }
}
