<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<jsp:include page="/WEB-INF/views/commute/commute-header.jsp"/>
<style>
    .button-container {
        display: flex;
        justify-content: end;
        gap: 10px;
    }
</style>
<div class="button-container">
    <button class="extended-button">연장근무 신청</button>
    <button class="vacation-button">휴가 신청</button>
</div>
<div class="content">
    출력 공간(높이 주지말고 컨텐츠 내용에 따라 유동적으로 증가하게 두세요)
<jsp:include page="/WEB-INF/views/commute/commute-footer.jsp"/>