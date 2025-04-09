package com.end2end.spring.commute.scheduler;

import com.end2end.spring.commute.service.SolderingService;
import com.end2end.spring.util.HolidayUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.time.LocalDate;

@Component
public class CommuteScheduler {
    @Autowired private SolderingService solderingService;

    @Scheduled(cron="0 59 23 * * 1-5")
    public void insertSoldering() throws IOException {
        if (HolidayUtil.isHoliday(LocalDate.now())) {
            return;
        }

        solderingService.insertByState("ABSENCE");
        solderingService.insertNotCheck();
    }
}
