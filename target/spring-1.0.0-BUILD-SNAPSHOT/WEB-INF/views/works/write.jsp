<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:include page="/WEB-INF/views/template/header.jsp" />

<link rel="stylesheet" href="/css/write.css">
<link href="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/main.min.css" rel="stylesheet">
<!-- FullCalendar JS -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/locales/ko.global.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="/js/summernote/summernote-lite.js"></script>
<script src="/js/summernote/lang/summernote-ko-KR.js"></script>
<link rel="stylesheet" href="/js/summernote/summernote-lite.css">
<style>

    .modal {
        display: none;
        position: fixed;
        z-index: 1000;
        left: 0;
        top: 0;
        width: 100%;
        height: 100%;
        background-color: rgba(0,0,0,0.5);
    }

    .modalContent {
        background-color: #fefefe;
        margin: 15% auto;
        padding: 20px;
        border: 1px solid #888;
        width: 80%;
        max-width: 500px;
        border-radius: 5px;
        position: relative;
    }
    .dateSelectWrapper {
        display: flex;
        flex-direction: column;
        gap: 15px;
        padding: 15px 0;
    }

    .dateInput {
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 4px;
        font-size: 16px;
        width: 100%;
    }

    .buttonWrapper {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin-top: 10px;
    }

    .modalBtn {
        padding: 8px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        font-size: 14px;
        font-weight: 500;
    }

    .confirmBtn {
        background-color: #007bff;
        color: white;
    }

    .confirmBtn:hover {
        background-color: #0056b3;
    }

    .cancelBtn {
        background-color: #6c757d;
        color: white;
    }

    .cancelBtn:hover {
        background-color: #5a6268;
    }

    .close {
        color: #aaa;
        float: right;
        font-size: 28px;
        font-weight: bold;
        cursor: pointer;
    }

    .close:hover {
        color: black;
    }
/* 폼 행 */
.formRow {
margin-bottom: 20px;
display: flex;
flex-direction: column;
}

/* 라벨 */
.inputDate,
.inputContent,
.addBook {
display: flex;
align-items: center;
margin-right: 15px;
}

/* 입력 그룹 */
.formInputDate,
.formInputContent,
.formInputBook {
display: flex;
align-items: center;
gap: 8px;
}

/* 입력 필드 */
input[type="datetime-local"],
textarea {
padding: 8px;
font-size: 14px;
border: 1px solid #ccc;
border-radius: 6px;
width: 100%;
box-sizing: border-box;
}

.formInputBook input {
padding: 8px;
font-size: 14px;
border: 1px solid #ccc;
border-radius: 6px;
width: 100%;
box-sizing: border-box;
}

.readOnly {
background-color: #f5f5f5;
}

textarea {
resize: vertical;
height: 80px;
}

/* 구분선 */
.separator {
font-size: 16px;
}

/* 등록 버튼 */
.submitBtn {
background-color: #aaa;
color: white;
border: none;
border-radius: 6px;
padding: 10px;
cursor: pointer;
float: right;
font-size: 16px;
margin-top: 10px;
transition: background-color 0.3s;
}

.submitBtn:hover {
background-color: #0056b3;
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
                <select name="status">
                    <option value="ONGOING">진행중</option>
                    <option value="FINISH">완료</option>
                </select>

            </div>
            <div>
                <button id="openModalBtn" type="button">마감일자선택</button>
                <div class="deadLineContents">마감일 </div>
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


<!-- 모달 창 수정 -->
<div class="modal" id="deadlineModal">
    <div class="modalContent">
        <span class="close">&times;</span>
        <h3>마감일자 선택</h3>
        <div class="dateSelectWrapper">
            <input type="datetime-local" id="deadlineDate" class="dateInput">
            <div class="buttonWrapper">
                <button type="button" id="cancelDate" class="modalBtn cancelBtn">취소</button>
                <button type="button" id="confirmDate" class="modalBtn confirmBtn">확인</button>
            </div>
        </div>
    </div>
</div>
            <script src="/js/main/write.js" type="text/javascript">
                <script src="/js/template/summernote.js" type="text/javascript"></script>
            <script>
                $(document).ready(function() {
                    // 모달 열기
                    $('#openModalBtn').on('click', function() {
                        console.log('모달 열기 버튼 클릭됨'); // 디버깅용
                        $('#deadlineModal').show();
                    });

                    // 모달 닫기 (X 버튼)
                    $('.close').on('click', function() {
                        $('#deadlineModal').hide();
                    });
                    // 취소 버튼 클릭
                    $('#cancelDate').on('click', function() {
                        $('#deadlineModal').hide();
                    });

                    // 확인 버튼 클릭
                    $('#confirmDate').on('click', function() {
                        const selectedDate = $('#deadlineDate').val();

                        if (!selectedDate) {
                            alert('마감일자를 선택해주세요.');
                            return;
                        }

                        // 날짜 형식 변환
                        const formattedDate = new Date(selectedDate).toLocaleString('ko-KR', {
                            year: 'numeric',
                            month: 'long',
                            day: 'numeric',
                            hour: '2-digit',
                            minute: '2-digit'
                        });

                        // 선택된 날짜 표시
                        $('.deadLineContents').text(formattedDate);

                        // hidden input에 값 설정
                        $('#deadLineContents').val(selectedDate);

                        // 모달 닫기
                        $('#deadlineModal').hide();
                    });

                    // 모달 외부 클릭 시 닫기
                    $(window).on('click', function(e) {
                        if ($(e.target).is('#deadlineModal')) {
                            $('#deadlineModal').hide();
                        }
                    });
                });

            </script>
<jsp:include page="/WEB-INF/views/template/footer.jsp" />
