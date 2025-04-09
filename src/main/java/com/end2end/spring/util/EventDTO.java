package com.end2end.spring.util;

import com.end2end.spring.commute.dto.CommuteStateDTO;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

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

    public static EventDTO of(CommuteStateDTO dto) {
        String title = "";
        if (dto.getState().equals("WORK_ON")) {
            title = "출근";
        } else if (dto.getState().equals("WORK_OFF")) {
            title = "퇴근";
        } else if (dto.getState().equals("LATE")) {
            title = "지각";
        } else if (dto.getState().equals("LEAVE_EARLY")) {
            title = "조퇴";
        } else if (dto.getState().equals("ABSENCE")) {
            title = "결석";
        } else if (dto.getState().equals("NOT_CHECK")) {
            title = "퇴근 미체크";
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
                .build();
    }
}
