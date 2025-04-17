<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--<jsp:include page="/WEB-INF/views/template/header.jsp"/>--%>
<html lang="ko">
<head>
    <link rel="stylesheet" href="/css/hr/write.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>사원 등록</title>
</head>
<body>
<div class="mainContainer">
    <div class="card">
        <div class="card-header">
            <h2><span class="material-icons">group_add</span>사원 등록</h2>
        </div>
        <div class="card-body">
            <form action="/hr/insert" method="post" enctype="multipart/form-data" id="form">
                <div class="form-grid">
                    <div class="profile-upload">
                        <label for="profileInput">
                            <img id="profilePreview" src="/image/defaultImg.jpg" alt="프로필 이미지">
                            <span class="material-icons">add_a_photo</span>
                        </label>
                        <input type="file" id="profileInput" name="file" accept="image/*" hidden>
                        <input type="hidden" name="profileImg" value="/image/defaultImg.jpg"/>
                    </div>
                    <div class="form-group">
                        <label>이름</label>
                        <input type="text" name="name" placeholder="이름을 입력하세요">
                    </div>
                    <div class="form-group">
                        <label>생년월일</label>
                        <input type="date" name="birthday">
                    </div>
                    <div class="form-group">
                        <label>아이디</label>
                        <div class="input-with-btn">
                            <input type="text" id="id" name="loginId"
                                   placeholder="6~20자 영문 소문자·숫자 조합">
                            <button type="button" id="idCheckBtn">중복 체크</button>
                        </div>
                        <div id="resultId" class="validation-msg"></div>
                    </div>
                    <div class="form-group">
                        <label>패스워드</label>
                        <input type="password" name="password"
                               placeholder="8자 이상 영문 소문자·숫자 조합">
                        <div id="resultPw" class="validation-msg"></div>
                    </div>
                    <div class="form-group">
                        <label>패스워드 확인</label>
                        <input type="password" placeholder="위와 동일하게 입력">
                        <div id="resultRePw" class="validation-msg"></div>
                    </div>
                    <div class="form-group">
                        <label>직급</label>
                        <select name="jobId">
                            <c:forEach var="job" items="${jobList}">
                                <option value="${job.id}">${job.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>부서</label>
                        <select name="departmentId">
                            <c:forEach var="dept" items="${departmentList}">
                                <option value="${dept.id}">${dept.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label>연락처</label>
                        <input type="text" name="contact" placeholder="010-1234-5678">
                    </div>
                    <div class="form-group">
                        <label>우편번호</label>
                        <div class="input-with-btn">
                            <input type="text" id="postcode" name="postCode" readonly placeholder="우편번호">
                            <button type="button" class="postBtn" id="postBtn">검색</button>
                        </div>
                    </div>
                    <div class="form-group">
                        <label>주소</label>
                        <input type="text" name="address" readonly placeholder="기본 주소">
                    </div>
                    <div class="form-group">
                        <label>상세주소</label>
                        <input type="text" name="detailAddress" placeholder="상세 주소를 입력하세요">
                    </div>
                </div>
                <div class="card-footer">
                    <button type="submit" class="btn primary">입력완료</button>
                    <button type="button" class="btn secondary" id="backBtn">돌아가기</button>
                </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>
<script src="/js/hr/write.js" type="text/javascript"></script>
<%--<jsp:include page="/WEB-INF/views/template/footer.jsp"/>--%>
