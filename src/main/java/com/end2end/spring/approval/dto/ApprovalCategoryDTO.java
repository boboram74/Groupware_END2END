package com.end2end.spring.approval.dto;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Data
@AllArgsConstructor
@Getter
@Setter
public class ApprovalCategoryDTO {
    private int id;
    private String name;
}
