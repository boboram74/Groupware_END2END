package com.end2end.spring.approval.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

import java.sql.Timestamp;

@Data
@AllArgsConstructor
@Getter
@Setter
public class ApprovalFormDTO {
    private int id;
    private int approvalCtId;
    private String name;
    private String form;
    private Timestamp regDate;
}
