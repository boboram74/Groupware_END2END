<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:choose>
    <c:when test="${employee != null}">
        <jsp:include page="login.jsp"/>
    </c:when>
    <c:otherwise>
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8" />
            <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            <title>Document</title>
            <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
            <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
            <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.15/index.global.min.js'></script>
            <script>

                document.addEventListener('DOMContentLoaded', function() {
                    var calendarEl = document.getElementById('calendar');
                    var calendar = new FullCalendar.Calendar(calendarEl, {
                        initialView: 'dayGridMonth',
                        width:350,
                        height: 400,
                        aspectRatio: 1, // 가로세로 비율을 1:1로 유지
                        expandRows: true // 행의 개수에 따라 크기 자동 조정
                    });
                    calendar.render();
                });

            </script>
            <style>
                /**{border: 1px solid red;}*/
                body {

                    margin: 0;
                    padding: 0;
                    background-color: #f4f4f4;
                }
                /* div{   border: 1px solid red;
                              } */

                html, body {
                    margin: 0;
                    padding: 0;
                    width: 100%;
                }
                .container-fluid {
                    overflow: hidden;
                    display: flex;
                    height: 100vh;
                    width: 100%;
                    background-color: #eef1f6;
                    position: relative;
                    padding: 0;

                    position: relative;
                }

                .main{
                    width: 100%;

                    overflow-y: scroll;
                }

                .logo {
                    position: absolute;
                    left:65px;
                    width: 170px;
                    height: 30px;
                    overflow: hidden;
                }
                .logo>.fit{
                    width:100%;
                    height: 100%;
                    object-fit: cover;
                }

                .boardBox{
                    height: 60%;
                    background-color: white;
                }
                .box{
                    background-color: white;
                }

                .boxContents {

                    display: flex;
                    height: 100%;
                    width: 100%;
                    justify-content: space-between;
                    gap: 20px;
                    margin-top: 20px;
                    left: 50px;
                    position: absolute;
                }

                .leftContents{
                    min-width: 300px;
                    width: 30vw;

                    display: flex;
                    flex-grow: 1;

                }
                .centerContents {

                    width: 60vw;
                    min-width: 580px;
                    padding: 15px;
                    background-color: rgba(222, 229, 239, 0.5);
                    flex-grow: 2.5;
                    height: 100vh;
                }
                .rightContents{
                    min-width: 210px;
                    display: flex;
                    flex-direction: column;
                    flex-grow: 2;

                }

                .mainContent {
                    flex: 1;
                    padding: 20px;
                    background: #fff;
                    position: absolute;

                }


                .header {
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


                .sidebar {
                    text-align: left;
                    margin: 0;
                    width: 50px;
                    overflow: hidden;
                    background: #003465;
                    height: 100vh;
                    /*text-align: center;*/
                    position:fixed;
                    transition: width 0.3s ease;
                    color: white;
                    z-index: 3;

                }

                .sidebar ul {
                    padding: 0;
                    margin: 0;
                    flex: 1;
                    width: 100%;

                }

                .sidebar:hover {
                    width: 150px;
                }
                .sidebar ul li {
                    list-style: none;
                    padding: 10px;
                    cursor: pointer;
                    margin-top: 20px;
                    text-align: left; /* 글씨 밀림 방지 */
                    transition: opacity 0.3s ease;
                    white-space: nowrap; /* 글씨 줄 바꿈 방지 */
                    display: flex;
                    align-items: center;
                }
                .sidebar a {
                    text-decoration: none;
                    color: #fff;
                    padding-left: 10px;
                }
                .sidebar:hover ul li {
                    opacity: 1; /* 메뉴 열릴 때 자연스럽게 표시 */
                    align-items: center;
                }

                /*.sidebar ul li:hover {*/
                /*    background-color: whitesmoke;*/
                /*    color: #003465;*/
                /*}*/
                .sidebar>.icon{
                    display: flex;
                    margin-top: 20px;


                }
                .sidebar>.icon:hover{
                    background-color: whitesmoke;
                    color: #003465;
                }
                .button {
                    display: block;
                    margin-bottom: 10px;
                    padding: 10px;
                    background: #fff;

                    border: none;
                    cursor: pointer;
                    box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
                }

                .chat-button {
                    padding: 15px;
                    border-radius: 50%;
                }

                profileimg{
                    overflow: clip;
                    height: 100px;
                }
                .imgBox{
                    width: 180px;
                    height: 180px;
                    border-radius: 50%;
                    overflow: hidden;
                    background-image: url("./ㄴ.jpg");
                    background-repeat: no-repeat;    background-position: center;

                }
                .logbox{
                    height: 30%;
                    margin-left: 20px;
                    background-color: white;
                    align-items: center;
                    display: flex;
                    justify-content: center;
                    flex-direction: column;
                    border-radius: 10px;
                    margin-top: 16px;
                }



                .calenderBox{
                    margin-top: 30px;
                    background-color: white;
                    border-radius: 10px;
                    margin-left: 20px;
                }

                #calendar {
                    max-width: 350px; /* 최대 너비 설정 */
                     max-height: 400px;
                }
                .loginlist{
                    border-radius: 10px;
                    margin-top: 30px;
                    margin-left: 20px;
                    background-color: white;
                    height: 20%;
                }
                .birthBox{

                    margin-top: 30px;
                    height: 50%;
                }
                .myWaitingBox{
                    margin-top: 30px;
                    height: 35%;
                    background-color: white;
                }
                .btnBox
                .btn-primary{
                    flex-direction: column;
                    display: flex;
                    width: 137px;
                    height: 50px;

                }
                .btn-primary {
                    border: none;
                    flex-direction: column;
                    display: flex;
                    width: 137px;
                    height: 50px;
                    background-color: white;
                    color: navy;
                    font-size: 16px;
                    text-align: center;
                    justify-content: center;
                    align-items: center;
                    transition: all 0.3s ease-in-out;
                    cursor: pointer;
                    border-radius: 8px;
                }
                .btn-primary:hover {
                    background: #003465!important;
                    color: white !important;
                    transform: scale(1.05) !important;
                }

                .btnBox{
                    display: flex;
                    flex-direction: column;
                }
                button{
                    margin-top: 15px;
                }
                .profileIcon{
                    border-radius: 50%;
                    width: 35px;
                    height: 35px;
                }

                .menu {
                    list-style: none;
                    padding: 10px;
                    opacity: 0;
                    transition: opacity 0.3s ease-in-out;
                }
                /*
                @media all and (max-width: 639px) {
                  .SizeVisibleClass .ViWidthS { display: block; }
                  .SizeVisibleClass .ViWidthM { display: none; }
                  .SizeVisibleClass .ViWidthL { display: none; }
                }


                @media all and (min-width: 640px) and (max-width: 1200px) {
                  .SizeVisibleClass .ViWidthS { display: none; }
                  .SizeVisibleClass .ViWidthM { display: block; }
                  .SizeVisibleClass .ViWidthL { display: none; }
                }


                @media all and (min-width: 1024px) {
                  .SizeVisibleClass .ViWidthS { display: none; }
                  .SizeVisibleClass .ViWidthM { display: none; }
                  .SizeVisibleClass .ViWidthL { display: block; }
                } */

                /* @media (max-width: 430px) {
                  .header, .sidebar {
                    display: none;
                  }

                  .boxContents {
                    flex-direction: column;
                    align-items: center;
                  }

                  .logbox, .boardBox, .myWaitingBox {
                    width: 90%;
                    margin: 10px auto;
                  }


                  .bottom-nav {
                    display: flex;
                    justify-content: space-around;
                    position: fixed;
                    bottom: 0;
                    left: 0;
                    width: 100%;
                    background-color: #fff;
                    padding: 10px 0;
                    border-top: 1px solid #ddd;
                  }

                  .bottom-nav a {
                    text-decoration: none;
                    color: black;
                    font-size: 18px;
                  }

                    .main > div:not(.logbox):not(.boardBox):not(.myWaitingBox) {
                    display: none;
                  }
                  .bottom-nav a {
                    text-decoration: none;
                    color: black;
                    font-size: 18px;
                  }
                } */

            </style>


        </head>

        <body>


        <div class="container-fluid">
            <div class="sidebar d-xs-none .d-md-block">
                <div class="icon">
                    <ul>
                        <li><svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-list" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M2.5 12a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5m0-4a.5.5 0 0 1 .5-.5h10a.5.5 0 0 1 0 1H3a.5.5 0 0 1-.5-.5"/>
                        </svg>
                        </li>
                    </ul>
                    <ul>
                        <li>홈
                        </li>
                    </ul>
                </div>

                <div class="icon">


                    <ul>
                        <li><svg xmlns="http://www.w3.org/2000/svg"  width="25" height="25" fill="currentColor" class="bi bi-clipboard2" viewBox="0 0 16 16">
                            <path d="M3.5 2a.5.5 0 0 0-.5.5v12a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5v-12a.5.5 0 0 0-.5-.5H12a.5.5 0 0 1 0-1h.5A1.5 1.5 0 0 1 14 2.5v12a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 14.5v-12A1.5 1.5 0 0 1 3.5 1H4a.5.5 0 0 1 0 1z"/>
                            <path d="M10 .5a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5.5.5 0 0 1-.5.5.5.5 0 0 0-.5.5V2a.5.5 0 0 0 .5.5h5A.5.5 0 0 0 11 2v-.5a.5.5 0 0 0-.5-.5.5.5 0 0 1-.5-.5"/>
                        </svg>
                        </li>
                    </ul>
                    <ul>
                        <li>게시판
                        </li>
                    </ul>

                </div>

                <div class="icon">
                    <ul>
                        <li><svg xmlns="http://www.w3.org/2000/svg"  width="25" height="25" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                            <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z"/>
                        </svg>
                        </li>
                    </ul>
                    <ul>
                        <li>메일
                        </li>
                    </ul>
                </div>

                <div class="icon">
                    <ul>
                        <li><svg xmlns="http://www.w3.org/2000/svg"  width="25" height="25"  fill="currentColor" class="bi bi-archive" viewBox="0 0 16 16">
                            <path d="M0 2a1 1 0 0 1 1-1h14a1 1 0 0 1 1 1v2a1 1 0 0 1-1 1v7.5a2.5 2.5 0 0 1-2.5 2.5h-9A2.5 2.5 0 0 1 1 12.5V5a1 1 0 0 1-1-1zm2 3v7.5A1.5 1.5 0 0 0 3.5 14h9a1.5 1.5 0 0 0 1.5-1.5V5zm13-3H1v2h14zM5 7.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5"/>
                        </svg>
                        </li>
                    </ul>
                    <ul>
                        <li>전자결재
                        </li>
                    </ul>
                </div>


                <div class="icon">
                    <ul>
                        <li><svg xmlns="http://www.w3.org/2000/svg"  width="25" height="25"  fill="currentColor" class="bi bi-briefcase-fill" viewBox="0 0 16 16">
                            <path d="M6.5 1A1.5 1.5 0 0 0 5 2.5V3H1.5A1.5 1.5 0 0 0 0 4.5v1.384l7.614 2.03a1.5 1.5 0 0 0 .772 0L16 5.884V4.5A1.5 1.5 0 0 0 14.5 3H11v-.5A1.5 1.5 0 0 0 9.5 1zm0 1h3a.5.5 0 0 1 .5.5V3H6v-.5a.5.5 0 0 1 .5-.5"/>
                            <path d="M0 12.5A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5V6.85L8.129 8.947a.5.5 0 0 1-.258 0L0 6.85z"/>
                        </svg>
                        </li>
                    </ul>
                    <ul>
                        <li>업무보고
                        </li>
                    </ul>
                </div>

                <div class="icon">
                    <ul>
                        <li><svg xmlns="http://www.w3.org/2000/svg"  width="25" height="25" fill="currentColor" class="bi bi-clock" viewBox="0 0 16 16">
                            <path d="M8 3.5a.5.5 0 0 0-1 0V9a.5.5 0 0 0 .252.434l3.5 2a.5.5 0 0 0 .496-.868L8 8.71z"/>
                            <path d="M8 16A8 8 0 1 0 8 0a8 8 0 0 0 0 16m7-8A7 7 0 1 1 1 8a7 7 0 0 1 14 0"/>
                        </svg>
                        </li>
                    </ul>
                    <ul>
                        <li>일정/예약
                        </li>
                    </ul>
                </div>


                <div class="icon">
                    <ul>
                        <li><span class="material-symbols-outlined">person</span>
                        </li>
                    </ul>
                    <ul>
                        <li>홈
                        </li>
                    </ul>
                </div>

                <div class="icon">
                    <ul>
                        <li><svg xmlns="http://www.w3.org/2000/svg"  width="25" height="25"  fill="currentColor" class="bi bi-briefcase-fill" viewBox="0 0 16 16">
                            <path d="M6.5 1A1.5 1.5 0 0 0 5 2.5V3H1.5A1.5 1.5 0 0 0 0 4.5v1.384l7.614 2.03a1.5 1.5 0 0 0 .772 0L16 5.884V4.5A1.5 1.5 0 0 0 14.5 3H11v-.5A1.5 1.5 0 0 0 9.5 1zm0 1h3a.5.5 0 0 1 .5.5V3H6v-.5a.5.5 0 0 1 .5-.5"/>
                            <path d="M0 12.5A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5V6.85L8.129 8.947a.5.5 0 0 1-.258 0L0 6.85z"/>
                        </svg>
                        </li>
                    </ul>
                    <ul>
                        <li>조직도
                        </li>
                    </ul>
                </div>
            </div>


            <div class="main">

                <div class="header">

                    <div class="logo">
                    <img src="image/로그인로고.PNG" class="fit"> </div>
<%--                    <button class="bellBtn"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="18" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">--%>
<%--                        <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2M8 1.918l-.797.161A4 4 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4 4 0 0 0-3.203-3.92zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5 5 0 0 1 13 6c0 .88.32 4.2 1.22 6"/>--%>
<%--                    </svg></button>--%>
<%--                    <input type="text" placeholder="검색" />--%>
                    <div class="profile">
         <span class="photo">
              <a href="/mypage/{employeeId}">
                <img class="profileIcon" src="${employee.profileImg}" />
                  <!-- 세션에서 이미지 불러오기 -->
              </a>
            </span>
                    </div> -->
                </div>
                <div class="boxContents">
                    <div class=leftContents">
                        <div class="logbox">
                            <div class="imgBox">

                            </div>

                            <div class="information">
                                <!-- ${login.name} 사원
                                     ${login.part} 부
                                     ${login.mail}  -->
                                홍길동 사원<br>
                                인사부<br>
                                test@gmail.com

                            </div>

                        </div>
                        <div class="loginlist ViWidthL">최근 로그인 내역</div>
                        <div class="calenderBox ViWidthL"  id='calendar'>캘린더



                        </div>
                    </div>

                    <div class="centerContents">
                        <div class="boardBox">게시판 목록
                            <div class="boardlist">
                                <h3>최근 게시물 들어올 자리 !</h3>
                                <table>
                                    <thead>
                                    <tr id="title">

                                    </tr>
                                    </thead>
                                    <tbody id="latestboard">
                                    </tbody>
                                </table>
                            </div>
                        </div>

                        <div class="v">나의 결재 대기 문서함</div>
                    </div>

                    <div class="rightContents">
                        <div class="btnBox">
                            <button type="button" class="btn btn-primary"
                                    style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: 1.1rem; background-color: #ffffff; color: black; display: inline-block; ">

                                <svg xmlns="http://www.w3.org/2000/svg"  width="20" height="20" fill="currentColor" class="bi bi-clipboard2" viewBox="0 0 16 16">
                                    <path d="M3.5 2a.5.5 0 0 0-.5.5v12a.5.5 0 0 0 .5.5h9a.5.5 0 0 0 .5-.5v-12a.5.5 0 0 0-.5-.5H12a.5.5 0 0 1 0-1h.5A1.5 1.5 0 0 1 14 2.5v12a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 14.5v-12A1.5 1.5 0 0 1 3.5 1H4a.5.5 0 0 1 0 1z"/>
                                    <path d="M10 .5a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5.5.5 0 0 1-.5.5.5.5 0 0 0-.5.5V2a.5.5 0 0 0 .5.5h5A.5.5 0 0 0 11 2v-.5a.5.5 0 0 0-.5-.5.5.5 0 0 1-.5-.5"/>
                                </svg>     게시글 작성
                            </button>
                            <a href="mail/write">
                            <button type="button" class="btn btn-primary"
                                    style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: 1.1rem; background-color: #ffffff; color: black; display: inline-block; ">
                                <svg xmlns="http://www.w3.org/2000/svg"  width="20" height="20" fill="currentColor" class="bi bi-envelope" viewBox="0 0 16 16">
                                    <path d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1zm13 2.383-4.708 2.825L15 11.105zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741M1 11.105l4.708-2.897L1 5.383z"/>
                                </svg>
                                메일 작성
                            </button></a>
                            <button type="button" class="btn btn-primary"
                                    style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: 1.1rem; background-color:  #ffffff; color: black; display:inline-block;">
                                <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16">
                                    <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                                    <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/>
                                </svg>
                                결재 작성
                            </button>

                            <button type="button" class="btn btn-primary"
                                    style="--bs-btn-padding-y: .25rem; --bs-btn-padding-x: .5rem; --bs-btn-font-size: 1.1rem; background-color: #ffffff; color: black;display: inline-block;">

                                <svg xmlns="http://www.w3.org/2000/svg"  width="20" height="20"  fill="currentColor" class="bi bi-briefcase-fill" viewBox="0 0 16 16">
                                    <path d="M6.5 1A1.5 1.5 0 0 0 5 2.5V3H1.5A1.5 1.5 0 0 0 0 4.5v1.384l7.614 2.03a1.5 1.5 0 0 0 .772 0L16 5.884V4.5A1.5 1.5 0 0 0 14.5 3H11v-.5A1.5 1.5 0 0 0 9.5 1zm0 1h3a.5.5 0 0 1 .5.5V3H6v-.5a.5.5 0 0 1 .5-.5"/>
                                    <path d="M0 12.5A1.5 1.5 0 0 0 1.5 14h13a1.5 1.5 0 0 0 1.5-1.5V6.85L8.129 8.947a.5.5 0 0 1-.258 0L0 6.85z"/>
                                </svg>
                                보고서 작성
                            </button>

                        </div>
                        <div class="birthBox">
                            생일
                        </div>
                    </div>
                </div>

            </div>

        </div>

        </body>
        </html>

    </c:otherwise>
</c:choose>



