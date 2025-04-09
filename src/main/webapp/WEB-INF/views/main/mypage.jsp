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
        <form id="addressForm" action="/hr/update" method="post">
            <div class="content">
                <div class="hrProfile" style="background-image: url(${employeeDetail.profileImg});">
                </div>
                <div class="name">이름 : ${employeeDetail.name}</div>
                <div class="contact">연락처 : ${employeeDetail.contact}</div>
                <div class="birthday">생년월일 : ${employeeDetail.birthday}</div>
                <div class="position">직급 : ${employeeDetail.jobName}</div>
                <div class="department">부서 : ${employeeDetail.departmentName}</div>
                <div class="email">이메일 : ${employeeDetail.email}</div>
                <div class="postCode">우편번호 : ${employeeDetail.postCode}</div>
                <div class="address">주소 : ${employeeDetail.address}
                    <input type="text" id="addressInput" name="address" value="${employeeDetail.address}" style="display:none;" />
                </div>
                <div class="detailAddress">상세주소 : ${employeeDetail.detailAddress}
                    <input type="text" id="detailAddressInput" name="detailAddress" value="${employeeDetail.detailAddress}" style="display:none;" />
                </div>
            </div>
        <div class="btn">
            <button id="EditBtn">수정하기</button>
            <button type="submit" id="SaveBtn" style="display:none;">저장하기</button>
            <button id="backBtn">돌아가기</button>
        </div>
        </form>
    </div>
</div>

<script src="/js/main/mypage.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
