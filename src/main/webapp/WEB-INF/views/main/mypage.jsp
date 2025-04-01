<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/main/mypage.css">

<div class="hrContainer">
    <div class="hrHeader">
        <h3>사원 정보</h3>
    </div>
    <div class="hrBody">
        <form action="/hr/update" method="post" enctype="multipart/form-data">
            <div class="newEmployee">
                <div class="profile">프로필 사진 </div>
                <div class="name">이름 </div>
                <div class="position">직급 </div>
                <div class="department">부서 </div>
                <div class="email">이메일 </div>
                <div class="contact">연락처 </div>
                <div class="postCode">우편번호 </div>
                <div class="address1">주소 </div>
                <div class="address2">상세주소 </div>
                <div class="dob">생년월일 </div>

            </div>
        </form>
        <div class="btn">
            <button id="EditBtn">수정</button>
            <button id="backBtn">돌아가기</button>
        </div>
    </div>
</div>

<script src="/js/main/mypage.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
