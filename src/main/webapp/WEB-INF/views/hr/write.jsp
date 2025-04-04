<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/hr/write.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="mainContainer">
    <div class="mainHeader">
        <div class="title">
            <h2><span class="material-icons">group_add</span>사원 등록</h2>
        </div>
    </div>
    <div class="mainBody">
        <form action="/hr/insert" method="post" enctype="multipart/form-data" id="form">
            <div class="content">
                <div class="hrProfile">
                    <label for="profileInput">
                        <img id="profilePreview" src="/image/defaultImg.jpg" alt="프로필 이미지">
                        <span class="material-icons">add_a_photo</span>
                    </label>
                    <input type="file" id="profileInput" name="file" accept="image/*" style="display: none;">
                    <input type="hidden" name="profileImg" value="/image/defaultImg.jpg"/>
                </div>
                <div class="name">이름 : <input type="text" name="name"></div>
                <div class="birthday">생년월일 :
                    <input type="date" name="birthday">
                </div>
                <div class="loginId">아이디 : <input type="text" id="id" name="loginId" placeholder="8~20자 이내 영어소문자,숫자를 포함한 ID 입력">
                    <button type="button" id="idCheckBtn">중복 체크</button>
                </div>
                <div id="result"></div>
                <div class="pw">패스워드 입력 : <input type="password" name="password"
                                                 placeholder="8자 이상의 영어소문자,숫자를 포함한 PW 입력">
                </div>
                <div class="repw">패스워드 확인 : <input type="password" placeholder="위와 동일하게 패스워드 입력"></div>
                <div class="position">직급 :
                    <select name="jobId">
                        <c:forEach var="job" items="${jobList}">
                            <option value="${job.id}">${job.name}</option>
                        </c:forEach>
                    </select>
                </div>

                <div class="department">부서 :
                    <select name="departmentId">
                        <c:forEach var="dept" items="${departmentList}">
                            <option value="${dept.id}">${dept.name}</option>
                        </c:forEach>
                    </select>
                </div>
                <div class="email">이메일 : <input type="text" name="email"></div>
                <div class="contact">연락처 : <input type="text" name="contact"></div>
                <div class="postCode">우편번호 : <input type="text" name="postCode" id="postcode" readonly>
                    <button type="button" class="postBtn" id="postBtn">우편번호 검색</button>
                </div>
                <div class="address">주소 : <input type="text" name="address" readonly></div>
                <div class="detailAddress">상세주소 : <input type="text" name="detailAddress"></div>
            </div>
            <div class="btn">
                <button id="insertBtn">입력완료</button>
                <button type="button" id="backBtn">돌아가기</button>
            </div>
        </form>
    </div>
</div>

<script src="/js/hr/write.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
