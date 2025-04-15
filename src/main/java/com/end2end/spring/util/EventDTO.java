package com.end2end.spring.util;

import com.end2end.spring.commute.dto.CommuteStateDTO;
import com.end2end.spring.commute.dto.VacationDTO;
import com.end2end.spring.schedule.dto.ScheduleDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class EventDTO {
    private String title;
    private String startDate;
    private String endDate;
    private boolean allDay;
    private String display;
    private String backgroundColor;
    private String eventName;

    public static EventDTO convertFromCommuteState(CommuteStateDTO dto) {
        String title = "";
        String backgroundColor = "";

        if (dto.getState().equals("WORK_ON")) {
            title = "출근 " + dto.getRegDate().toLocalDateTime().format(DateTimeFormatter.ofPattern("HH:mm:ss"));
            backgroundColor = "black";
        } else if (dto.getState().equals("WORK_OFF")) {
            title = "퇴근 " + dto.getRegDate().toLocalDateTime().format(DateTimeFormatter.ofPattern("HH:mm:ss"));
            backgroundColor = "black";
        } else if (dto.getState().equals("LATE")) {
            title = "지각";
            backgroundColor = "blue";
        } else if (dto.getState().equals("LEAVE_EARLY")) {
            title = "조퇴";
            backgroundColor = "blue";
        } else if (dto.getState().equals("ABSENCE")) {
            title = "결석";
            backgroundColor = "blue";
        } else if (dto.getState().equals("NOT_CHECK")) {
            title = "퇴근 미체크";
            backgroundColor = "blue";
        }

        String parseStartDate = dto
                .getRegDate()
                .toInstant()
                .toString();

        return EventDTO.builder()
                .title(title)
                .startDate(parseStartDate)
                .allDay(true)
                .display("block")
                .backgroundColor(backgroundColor)
                .eventName("dot")
                .build();
    }

    public static EventDTO convertFromHoliday(HolidayUtil.HolidayDTO dto) {
        String newDate = LocalDate.parse(dto.getDate(), DateTimeFormatter.ofPattern("yyyyMMdd"))
                .atStartOfDay()  // 시작 시간을 00:00:00으로 설정
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

        return EventDTO.builder()
                .title(dto.getDateName())
                .startDate(Timestamp.valueOf(newDate).toInstant().toString())
                .allDay(true)
                .display("block")
                .backgroundColor("red")
                .build();
    }

    public static EventDTO convertFromVacation(VacationDTO dto, LocalDate startDate, LocalDate endDate) {
        LocalDate srateDateToLocalDate = dto.getStartDate().toLocalDateTime().toLocalDate();
        LocalDate endDateToLocalDate = dto.getEndDate().toLocalDateTime().toLocalDate();

        String startDateStr = (!srateDateToLocalDate.isBefore(startDate)) ?
                dto.getStartDate().toInstant().toString() : startDate.toString();
        String endDateStr = (!endDateToLocalDate.isAfter(endDate)) ?
                dto.getEndDate().toInstant().toString() : endDate.toString();

        String type = "";
        if (dto.getType().equals("HALF")) {
            type = "반차";
        } else if (dto.getType().equals("ANNUAL")) {
            type = "연차";
        } else if (dto.getType().equals("SICK")) {
            type = "병가";
        } else if (dto.getType().equals("EARLY")) {
            type = "조퇴";
        }

        String title = type + " : " + dto.getReason()
                + "(" + dto.getStartDate().toInstant().toString() + " ~ " + dto.getEndDate().toInstant().toString() + ")";

        return EventDTO.builder()
                .title(title)
                .startDate(startDateStr)
                .endDate(endDateStr)
                .display("block")
                .eventName("period")
                .build();
    }

    public static EventDTO convertFromSchedule(ScheduleDTO dto, LocalDate startDate, LocalDate endDate) {
        LocalDate srateDateToLocalDate = dto.getStartDate().toLocalDateTime().toLocalDate();
        LocalDate endDateToLocalDate = dto.getEndDate().toLocalDateTime().toLocalDate();

        String startDateStr = (!srateDateToLocalDate.isBefore(startDate)) ?
                dto.getStartDate().toInstant().toString() : startDate.toString();
        String endDateStr = (!endDateToLocalDate.isAfter(endDate)) ?
                dto.getEndDate().toInstant().toString() : endDate.toString();

        return EventDTO.builder()
                .title(dto.getTitle())
                .startDate(startDateStr)
                .endDate(endDateStr)
                .display("block")
                .eventName("period")
                .build();
    }
}
