<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
</div>
<style>
    /* 채팅 버튼 스타일 */
    .chat-button {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 60px;
        height: 60px;
        border-radius: 50%;
        border: none;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
        box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
        z-index: 1000;
        transition: transform 0.2s;
    }

    .chat-button:hover {
        transform: scale(1.1);
    }

    .chat-button .material-icons{
        font-size: 28px;
    }

    /* 채팅 모달 스타일 */
    .chat-modal {
        display: none;
        position: fixed;
        bottom: 90px; /* 채팅 버튼 위로 */
        right: 20px;
        width: 100%;
        max-width: 360px; /* 모바일 화면 기준 */
        height: 70vh;
        background-color: white;
        border-radius: 12px;
        box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
        z-index: 999;
        overflow: hidden;
    }

    /* flex 관련 스타일을 별도의 클래스로 분리 */
    .chat-modal.active {
        display: flex;
        flex-direction: column;
    }

    .chat-header {
        padding: 15px;
        background-color: #2c3e50;
        color: white;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .chat-header h3 {
        margin: 0;
        font-size: 18px;
    }

    .close-chat {
        background: none;
        border: none;
        color: white;
        cursor: pointer;
        padding: 5px;
    }

    .chat-content {
        flex: 1;
        display: flex;
        flex-direction: column;
        height: calc(100% - 60px);
    }

    .chat-messages {
        flex: 1;
        overflow-y: auto;
        padding: 20px;
    }

    .chat-input-area {
        padding: 15px;
        border-top: 1px solid #eee;
        display: flex;
        gap: 10px;
    }

    .chat-input-area input {
        flex: 1;
        padding: 10px;
        border: 1px solid #ddd;
        border-radius: 20px;
        outline: none;
    }

    .chat-input-area button {
        background-color: #2c3e50;
        color: white;
        border: none;
        border-radius: 50%;
        width: 40px;
        height: 40px;
        cursor: pointer;
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .chat-container {
        display: flex;
        height: calc(100% - 60px); /* 헤더 높이 제외 */
        position: relative;
    }

    .chat-sidebar {
        position: absolute;
        right: 0;
        width: 280px;
        height: 100%;
        border-left: 1px solid #eee;
        background: white;
        z-index: 2;
    }

    .chat-nav {
        width: 60px;
        background: #f8f9fa;
        border-left: 1px solid #eee;
        display: flex;
        flex-direction: column;
        align-items: center;
        padding-top: 20px;
    }

    .nav-icon {
        width: 40px;
        height: 40px;
        display: flex;
        align-items: center;
        justify-content: center;
        border-radius: 50%;
        margin-bottom: 10px;
        cursor: pointer;
    }

    .nav-icon.active {
        background: #2c3e50;
        color: white;
    }


    .nav-icon .material-icons {
        margin-right: 5px;
        font-size: 20px;
    }

    .chat-room {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        display: flex;
        flex-direction: column;
    }

    .chat-room .chat-header {
        padding: 15px;
        display: flex;
        align-items: center;
    }

    .chat-room .back-button {
        background: none;
        border: none;
        color: white;
        cursor: pointer;
        margin-right: 10px;
    }

    /* 채팅 컨텐츠 영역 조정 */
    .chat-content {
        flex: 1;
        display: flex;
        flex-direction: column;
        overflow: hidden;
    }

    .chat-content.full-width {
        padding-right: 0;
    }

    .chat-sidebar {
        width: 280px;
        border-right: 1px solid #eee;
        display: flex;
        flex-direction: column;
    }

    .search-box {
        padding: 15px;
        border-bottom: 1px solid #eee;
    }

    .search-box input {
        width: 100%;
        padding: 8px;
        border: 1px solid #ddd;
        border-radius: 20px;
        outline: none;
    }

    .employee-list {
        flex: 1;
        overflow-y: auto;
    }

    .employee-item {
        padding: 15px;
        display: flex;
        align-items: center;
        cursor: pointer;
        transition: background-color 0.2s;
    }

    .employee-item:hover {
        background-color: var(--md-sys-color-surface-container);
    }

    .employee-avatar {
        width: 40px;
        height: 40px;
        border-radius: 50%;
        margin-right: 12px;
        background-color: #ddd;
    }

    .employee-info {
        flex: 1;
    }

    .employee-name {
        font-weight: bold;
        margin-bottom: 4px;
    }

    .employee-position {
        font-size: 12px;
        color: #666;
    }

    /* 모바일 반응형 */
    @media (max-width: 768px) {
        .chat-modal {
            width: calc(100% - 40px);
            right: 20px;
            bottom: 90px;
        }
    }
</style>
<button id="chatButton" class="chat-button surface-bright">
    <span class="material-icons">chat</span>
</button>

<div id="chatModal" class="chat-modal surface-bright">
    <div class="chat-header">
        <h3>채팅</h3>
        <button class="close-chat">
            <span class="material-icons">close</span>
        </button>
    </div>
    <div class="chat-container">
        <!-- 오른쪽 네비게이션 영역 -->
        <div class="chat-nav">
            <div class="nav-icon active" data-view="employees">
                <span class="material-icons">people</span>
            </div>
            <div class="nav-icon" data-view="rooms">
                <span class="material-icons">forum</span>
            </div>
        </div>
        <!-- 메인 컨텐츠 영역 -->
        <div class="chat-content">
            <div class="search-box">
                <input type="text" placeholder="사원 검색...">
            </div>
            <div class="employee-list">
                <!-- 사원 목록이 여기에 동적으로 생성됨 -->
            </div>
        </div>

        <!-- 채팅방 영역 (처음에는 숨겨져 있음) -->
        <div class="chat-room" style="display: none;">
            <div class="chat-header">
                <button class="back-button">
                    <span class="material-icons">arrow_back</span>
                </button>
                <h3 id="chat-user-title"></h3>
            </div>

            <div class="chat-messages"></div>
            <div class="chat-input-area">
                <input type="text" placeholder="메시지를 입력하세요..." id="chat-input">
                <button>
                    <span class="material-icons">send</span>
                </button>
            </div>
        </div>
    </div>
</div>
<input type="hidden" id="selected-employee-id" value="">
<script>
    $(document).ready(function() {
        let ws = new WebSocket("ws://10.10.55.9/chat");
        ws.onmessage = function (e) {
            let msg = JSON.parse(e.data);
            let chat = $("<div>").addClass("chat").html(msg.sender + " : " + msg.message);
            $(".chat-area").append(chat);
        }

        let employees = [];
        $.ajax({
            url:"/messenger/employeeListAll"
        }).done(function (resp) {
            let list = resp.employeeListAll;
            for (let i = 0; i < list.length; i++) {
                let position = list[i].teamName + " " + list[i].jobName;
                employees.push ({
                    id: list[i].id,
                    name: list[i].name,
                    position: position
                });
            }
            renderEmployeeList();
        });

        // 임시 사원 데이터
        // const employees = [
        //     { id: 1, name: '김철수', position: '개발팀장' },
        //     { id: 2, name: '이영희', position: '선임개발자' },
        //     { id: 3, name: '이영희', position: '선임개발자' },
        //     { id: 4, name: '이영희', position: '선임개발자' },
        //     { id: 5, name: '이영희', position: '선임개발자' },
        //     { id: 6, name: '이영희', position: '선임개발자' },
        // ];

        const chatButton = $('#chatButton');
        const chatModal = $('#chatModal');
        const closeChat = $('.close-chat');
        const employeeList = $('.employee-list');
        const chatContent = $('.chat-content');
        const chatInput = $('#chat-input');
        const sendButton = $('.chat-input-area button');

        let isModalOpen = true; // 모달 상태를 추적하는 변수

        chatButton.on('click', function(e) {
            e.stopPropagation(); // 이벤트 버블링 방지
            isModalOpen = !isModalOpen;

            if(isModalOpen) {
                chatModal.addClass('active');
            } else {
                chatModal.removeClass('active');
            }
        });

        closeChat.on('click', function(e) {
            e.stopPropagation(); // 이벤트 버블링 방지
            isModalOpen = false;
            chatModal.removeClass('active');
        });

        function sendMessage() {
            const message = chatInput.val().trim();
            if (message) {
                chatInput.val('');
            }
            const selectedId = $('#selected-employee-id').val();
            const payload = {
                id: selectedId,
                message: message
            };
            ws.send(JSON.stringify(payload));
        }

        sendButton.on('click', sendMessage);

        chatInput.on('keydown', function(e) {
            if (e.key === 'Enter') {
                sendMessage();
            }
        });

        const makeChatEmployeeList = (employee, index) => {
            const div = $('<div>').addClass('employee-item').attr('data-id', employee.id).attr('data-name', employee.name);
            const avatar = $('<div>')
                .addClass('employee-avatar')
                .css('background-image', "url('https://picsum.photos/200/" + (index + 1) + "')");
            const info = $('<div>').addClass('employee-info');
            const name = $('<div>').addClass('employee-name').html(employee.name);
            const position = $('<div>').addClass('employee-position').text(employee.position);

            info.append(name, position);
            div.append(avatar, info);
            return div;
        }

        // 사원 목록 렌더링
        function renderEmployeeList(data) {
            const listData = data || employees;
            employeeList.empty();
            listData.forEach((employee, index) => {
                employeeList.append(makeChatEmployeeList(employee, index));
            });
        }

        // 사원 클릭 이벤트 처리
        // employeeList.on('click', function(e) {
        //     const employeeItem = e.target.closest('.employee-item');
        //     if (employeeItem) {
        //         const employeeId = employeeItem.dataset.id;
        //         showChatRoom(employeeId);
        //     }
        // });


        // 검색 기능
        const searchInput = $('.search-box input');
        searchInput.on('input', function(e) {
            const searchTerm = e.target.value.toLowerCase();
            const filteredEmployees = employees.filter(emp =>
                emp.name.toLowerCase().includes(searchTerm) ||
                emp.position.toLowerCase().includes(searchTerm)
            );
            // 필터링된 결과로 목록 다시 렌더링
            renderEmployeeList(filteredEmployees);
        });

        // 네비게이션 전환 기능
        $('.nav-icon').on('click', function() {
            const view = $(this).data('view');

            // 네비게이션 아이콘 활성화
            $('.nav-icon').removeClass('active');
            $(this).addClass('active');

            // 컨텐츠 전환
            $('.view-content').removeClass('active');
            if(view === 'employees') {
                $('.employee-list').addClass('active');
            } else {
                $('.room-list').addClass('active');
            }
        });

        $(document).on('click', '.employee-item', function() {
            const employeeId = $(this).data('id');
            const employeeName = $(this).data('name');
            $('#selected-employee-id').val(employeeId);
            showChatRoom(employeeId, employeeName);
        });

        function showChatRoom(employeeId, employeeName) {
            // 채팅방 헤더 생성
            if (window.innerWidth <= 768) {
                $('.chat-sidebar').css('display', 'none');
            }
            chatContent.css('display', 'flex');
            // 선택된 사원 하이라이트
            $('.employee-item').each(function() {
                $(this).removeClass('active');
                if ($(this).data('id') === employeeId) {
                    $(this).addClass('active');
                }
            });

            $('#chat-user-title').text(employeeName);

            // 채팅방 표시
            $('.chat-content, .chat-nav').hide();
            $('.chat-room').show();

            // 뒤로가기 버튼 이벤트
            $('.back-button').on('click', function() {
                $('.chat-room').hide();
                $('.chat-content, .chat-nav').show();
            });
        }
        // 네비게이션 아이콘 클릭 이벤트
        $('.nav-icon').on('click', function() {
            $('.nav-icon').removeClass('active');
            $(this).addClass('active');

            const view = $(this).data('view');
            // 여기에 각 뷰에 따른 컨텐츠 전환 로직 추가
        });
        // 초기 렌더링
        // renderEmployeeList();
    });
</script>
</div>
</div>
</div>
</body>
</html>