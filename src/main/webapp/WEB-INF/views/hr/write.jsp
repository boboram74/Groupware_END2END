<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>

<link rel="stylesheet" href="/css/hr/write.css">

<div class="hrContainer">
    <div class="hrHeader">
        <h2>사원 추가</h2>
    </div>
    <div class="hrBody">
        <form action="/hr/insert" method="post" enctype="multipart/form-data">
            <div class="newEmployee">
                <div class="profile">프로필 사진 :
                    <img id="profilePreview" src="/images/default-profile.png" alt="프로필 미리보기" style="width: 150px; height: 150px; border-radius: 50%; object-fit: cover; margin-top: 10px;">
                    <br>
                    <input type="file" name="profile" accept="image/*">
                </div>
                <div class="name">이름 : <input type="text" name="name"></div>
                <div class="position">직급 : <input type="text" name="position"></div>
                <div class="department">부서 : <input type="text" name="department"></div>
                <div class="email">이메일 : <input type="text" name="email"></div>
                <div class="contact">연락처 : <input type="text" name="contact"></div>
                <div class="postCode">우편번호 : <input type="text" name="postCode"></div>
                <div class="address1">주소 : <input type="text" name="address1"></div>
                <div class="address2">상세주소 : <input type="text" name="address2"></div>
                <div class="dob">생년월일 : <input type="date" name="dob"></div>
            </div>
        </form>
        <div class="btn">
            <button id="insertBtn">완료</button>
            <button id="backBtn">돌아가기</button>
        </div>
    </div>
</div>

<script src="/js/hr/write.js" type="text/javascript"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
