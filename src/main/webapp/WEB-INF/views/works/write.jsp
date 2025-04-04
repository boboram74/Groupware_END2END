<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/views/template/header.jsp" />

<link rel="stylesheet" href="/css/write.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote.min.js"></script>

<%--<link--%>
<%--        href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css"--%>
<%--        rel="stylesheet"--%>
<%--/>--%>
<%--<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>--%>

<%--<link--%>
<%--        href="https://cdn.jsdelivr.net/npm/summernote@0.9.0/dist/summernote.min.css"--%>
<%--        rel="stylesheet"--%>
<%--/>--%>
<div>
    <form action="file/upload/test" method="post" enctype="multipart/form-data">
        <jsp:include page="/WEB-INF/views/template/fileInput.jsp" />
        <input type="hidden" name="id" value="1">

<div class="boardbox">
    <!-- <h1>작성하기</h1> -->

    <form
            action="/board/add.do"
            method="post"
            enctype="multipart/form-data"
    >
        <input
                type="hidden"
                name="csrfToken"
                value="${csrfToken}"
                id="token"
        />
        <div class="card">
            <div class="choice">
                작업선택
                <select>
                    <option>선택하십시오</option>
                </select>
            </div>
            <div>
                작업상태
                <select>
                    <option>진행중</option>
                    <option>완료</option>
                </select>
            </div>

            <label for="text">제목입력</label>

            <input
                    type="text"
                    name="title"
                    id="title"
                    placeholder="제목을 입력해주세요"
                    required
            />

            <label for="file">파일 첨부</label>
            <input
                    type="file"
                    name="file2"
                    accept="image/*, .pdf, .docx"
            />

            <div class="card-header">내용 입력</div>
            <input type="hidden" name="contents" id="input-contents" />
            <div class="card-body" id="contents"></div>
        </div>
        <div id="buttonbox">
            <button class="button" id="writebtn" type="submit">
                작성완료
            </button>
            <a href="/board/list.do">
                <button class="button" id="listbtn" type="button">
                    목록으로
                </button>
            </a>
        </div>
    </form>
</div>
            <script src="/js/main/write.js" type="text/javascript">

<jsp:include page="/WEB-INF/views/template/footer.jsp" />
