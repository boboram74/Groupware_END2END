<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/mail/detail.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<div class="mainContainer">
    <div class="mainHeader">
        <div class="title">
            <h2><span class="material-icons">outgoing_mail</span>메일 상세보기</h2>
        </div>
    </div>
    <div class="formContainer">
        <div class="formGroup">
            <label>보낸 사람</label>
            <input type="hidden" id="sender" value=${employee.email}>
            <input type="text" id="receiveMail" value="${list.sender}" readonly>
            <button class="addressBtn">주소록</button>
        </div>
        <div class="formGroup">
            <label>제목</label>
            <input type="text" id="inputTitle" value="${list.subject}" readonly>
        </div>
        <div class="formGroup">
            <label>파일 첨부</label>
            <div class="dragDropArea" id="dropArea">
                <span class="material-icons upload-icon">cloud_upload</span>
                <p>파일을 이곳에 드래그하거나<br>클릭하여 업로드하세요</p>
                <p class="file-info">선택된 파일 없음</p>
            </div>
            <input type="file" id="fileInput" style="display:none;" multiple>
            <span class="fileSize">0/30 MB</span>
        </div>
    </div>

    <div class="mainBody">
        <div class="content">
            <textarea id="mailContent" readonly>${list.content}</textarea>
        </div>
        <div class="buttons">
            <button type="button">임시 저장</button>
            <button type="button" id="sendMail">보내기</button>
        </div>
    </div>
</div>
<script src="/js/mail/detail.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>