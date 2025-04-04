<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/mail/list.css" />
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<div class="mainContainer">
    <div class="mainHeader">
        <div class="title">
            <h2><span class="material-icons">mail</span>전체 메일함</h2>
        </div>
        <div class="mailSend">
            <button onclick="location.href='/mail/write';"><span class="material-icons">outgoing_mail</span>메일쓰기</button>
        </div>
        <div class="search">
            <div>
                <select id="searchOption">
                    <option>보낸 사람  </option>
                    <option>내용 </option>
                    <option>제목 </option>
                </select>
            </div>
            <div class="searchInput">
                <input id="input" type="text" name="keyword" placeholder="검색어 입력">
            </div>
            <div>
                <button id="searchBtn"> <span class="material-icons">search</span> 검색</button>
            </div>
        </div>
        <div class="titleArea">
            <h4>전체 메일 (0)</h4> <h4>안읽은 메일 (0)</h4>
        </div>
    </div>
    <div class="mainBody">
        <div class="content">
            <table class="mailList">
                <thead>
                <tr>
                    <th style="width: 5%; text-align: center"><input style="zoom: 1.5;" type="checkbox" id="checkAll"></th>
                    <th style="width: 5%">중요</th>
                    <th style="width: 20%">보낸사람</th>
                    <th style="width: 5%"></th>
                    <th style="width: 55%">제목</th>
                    <th style="width: 10%">발송 일자</th>
                </tr>
                </thead>
                <tbody id="mailBody">
                </tbody>
                <tfoot id="buttons"></tfoot>
            </table>
        </div>
        <div class="pageNavi">
            <button>읽음</button>
            <button>휴지통</button>
        </div>
    </div>
</div>
<script src="/js/mail/list.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>