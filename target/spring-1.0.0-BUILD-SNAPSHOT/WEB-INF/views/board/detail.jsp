<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/board/detail.css"/>
<link rel="stylesheet" href="/css/template/exam.css"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<div class="mainContainer">
    <div class="mainHeader">
        <div class="title">
            <h2><span class="material-icons">toggle_off</span>타이틀</h2>
        </div>
        <div class="search">
            <div class="memberInfo">
                <ul>
                    <li>xxx사원 xxxx-xx-xx(월)xx:xx 조회수:10</li>
                </ul>
                <div class="file">
                    <ul>
                        <li>
                            <label for="file-upload">
                                <input type="file" id="file-upload">
                            </label>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </div>
    <div class="mainBody">
        <div class="content">

            <div class="inputContents">
                <input type="text" placeholder="내용 입력">
            </div>
        </div>
        <hr>
        <div class="inputReply">
            <input type="text">
        </div>
        <div class="editBtn">
            <button>수정</button>
            <button>삭제</button>
        </div>
    </div>
    <div class="pageNavi">
        1 2 3 4 5
    </div>

</div>

<script src="/js/main/contact.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>
