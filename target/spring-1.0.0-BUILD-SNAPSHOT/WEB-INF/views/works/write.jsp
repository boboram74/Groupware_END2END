<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/views/template/header.jsp"/>
<link rel="stylesheet" href="/css/template/exam.css"/>

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

    textarea {
        height: 300px;
        resize: none;
        width: 100%;
        padding: 14px;
        margin-top: 10px;
        font-size: 16px;
        color: black;
        background-color: white;
    }

    .boardmain {
     width: 100%;
        overflow-y: auto !important;
        padding: 20px;

        min-height: calc(100vh - 100px);
    }

    .boardbox {
        width: 100%;
        max-width: 1200px;
        background: white;
        box-shadow: 0 1px 3px rgba(0,0,0,0.1);
        border-radius: 8px;
        padding: 30px;
    }

    .card {
        margin-bottom: 20px;
    }

    /* 셀렉트 박스와 입력 영역을 그리드로 구성 */
    .form-grid {
        display: grid;
        grid-template-columns: repeat(4, 1fr);
        gap: 15px;
        margin-bottom: 20px;
    }

    .form-group {
        display: flex;
        flex-direction: column;
    }

    .form-group label {
        font-weight: bold;
        margin-bottom: 5px;
        color: #333;
    }

    .form-group select,
    .form-group input[type="date"] {
        width: 100%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 14px;
    }

    .title-section {
        margin-bottom: 20px;
    }

    .title-section label {
        display: block;
        font-weight: bold;
        margin-bottom: 8px;
        color: #333;
    }

    #title {
        width: 100%;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
    }

    .file-upload-section {
        margin-bottom: 20px;
    }

    .content-section {
        margin-bottom: 20px;
    }

    .note-editor.note-frame {
        border: 1px solid #ddd;
        border-radius: 4px;
    }

    /*.note-editable {*/
    /*    height: 900px !important; !* 고정 높이 *!*/
    /*    max-height: 400px !important;*/
    /*    overflow-y: auto !important; !* 내용이 많을 때 스크롤 *!*/
    /*    background-color: white;*/
    /*}*/

    #buttonbox {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin-top: 20px;
    }

    .button {
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        font-size: 14px;
        cursor: pointer;
        transition: background-color 0.3s;
    }

    #writebtn {
        background-color: #007bff;
        color: white;
    }

    #writebtn:hover {
        background-color: #0056b3;
    }

    #listbtn {
        background-color: #f8f9fa;
        color: #212529;
        border: 1px solid #ddd;
    }

    #listbtn:hover {
        background-color: #e9ecef;
    }

    /* 반응형 디자인 */
    @media (max-width: 1024px) {
        .form-grid {
            grid-template-columns: repeat(2, 1fr);
        }
    }

    @media (max-width: 768px) {
        .boardmain {
            margin-left: 0;
            padding: 10px;
        }

        .form-grid {
            grid-template-columns: 1fr;
        }
    }
</style>

<div class="mainContainer">
    <div class="mainHeader surface-bright">
        <div class="detail-menu-header">
            <div class="detail-menu-title">
                <span class="material-icons">mail</span>
                <span>Works</span>
            </div>
            <button class="detail-menu-toggle-btn">
                <span class="material-icons">menu</span>
            </button>
        </div>
        <div class="detail-menu-modal">
            <ul class="detail-menu-list">
                <li class="detail-menu-item" onclick="location.href='/project/main'">
                    <span class="material-icons">star</span>
                    <span>Works 메인</span>
                </li>

            </ul>
            <button class="detail-modal-close">
                <span class="material-icons">close</span>
            </button>
        </div>
    </div>

    <div class="boardmain">
        <div class="boardbox">
            <form action="/work/insert" method="post" enctype="multipart/form-data" id="workForm">
                <input type="hidden" name="projectId" value="${projectId}"/>

                <div class="card">
                    <!-- 셀렉트 박스들을 그리드로 정렬 -->
                    <div class="form-grid">
                        <div class="form-group">
                            <label for="type">작업선택</label>
                            <select name="type" id="type">
                                <option value="DOCUMENT">문서</option>
                                <option value="MEETING_FOLDER">회의록</option>
                                <option value="SPECIFICATION">명세서</option>
                                <option value="REPORT">보고서</option>
                                <option value="WBS">WBS</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="priority">우선순위</label>
                            <select name="priority" id="priority">
                                <option value="HIGH">높음</option>
                                <option value="MIDDLE">중간</option>
                                <option value="LOW">낮음</option>
                            </select>
                        </div>

                        <div class="form-group">
                            <label for="state">작업상태</label>
                            <select name="state" id="state">
                                <option value="READY">프로젝트 진행 전 작업</option>
                                <option value="ONGOING">프로젝트 진행중</option>
                                <option value="FINISH">완료</option>
                            </select>
                        </div>

                        <div class="form-group">

                            <input type="hidden" name="deadLine" id="deadLine" value="${dto.deadLine}">
                        </div>
                    </div>

                    <!-- 제목 입력 -->
                    <div class="title-section">
                        <label for="title">제목입력</label>
                        <input type="text" name="title" id="title" placeholder="제목을 입력해주세요">
                    </div>

                    <!-- 파일 업로드 -->
                    <div class="file-upload-section">
                        <jsp:include page="/WEB-INF/views/template/fileInput.jsp"/>
                    </div>

                    <!-- 내용 입력 -->
                    <div class="content-section">
                        <textarea id="contents" name="content"></textarea>
                    </div>
                </div>

                <!-- 버튼 영역 -->
                <div id="buttonbox">
                    <button class="button" id="writebtn" type="submit">작성완료</button>
                    <a href="/board/list.do">
                        <button class="button" id="listbtn" type="button">목록으로</button>
                    </a>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
    $(document).ready(function() {
        // Summernote 초기화 with 고정 높이
        $('#contents').summernote({
            height: 600, // 고정 높이 400px
            lang: 'ko-KR',
            placeholder: '내용을 입력하세요...',
            toolbar: [
                ['style', ['style']],
                ['font', ['bold', 'underline', 'clear']],
                ['color', ['color']],
                ['para', ['ul', 'ol', 'paragraph']],
                ['table', ['table']],
                ['insert', ['link', 'picture', 'video']],
                ['view', ['fullscreen', 'codeview', 'help']]
            ],
            callbacks: {
                onInit: function() {
                    // 에디터 초기화 후 스타일 적용
                    $('.note-editable').css({
                        'height': '400px',
                        'max-height': '400px',
                        'overflow-y': 'auto'
                    });
                }
            }
        });
    });

    $('#workForm').submit(function (event) {
        const title = $('#title').val().trim();
        const deadLine = $('#deadLine').val();
        const content = $('#contents').val().trim();

        if (!title || !deadLine ) {
            alert("모든 필드를 입력해 주세요! 마감일과 제목을 설정해야 합니다.");
            event.preventDefault();
        }
    });
</script>
<script src="/js/template/summernote.js" type="text/javascript"></script>
<script src="/js/main/write.js" type="text/javascript"></script>

<jsp:include page="/WEB-INF/views/template/footer.jsp"/>