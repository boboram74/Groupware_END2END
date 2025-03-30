package com.end2end.spring.commute.dto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@Builder
public class SolderingDTO {
    private int id;
    private String employeeId;
    private Timestamp regDate;

    public static SolderingDTO of(CommuteDTO dto) {
        return SolderingDTO.builder()
                .employeeId(dto.getEmployeeId())
                .build();
    }
}
