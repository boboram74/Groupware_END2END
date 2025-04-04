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
    <form action="/mail/reSend" method="post">
    <div class="formContainer">
        <div class="formGroup">
            <label>보낸 사람</label>
            <input type="hidden" id="sender" value=${employee.email}>
            <input type="text" id="receiveMail" name="sender" value="${list.sender}" readonly>
            <button class="addressBtn">주소록</button>
        </div>
        <div class="formGroup">
            <label>제목</label>
            <input type="text" id="inputTitle" name="title" value="${list.subject}" readonly>
        </div>
        <div class="formGroup">
            <label>파일 첨부</label>
            <div class="dragDropArea" id="dropArea">
                <c:forEach var="i" items="${fileList}">
                    <div class="fileItem">
                        <span class="material-icons">attachment</span>
                        <a href="http://34.70.179.192/mail/files?path=${i.path}">
                                ${i.originFileName}
                        </a>&nbsp;
                        <span class="fileItemSize" data-size="${i.fileSize}"></span>
                    </div>
                </c:forEach>
            </div>
            <input type="file" id="fileInput" style="display:none;" multiple>
            <span class="fileSize">0/30 MB</span>
        </div>
    </div>
    <div class="mainBody">
        <div class="content">
            <textarea id="mailContent" name="content" readonly>${list.content}</textarea>
        </div>
        <div class="buttons">
            <button type="submit">답장하기</button>
        </div>
    </div>
    </form>
</div>
<script src="/js/mail/detail.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>