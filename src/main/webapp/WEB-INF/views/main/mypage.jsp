<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/main/mypage.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<div class="mainContainer">
    <div class="mainHeader">
        <div class="title">
            <h2><span class="material-icons">supervisor_account</span>사원 정보</h2>
        </div>
    </div>
    <div class="mainBody">
            <div class="content">
                <div class="profile">
                    <img src="/images/profile/${employee.profileImg}" alt="프로필 이미지" width="100" height="100">
                </div>
                <div class="name">이름 : ${employee.name}</div>
                <div class="contact">연락처 : ${employee.contact}</div>
                <div class="birthday">생년월일 : ${employee.birthday}</div>
                <div class="position">직급 : ${employee.jobId}</div>
                <div class="department">부서 : ${employee.departmentId}</div>
                <div class="email">이메일 : ${employee.email}</div>
                <div class="postCode">우편번호 : ${employee.postCode}</div>
                <div class="address">주소 : ${employee.address}</div>
                <div class="detailAddress">상세주소 : ${employee.detailAddress}</div>
            </div>
        <div class="btn">
            <button id="EditBtn">수정하기</button>
            <button id="backBtn">돌아가기</button>
        </div>
    </div>
</div>

<script src="/js/main/mypage.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
