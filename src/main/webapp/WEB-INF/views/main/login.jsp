<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="/css/main/login.css">
  <title>Login</title>
</head>

<body>
<form action="/employee/login" method="post">
  <div class="mainContainer">
    <div class="mainHeader">
      <img src="/image/로그인로고.PNG">
    </div>
    <div class="mainBody">
      <input type="text" name="id" id="id" placeholder="아이디 입력"><br>
      <input type="password" name="pw" id="pw" placeholder="패스워드 입력"><br>
      <input type="checkbox" id="check">아이디 저장하기<br>
      <div class="btn">
        <button id="newBtn" type="button">사원 등록</button>
        <button id="loginBtn" type="button">Login</button>
      </div>
    </div>
  </div>
</form>

<script src="/js/main/login.js" type="text/javascript"></script>
</body>
</html>
