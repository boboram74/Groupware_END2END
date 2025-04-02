package com.end2end.spring.works.dto;

import java.security.Timestamp;

public class ProjectWorkReply {

    private int id;
private int projectWorkId;
private int projectUserId;
private String content;
private Timestamp regDate;


    public ProjectWorkReply(){}

    public ProjectWorkReply(int id, int projectWorkId, int projectUserId, String content, Timestamp regDate) {
        this.id = id;
        this.projectWorkId = projectWorkId;
        this.projectUserId = projectUserId;
        this.content = content;
        this.regDate = regDate;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getProjectWorkId() {
        return projectWorkId;
    }

    public void setProjectWorkId(int projectWorkId) {
        this.projectWorkId = projectWorkId;
    }

    public int getProjectUserId() {
        return projectUserId;
    }

    public void setProjectUserId(int projectUserId) {
        this.projectUserId = projectUserId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getRegDate() {
        return regDate;
    }

    public void setRegDate(Timestamp regDate) {
        this.regDate = regDate;
    }
}
