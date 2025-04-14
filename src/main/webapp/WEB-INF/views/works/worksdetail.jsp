<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/views/template/header.jsp" />
<%--<link rel="stylesheet" href="/css/write.css" />--%>

<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/main.min.css" rel="stylesheet">
<!-- FullCalendar JS -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/locales/ko.global.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/js/summernote/summernote-lite.css">
<style>
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
                action="/work/update"+${works.id}
                method="post"
                enctype="multipart/form-data"
        >
            <input type="hidden" name="projectId" value="${projectId}"/>

            <div class="card">
                <div class="choice">
                    작업선택
                    <select name="type">
                        <option value="DOCUMENT" ${works.type == 'DOCUMENT' ? 'selected' : ''}>문서</option>
                        <option value="MEETING_FOLDER" ${works.type == 'MEETING_FOLDER' ? 'selected' : ''}>회의록</option>
                        <option value="SPECIFICATION" ${works.type == 'SPECIFICATION' ? 'selected' : ''}>명세서</option>
                        <option value="REPORT" ${works.type == 'REPORT' ? 'selected' : ''}>보고서</option>
                        <option value="WBS" ${works.type == 'WBS' ? 'selected' : ''}>WBS</option>
                    </select>

                </div>
                <div>
                    우선순위
                    <select name="priority">
                        <option value="HIGH" ${works.priority == 'HIGH' ? 'selected' : ''}>높음</option>
                        <option value="MIDDLE" ${works.priority == 'MIDDLE' ? 'selected' : ''}>중간</option>
                        <option value="LOW" ${works.priority == 'LOW' ? 'selected' : ''}>낮음</option>
                    </select>
                </div>
                <div>
                    작업상태
                    <select name="state">
                        <option value="READY" ${works.state == 'READY' ?  'selected' : ''}>프로젝트 진행 전 작업</option>
                        <option value="ONGOING" ${works.state == 'ONGOING' ? 'selected' : ''}>프로젝트 진행중</option>
                        <option value="FINISH" ${works.state == 'FINISH' ? 'selected' : ''}>완료</option>
                    </select>

                </div>
                <div>

                    <div class="deadLineContents">마감일
                        <input type="date" name="deadLine" value="${works.deadLine}"></div>
                    <input type="hidden" id="deadLineContents" name="deadLine"/>
                </div>

                <label>제목입력</label>

                <input
                        type="text"
                        name="title"
                        id="title"
                        placeholder=${works.title}
                />


                <jsp:include page="/WEB-INF/views/template/fileInput.jsp" />
                <div class="card-header">

                    <textarea id="contents" name="content" >
                        ${works.content}
                    </textarea>

                </div>
            </div>
            <div id="buttonbox">
                <button class="button" id="writebtn" type="submit">
                    수정완료
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

<script src="/js/template/summernote.js" type="text/javascript"></script>
<script src="/js/main/write.js" type="text/javascript" />


<jsp:include page="/WEB-INF/views/template/footer.jsp" />