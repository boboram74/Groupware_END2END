<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons"/>
<style>
    * {
        box-sizing: border-box;
    }

    .mainHeader {
        position: fixed;
        left: 60px;
        top: 0;
        width: 250px;
        height: 100vh;
        background-color: #fff;
        border-right: 1px solid #e0e0e0;
        z-index: 100;
        margin-top: 20px;
        transition: none;
    }

    .mainContainer {
        margin-left: 310px;
        width: calc(100% - 310px);
        min-height: 100vh;
        background-color: #fff;
        padding: 20px;
        display: flex;
        justify-content: center;
        transition: none;
    }

    .mainBody {
        max-width: 1200px;
        width: 100%;
        padding: 0 20px;
    }

    .title {
        width: 100%;
        padding: 20px;
    }

    .title span {
        font-size: 60px;
    }

    .title h2 {
        display: flex;
        align-items: center;
        margin: 0;
    }

    .title h2 .material-icons {
        font-size: 65px;
        margin-right: 8px;
    }

    .search {
        margin-bottom: 20px;
        display: flex;
        gap: 10px;
        align-items: center;
    }

    #searchOption {
        height: 100%;
    }

    .searchInput {
        width: 30%;
    }

    #input {
        padding: 10px;
        width: 100%;
        height: 100%;
    }

    #searchBtn {
        display: flex;
        align-items: center;
        justify-content: center;
    }

    #searchBtn span {
        font-size: 20px;
    }

    .content {
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        background-color: white;
    }

    .pageNavi {
        width: 100%;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 20px;
    }

    /* 반응형 디자인 */
    @media (max-width: 768px) {
        .mainHeader {
            position: relative;
            left: 0;
            width: 100%;
            height: auto;
        }

        .mainContainer {
            margin-left: 0;
            width: 100%;
        }
    }
</style>
<div class="mainHeader">
    <div class="title">
        <h2><span class="material-icons">mail</span>제목</h2>
    </div>
</div>

<div class="mainContainer">
    <div class="mainBody">
        <div class="search">
            <div>
                <select id="searchOption">
                    <option>선택</option>
                    <option>선택</option>
                    <option>선택</option>
                </select>
            </div>
            <div class="searchInput">
                <input id="input" type="text" name="keyword" placeholder="검색어 입력">
            </div>
            <div>
                <button id="searchBtn"><span class="material-icons">search</span> 검색</button>
            </div>
        </div>
        <div class="content">
            출력 공간(높이 주지말고 컨텐츠 내용에 따라 유동적으로 증가하게 두세요)
        </div>
        <div class="pageNavi">
            1 2 3 4 5 6 7 8 9 10
        </div>
    </div>
</div>

<script src="/js/main/contact.js" type="text/javascript"></script>
<jsp:include page="/WEB-INF/views/template/footer.jsp"/>