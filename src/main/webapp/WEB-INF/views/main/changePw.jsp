<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<link rel="stylesheet" href="/css/main/changePw.css">
<html>
<head>
    <title>패스워드 변경하기</title>
</head>


<body>
    <div class="pwContainer">
        <form action="/employee/changePw" method="post" onsubmit="return validateForm();">
            <div class="pwForm">
                <label for="currentPw">기존 패스워드 입력</label>
                <input type="password" id="currentPw" name="currentPw" required>
            </div>
            <div class="pwForm">
                <label for="newPw">새 패스워드 입력</label>
                <input type="password" id="newPw" name="newPw" required>
            </div>
            <div class="pwForm">
                <label for="confirmPw">새 패스워드 확인</label>
                <input type="password" id="confirmPw" name="confirmPw" required>
            </div>
           <button id="changeBtn">변경하기</button>
        </form>
    </div>

    <script src="/js/main/changePw.js" type="text/javascript"></script>
</body>
</html>
