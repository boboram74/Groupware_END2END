<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/views/template/header.jsp" />
<%--<link rel="stylesheet" href="/css/write.css" />--%>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/main.min.css" rel="stylesheet">


<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/js/summernote/summernote-lite.css">

<style>
    * {
        box-sizing: border-box;
        font-family: 'Malgun Gothic', sans-serif;
    }
    table {
        width: 100%;
        border-collapse: collapse;
        border-top: 1px solid #ccc;
        border-bottom: 1px solid #ccc;
    }


    textarea{
        height: 300px;
        resize: none;
        width: 100%;
        padding: 14px;
        margin-top: 10px;
        font-size: 16px;
        color: black;
        background-color: white;
    }
</style>
<div class="boardmain">
    <div class="boardbox">
        <!-- <h1>작성하기</h1> -->

        <form
                action="/work/insert"
                method="post"
                enctype="multipart/form-data"
        >
        <input type="hidden" name="projectId" value="${projectId}"/>


            <div class="card">
                <div class="choice">
                    작업선택
                    <select name="type">
                        <option value="DOCUMENT">문서</option>
                        <option value="MEETING_FOLDER">회의록</option>
                        <option value="SPECIFICATION">명세서</option>
                        <option value="REPORT">보고서</option>
                        <option value="WBS">WBS</option>

                    </select>
                </div>
                <div>
                    우선순위
                    <select name="priority">
                        <option value="HIGH">높음</option>
                        <option value="MIDDLE">중간</option>
                        <option value="LOW">낮음</option>
                    </select>
                </div>
                <div>
                    작업상태
                    <select name="state">
                        <option value="READY">프로젝트 진행 전 작업</option>
                        <option value="ONGOING">프로젝트 진행중</option>
                        <option value="FINISH">완료</option>
                    </select>

                </div>
                <div>

                    <div class="deadLineContents">마감일
                        <input type="date" name="deadLine"></input></div>
                    <input type="hidden" id="deadLineContents" name="deadLine"/>
                </div>

                <label for="text">제목입력</label>

                <input
                        type="text"
                        name="title"
                        id="title"
                        placeholder="제목을 입력해주세요"

                />


                <jsp:include page="/WEB-INF/views/template/fileInput.jsp" />
                <div class="card-header">

                    <textarea id="contents" name="content"></textarea>

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
<script>

    $('#workForm').submit(function(event) {

        const title = $('#title').val().trim();
        const deadLine = $('#deadLine').val();
        const content = $('#contents').val().trim();

        if (!title || !deadLine || !content) {
            alert("모든 필드를 입력해 주세요! 마감일과 제목을 설정해야 합니다.");
            event.preventDefault();  // 여기 작동안함
        }
    });
</script>
<script src="/js/template/summernote.js" type="text/javascript"></script>
<script src="/js/main/write.js" type="text/javascript" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>  <!-- jQuery 라이브러리 추가 -->




<jsp:include page="/WEB-INF/views/template/footer.jsp" />