<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <link rel="icon" href="/resources/image/favicon.ico">
  <link rel="stylesheet" href="/css/main/login.css" />
  <title>Login</title>
  <style>
    @media screen and (max-width: 992px) {
        .loginContainer {
          display: flex;
          flex-direction: column;
          height: auto;
        }

      .loginLeft {
        width: 100%;
      }

      .loginRight {
        width: 100%;
        padding: 2rem;
      }
    }
  </style>
</head>

<div class="loginContainer">
  <div class="loginLeft">
    <div class="loginLogo">
      <img src="/image/로그인로고.PNG" />
    </div>
    <form action="/employee/login" method="post" class="loginForm">
      <input type="text" name="loginId" id="id" placeholder="아이디 입력" autocomplete="loginId"/>
      <input type="password" name="password" id="pw" placeholder="패스워드 입력" autocomplete="password"/>
      <div class="remember">
        <input type="checkbox" id="rememberId" />
        <label for="rememberId">아이디 저장하기</label>
      </div>
      <div class="buttons">
        <button id="newBtn" type="button">사원 등록</button>
        <button id="loginBtn" type="submit">Login</button>
      </div>
    </form>
  </div>

  <div class="loginRight">
    <img src="/image/로그인이미지.png" class="rightImg" />
  </div>
</div>

<script src="/js/main/login.js" type="text/javascript"></script>
</body>
</html>
