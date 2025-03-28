<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>Document</title>
  <link
          href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
          rel="stylesheet"
          integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
          crossorigin="anonymous"
  />
  <script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js"></script>

  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f4f4f4;
    }

    .container-fluid {
      overflow: hidden;
      display: flex;
      height: 100vh;
      width: 100%;
      background-color: #eef1f6;
      position: relative;
      padding: 0;
    }

    .main {
      display: flex;
      width: 100%;
      display: block;
    }

    .logo {
      position: absolute;
      left: 0;
      width: 30px;
      height: 30px;
    }

    .sidebar {
      margin: 0;
      width: 50px;
      overflow: hidden;
      background: #030848;
      height: 100vh;
      text-align: center;
      position: fixed;
      transition: width 0.3s ease-in-out;
      color: white;
      z-index: 3;
      /* transition-duration: 0.5s; */
    }
    .sidebar ul {
      padding: 0;
      margin: 0;
    }
    div {
      border: 1px solid red;
    }

    .sidebar ul li {
      list-style: none;
      padding: 10px;
      cursor: pointer;
      margin-top: 20px;
    }
    .sidebar a {
      text-decoration: none;
      color: #fff;
    }

    .sidebar:hover {
      width: 150px;
    }

    .boxContents {
      margin-left: 50px;
    }

    html,
    body {
      margin: 0;
      padding: 0;
      width: 100%;
    }

    .header {
      position: relative;
      background: #fff;
      padding: 10px;
      height: 50px;
      width: 100%;
      box-sizing: border-box;
      display: flex;
      flex-direction: row;
      justify-content: flex-end;
      box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
      position: sticky;
      top: 0;
      z-index: 1;
    }

    input {
      /* width: 50vw; */
      margin-right: 50px;
    }

    .bellBtn {
      /* display: block; */
      background: #fff;
      border: none;
    }

    .profileIcon {
      border-radius: 50%;
      width: 35px;
      height: 35px;
    }

    .icon {
      display: flex;
      padding-top: 20px;
    }
    .menu {
      list-style: none;
      padding: 10px;
      opacity: 0;
      transition: opacity 0.3s ease-in-out;
    }
  </style>
</head>

<body>
<div class="container-fluid">
  <div class="sidebar">
    <div class="icon">
      <ul>
        <li>
          <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="25"
                  height="25"
                  fill="currentColor"
                  class="bi bi-list"
                  viewBox="0 0 16 16"
          >
            <path
                    fill-rule="evenodd"
                    d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5"
            />
          </svg>
        </li>
      </ul>
      <ul>
        <li>홈</li>
      </ul>
    </div>

    <div class="icon">
      <ul>
        <li>
          <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="25"
                  height="25"
                  fill="currentColor"
                  class="bi bi-clipboard2"
                  viewBox="0 0 16 16"
          >
            <path
                    d="M3.5 2a.5.5 0 0 0-.5.5v12a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5v-12a.5.5 0 0 0-.5-.5H12a.5.5 0 0 1 0-1h.5A1.5 1.5 0 0 1 14 2.5v12a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 14.5v-12A1.5 1.5 0 0 1 3.5 1H4a.5.5 0 0 1 0 1z"></path>
            <path
                    d="M10 .5a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5.5.5 0 0 1-.5.5.5.5 0 0 0-.5.5V2a.5.5 0 0 0 .5.5h5A.5.5 0 0 0 11 2v-.5a.5.5 0 0 0-.5-.5.5.5 0 0 1-.5-.5"></path>
          </svg>
        </li>
      </ul>
      <ul>
        <li>홈</li>
      </ul>
    </div>

    <div class="icon">
      <ul>
        <li>
          <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="25"
                  height="25"
                  fill="currentColor"
                  class="bi bi-envelope"
                  viewBox="0 0 16 16"
          >
            <path
                    d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z"></path>
          </svg>
        </li>
      </ul>
      <ul>
        <li>홈</li>
      </ul>
    </div>

    <div class="icon">
      <ul>
        <li>
          <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="25"
                  height="25"
                  fill="currentColor"
                  class="bi bi-archive"
                  viewBox="0 0 16 16"
          >
            <path
                    d="M0 2a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v7.5a2.5 2.5 0 0 1-2.5 2.5h-9A2.5 2.5 0 0 1 1 12.5V5a1 1 0 0 1-1-1zm2 3v7.5A1.5 1.5 0 0 0 3.5 14h9a1.5 1.5 0 0 0 1.5-1.5V5zm13-3H1v2h14zM5 7.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5"></path>
          </svg>
        </li>
      </ul>
      <ul>
        <li>홈</li>
      </ul>
    </div>

    <div class="icon">
      <ul>
        <li>
          <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="25"
                  height="25"
                  fill="currentColor"
                  class="bi bi-briefcase-fill"
                  viewBox="0 0 16 16"
          >
            <path
                    d="M6.5 1A1.5 1.5 0 0 0 5 2.5V3H1.5A1.5 1.5 0 0 0 0 4.5v1.384l7.614 2.03a1.5 1.5 0 0 0 .772 0L16 5.884V4.5A1.5 1.5 0 0 0 14.5 3H11v-.5A1.5 1.5 0 0 0 9.5 1zm0 1h3a.5.5 0 0 1 .5.5V3H6v-.5a.5.5 0 0 1 .5-.5"></path>
            <path
                    d="M0 12.5A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5V6.85L8.129 8.947a.5.5 0 0 1-.258 0L0 6.85z"></path>
          </svg>
        </li>
      </ul>
      <ul>
        <li>홈</li>
      </ul>
    </div>

    <div class="icon">
      <ul>
        <li>
          <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="25"
                  height="25"
                  fill="currentColor"
                  class="bi bi-clock"
                  viewBox="0 0 16 16"
          >
            <path
                    d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z"></path>
            <path
                    d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0"></path>
          </svg>
        </li>
      </ul>
      <ul>
        <li>홈</li>
      </ul>
    </div>

    <div class="icon">
      <ul>
        <li>
          <svg
                  xmlns="http://www.w3.org/2000/svg"
                  width="25"
                  height="25"
                  fill="currentColor"
                  class="bi bi-briefcase-fill"
                  viewBox="0 0 16 16"
          >
            <path
                    d="M6.5 1A1.5 1.5 0 0 0 5 2.5V3H1.5A1.5 1.5 0 0 0 0 4.5v1.384l7.614 2.03a1.5 1.5 0 0 0 .772 0L16 5.884V4.5A1.5 1.5 0 0 0 14.5 3H11v-.5A1.5 1.5 0 0 0 9.5 1zm0 1h3a.5.5 0 0 1 .5.5V3H6v-.5a.5.5 0 0 1 .5-.5"></path>
            <path
                    d="M0 12.5A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5V6.85L8.129 8.947a.5.5 0 0 1-.258 0L0 6.85z"></path>
          </svg>
        </li>
      </ul>
      <ul>
        <li>홈</li>
      </ul>
    </div>
  </div>

  <div class="main">
    <div class="header">
      <div class="logo"></div>
      <button class="bellBtn">
        <svg
                xmlns="http://www.w3.org/2000/svg"
                width="16"
                height="18"
                fill="currentColor"
                class="bi bi-bell"
                viewBox="0 0 16 16"
        >
          <path
                  d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2M8 1.918l-.797.161A4 4 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4 4 0 0 0-3.203-3.92zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5 5 0 0 1 13 6c0 .88.32 4.2 1.22 6"></path>
        </svg>
      </button>
      <input type="text" placeholder="검색" />
      <div class="profile">
            <span class="photo">
              <a>
                <img class="profileIcon" src="ㄴ.jpg" />
                <!-- 세션에서 이미지 불러오기 -->
              </a>
            </span>
      </div>
    </div>
    <div class="boxContents">
      <!-- 여기에 내용 -->
