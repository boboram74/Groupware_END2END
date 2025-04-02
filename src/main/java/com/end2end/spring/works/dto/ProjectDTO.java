package com.end2end.spring.works.dto;

import java.security.Timestamp;

public class ProjectDTO {

    private int id;
    private String name;
    private String hideYn;
    private Timestamp regDate;

    public ProjectDTO() {}

    public ProjectDTO(int id, String name, String hideYn, Timestamp regDate) {
        this.id = id;
        this.name = name;
        this.hideYn = hideYn;
        this.regDate = regDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getHideYn() {
        return hideYn;
    }

    public void setHideYn(String hideYn) {
        this.hideYn = hideYn;
    }

    public Timestamp getRegDate() {
        return regDate;
    }

    public void setRegDate(Timestamp regDate) {
        this.regDate = regDate;
    }
}
