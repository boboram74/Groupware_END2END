<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp" />
<link rel="stylesheet" href="/css/approval/list.css">
<script src="https://code.jquery.com/jquery-latest.min.js"></script>
<div class="userInfo">
    <div class="userIcon"></div>
    <div class="userText">나의 전자결재</div>
</div>


<div class="apControls">
    <button class="apBtnNewDoc">새 기안 쓰기</button>
    <button class="apBtnRefresh">상세 조회</button>
</div>

<div class="apDocumentSection">
    <div class="apSectionHeader">
        <h3 class="apSectionTitle">결재 대기 중 (0)</h3>
    </div>
    <div class="apDocumentTable">
        <table>
            <thead>
            <tr>
                <th class="apColStar"></th>
                <th class="apColTitle">제목</th>
                <th class="apColStatus">결재 상태</th>
                <th class="apColWriter">기안자</th>
                <th class="apColDate">기안일</th>
            </tr>
            </thead>
            <tbody>
            <!-- 결재 대기 중 문서 목록 -->

            </tbody>
        </table>
    </div>
</div>
<div class="apDocumentSection">
    <div class="apSectionHeader">
        <h3 class="apSectionTitle">결재 진행 중 (0)</h3>
    </div>
    <div class="apDocumentTable">
        <table>
            <thead>
            <tr>
                <th class="apColStar"></th>
                <th class="apColTitle">제목</th>
                <th class="apColStatus">결재 상태</th>
                <th class="apColWriter">기안자</th>
                <th class="apColDate">기안일</th>
            </tr>
            </thead>
            <tbody>
            <!-- 결재 진행 중 문서 목록 -->

            </tbody>
        </table>
    </div>
</div>
<div class="apDocumentSection">
    <div class="apSectionHeader">
        <h3 class="apSectionTitle">결재 완료 (0)</h3>
    </div>
    <div class="apDocumentTable">
        <table>
            <thead>
            <tr>
                <th class="apColStar"></th>
                <th class="apColTitle">제목</th>
                <th class="apColStatus">결재 상태</th>
                <th class="apColWriter">기안자</th>
                <th class="apColDate">기안일</th>
            </tr>
            </thead>
            <tbody>
            <!-- 결재 완료 문서 목록 -->

            </tbody>
        </table>
    </div>
</div>
<div class="bottomButton">
    <button class="btnChat"> 채팅</button>
</div>
<script>
    $(".apBtnNewDoc").on("click", function () {
        window.open("/approval/write", "width=400,height=600");
    });
</script>
<jsp:include page="/WEB-INF/views/template/footer.jsp" />

