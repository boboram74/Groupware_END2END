package com.end2end.spring.commute.scheduler;

import com.end2end.spring.util.Statics;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

@Component
public class CommuteScheduler {
    @Scheduled(cron= Statics.WORK_ON_CHECK_TIME)
    public void workOnCheck() {
        // TODO: 지정한 시간에 자동으로 출근 체크
        System.out.println("출근 체크!!");
    }

    @Scheduled(cron=Statics.WORK_OFF_CHECK_TIME)
    public void workOffCheck() {
        // TODO: 지정한 시간에 자동으로 퇴근 체크
        System.out.println("퇴근 체크!!");
    }

    @Scheduled(cron="0 0 0 * * 1-5")
    public void workOffCheckFinal() {
        // TODO: 연장 근무를 포함한 전인원 퇴근 체크
        System.out.println("찐막 퇴근 체크!!!");
    }
}
