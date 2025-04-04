<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/views/template/header.jsp" />

<link rel="stylesheet" href="/css/write.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/js/summernote/summernote-lite.css">
<div class="boardmain">
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


            <jsp:include page="/WEB-INF/views/template/fileInput.jsp" />
            <div class="card-header">
                <textarea id="contents"></textarea>
            </div>
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
</div>
            <script src="/js/main/write.js" type="text/javascript">
                <script src="/js/template/summernote.js" type="text/javascript"></script>
            <script>
                $(document).ready(() => {
                    $('#contents').summernote(summernoteSetting());
                })
            </script>
<jsp:include page="/WEB-INF/views/template/footer.jsp" />
