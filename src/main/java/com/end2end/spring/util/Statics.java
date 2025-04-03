package com.end2end.spring.util;

public class Statics {
    // 출퇴근 관리 시간 지정
    public static final String WORK_ON_CHECK_TIME = "0 1 10 * * 1-5";
    // public static final int WORK_TIME = 9 * 1000 * 60 * 60;
    public static final int WORK_TIME = 5 * 1000 * 60;

    // 파일 입출력 경로
    public static final String FILE_UPLOAD_PATH = "C:/files/";
    public static final String MAPPED_FILE_UPLOAD_PATH = "/files/";

    //페이지 유틸
    public static int recordCountPerPage = 10;
    public static int naaviCountPerPage = 10;

}
