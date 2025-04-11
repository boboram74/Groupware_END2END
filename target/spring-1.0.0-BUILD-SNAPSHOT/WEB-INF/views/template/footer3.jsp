<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
        bottom: 90px;
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
        height: calc(100% - 60px);
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
    .unread-badge {
        position: absolute;
        top: -5px;
        right: -5px;
        background-color: #ff4444;
        color: white;
        border-radius: 50%;
        width: 20px;
        height: 20px;
        font-size: 12px;
        display: flex;
        align-items: center;
        justify-content: center;
        font-weight: bold;
        box-shadow: 0 2px 4px rgba(0,0,0,0.2);
    }

    .toast-notification {
        position: fixed;
        bottom: 20px;
        right: 20px;
        background: white;
        padding: 15px;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        z-index: 9999;
        max-width: 300px;
        animation: slideIn 0.3s ease-out;
        border-left: 4px solid #2c3e50;
    }

    @keyframes slideIn {
        from { transform: translateX(100%); opacity: 0; }
        to { transform: translateX(0); opacity: 1; }
    }

    /* 추가할 CSS 스타일 */
    .message {
        margin: 10px 0;
        padding: 10px;
        border-radius: 8px;
        max-width: 80%;
        word-wrap: break-word;
    }

    .my-message {
        background-color: #e3f2fd;
        margin-left: auto;
        text-align: right;
    }

    .other-message {
        background-color: #f1f1f1;
        margin-right: auto;
    }

    .sender-name {
        font-weight: bold;
        margin-bottom: 5px;
    }

    .message-time {
        font-size: 0.8em;
        color: #666;
        margin-top: 5px;
    }


</style>
<button id="chatButton" class="chat-button surface-bright" style="position: relative;">
    <span class="material-icons">chat</span>
    <span id="unreadBadge" class="unread-badge" style="display: none;"></span>
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

            <!-- 메시지 영역 -->
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
        // WebSocket 관련 변수
        let socket = null;
        let reconnectAttempts = 0;
        const maxReconnectAttempts = 5;
        const reconnectDelay = 3000;

        // 채팅 관련 변수
        let currentUserId = "${sessionScope.userId}";
        let currentUserName = "${sessionScope.userName}";
        let currentRoomId = null;
        let unreadCounts = {}; // {roomId: count} 형식으로 읽지 않은 메시지 저장

        // 초기화 함수
        function init() {
            connectWebSocket();
            setupEventHandlers();
            requestNotificationPermission();
        }

        // WebSocket 연결
        function connectWebSocket() {
            const wsUri = "ws://" + window.location.host + "${pageContext.request.contextPath}/chat";
            console.log("Connecting to WebSocket:", wsUri)
            socket = new WebSocket(wsUri);

            socket.onopen = function(e) {
                console.log("WebSocket 연결 성공");
                reconnectAttempts = 0;

                // 연결 성공 시 초기 데이터 전송
                const initMessage = {
                    type: "INIT",
                    userId: currentUserId
                };
                socket.send(JSON.stringify(initMessage));

                // 모달이 열려있으면 사원 목록 로드
                if ($('#chatModal').hasClass('active')) {
                    loadEmployeeList();
                    loadChatRooms();
                }
            };

            socket.onmessage = function(e) {
                console.log("수신된 원본 데이터:", e.data);

                try {
                    const message = JSON.parse(e.data);
                    console.log("파싱된 메시지:", message);

                    if (message.type === "CHAT") {
                        console.log("채팅 메시지 도착 - 방 ID:", message.roomId,
                            "현재 방 ID:", currentRoomId);
                        displayChatMessage(message);
                    }
                } catch (error) {
                    console.error("메시지 파싱 오류:", error);
                }
            };

            socket.onclose = function(e) {
                console.log("WebSocket 연결 종료:", e.code, e.reason);

                // 정상 종료가 아닌 경우에만 재연결 시도
                if (e.code !== 1000 && reconnectAttempts < maxReconnectAttempts) {
                    reconnectAttempts++;
                    console.log(`재연결 시도 중... (${reconnectAttempts}/${maxReconnectAttempts})`);
                    setTimeout(connectWebSocket, reconnectDelay);
                }
            };

            socket.onerror = function(e) {
                console.error("WebSocket 오류:", e);
            };
        }

        // WebSocket 메시지 처리
        function handleWebSocketMessage(message) {
            console.log("메시지 수신:", message);

            switch(message.type) {
                case "CHAT":
                    handleChatMessage(message);
                    break;
                case "INVITE":
                    handleInviteMessage(message);
                    break;
                case "ROOM_CREATED":
                    handleRoomCreated(message);
                    break;
                case "UNREAD_COUNT":
                    updateUnreadBadge(message.count);
                    break;
                case "USER_LIST":
                    renderEmployeeList(message.users);
                    break;
                case "ROOM_LIST":
                    renderChatRooms(message.rooms);
                    break;
                case "MESSAGE_HISTORY":
                    renderMessages(message.messages);
                    break;
                default:
                    console.warn("알 수 없는 메시지 타입:", message.type);
            }
        }

        // 채팅 메시지 처리
        function handleChatMessage(message) {
            // 모달이 열려 있고 현재 보고 있는 채팅방의 메시지인 경우
            if ($('#chatModal').hasClass('active') && currentRoomId === message.roomId) {
                displayChatMessage(message);

                // 메시지 읽음 처리
                const readReceipt = {
                    type: "READ_RECEIPT",
                    roomId: message.roomId,
                    userId: currentUserId
                };
                socket.send(JSON.stringify(readReceipt));
            } else {
                // 읽지 않은 메시지 카운트 증가
                incrementUnreadCount(message.roomId);

                // 알림 표시
                showNewMessageNotification(message);
            }
        }

        // 초대 메시지 처리
        function handleInviteMessage(message) {
            if ($('#chatModal').hasClass('active')) {
                // 모달이 열려있으면 바로 표시
                if (confirm(`${message.inviterName}님이 당신을 채팅방에 초대했습니다. 참여하시겠습니까?`)) {
                    joinRoom(message.roomId);
                }
            } else {
                // 모달이 닫혀있으면 알림 표시
                showToastMessage("채팅 초대", `${message.inviterName}님이 채팅방에 초대했습니다.`, function() {
                    $('#chatModal').addClass('active');
                    joinRoom(message.roomId);
                });
            }
        }

        // 채팅방 생성 완료 처리
        function handleRoomCreated(message) {
            console.log("채팅방 생성 완료:", message);
            currentRoomId = message.roomId;
            $('.chat-room h3').text(message.targetName);
            $('.chat-content, .chat-nav').hide();
            $('.chat-room').show();
            console.log("현재 활성화된 채팅방 ID 설정됨:", currentRoomId);

            // 메시지 기록 로드
            loadRoomMessages(message.roomId);
        }
        // 사원 목록 요청
        function loadEmployeeList() {
            if (socket && socket.readyState === WebSocket.OPEN) {
                socket.send(JSON.stringify({
                    type: "GET_USER_LIST",
                    excludeSelf: true
                }));
            }
        }

        // 채팅방 목록 요청
        function loadChatRooms() {
            if (socket && socket.readyState === WebSocket.OPEN) {
                socket.send(JSON.stringify({
                    type: "GET_ROOM_LIST",
                    userId: currentUserId
                }));
            }
        }

        // 메시지 기록 요청
        function loadRoomMessages(roomId) {
            if (socket && socket.readyState === WebSocket.OPEN) {
                socket.send(JSON.stringify({
                    type: "GET_MESSAGE_HISTORY",
                    roomId: roomId,
                    userId: currentUserId
                }));
            }
        }

        // 읽음 확인 전송
        const readReceipt = {
            type: "READ_RECEIPT",
            roomId: message.roomId,
            userId: currentUserId
        };
        socket.send(JSON.stringify(readReceipt));

        // 읽지 않은 메시지 카운트 증가
        function incrementUnreadCount(roomId) {
            unreadCounts[roomId] = (unreadCounts[roomId] || 0) + 1;
            updateTotalUnreadBadge();
        }

        // 전체 읽지 않은 메시지 수 계산
        function calculateTotalUnread() {
            return Object.values(unreadCounts).reduce((sum, count) => sum + count, 0);
        }

        // 알림 배지 업데이트
        function updateTotalUnreadBadge() {
            const totalUnread = calculateTotalUnread();
            const $badge = $('#unreadBadge');

            if (totalUnread > 0) {
                $badge.text(totalUnread > 99 ? '99+' : totalUnread).show();
            } else {
                $badge.hide();
            }
        }

        // 새 메시지 알림 표시
        function showNewMessageNotification(message) {
            const notificationTitle = `${message.senderName}님의 새 메시지`;
            const notificationContent = message.content.length > 30
                ? message.content.substring(0, 30) + '...'
                : message.content;

            // 데스크톱 알림
            if (Notification.permission === "granted") {
                new Notification(notificationTitle, {
                    body: notificationContent,
                    icon: "/images/notification-icon.png"
                });
            }

            // 토스트 알림
            showToastMessage(notificationTitle, notificationContent, function() {
                $('#chatModal').addClass('active');
                joinRoom(message.roomId);
            });
        }

        // 토스트 메시지 표시
        function showToastMessage(title, content, onClick) {
            const toastId = 'toast-' + Date.now();
            const $toast = $(`
            <div id="${toastId}" class="toast-notification">
                <div style="font-weight: bold; margin-bottom: 5px;">${title}</div>
                <div style="font-size: 14px;">${content}</div>
            </div>
        `);

            $('body').append($toast);

            // 클릭 이벤트 처리
            if (onClick) {
                $toast.click(function() {
                    onClick();
                    $(this).remove();
                });
            }

            // 5초 후 자동 제거
            setTimeout(() => {
                $toast.animate({ opacity: 0 }, 300, function() {
                    $(this).remove();
                });
            }, 5000);
        }

        // 알림 권한 요청
        function requestNotificationPermission() {
            if (!("Notification" in window)) {
                console.log("이 브라우저는 알림을 지원하지 않습니다.");
                return;
            }

            if (Notification.permission !== "granted" && Notification.permission !== "denied") {
                Notification.requestPermission().then(permission => {
                    console.log("알림 권한 상태:", permission);
                });
            }
        }

        // 이벤트 핸들러 설정
        function setupEventHandlers() {
            // 채팅 모달 열기/닫기
            $('#chatButton').click(function() {
                if ($('#chatModal').hasClass('active')) {
                    $('#chatModal').removeClass('active');
                } else {
                    $('#chatModal').addClass('active');
                    resetUnreadCounts();
                    if (socket && socket.readyState === WebSocket.OPEN) {
                        loadEmployeeList();
                        loadChatRooms();
                    }
                }
            });

            // 모달 닫기 버튼
            $('.close-chat').click(function() {
                $('#chatModal').removeClass('active');
            });

            // 메시지 전송 함수
            function sendMessage() {
                const messageInput = $('#chat-input');
                const content = messageInput.val().trim();

                console.log("전송 시도 - 내용:", content,
                    "현재 방 ID:", currentRoomId,
                    "소켓 상태:", socket ? socket.readyState : "없음");

                if (!content) {
                    console.log("메시지 내용이 비어있습니다.");
                    return;
                }

                if (!currentRoomId) {
                    console.log("채팅방이 선택되지 않았습니다.");
                    return;
                }

                if (!socket || socket.readyState !== WebSocket.OPEN) {
                    console.log("WebSocket이 연결되지 않았습니다.");
                    return;
                }

                const message = {
                    type: "CHAT",
                    roomId: currentRoomId,
                    content: content,
                    senderId: currentUserId,
                    senderName: currentUserName,
                    timestamp: new Date().getTime()
                };

                console.log("전송하는 메시지:", message);
                socket.send(JSON.stringify(message));

                displayChatMessage({
                    ...message,
                    senderId: currentUserId,
                    senderName: currentUserName
                });

                messageInput.val('');
            }

            // 메시지 전송
            $('#send-button').click(sendMessage);

            $('#chat-input').keypress(function(e) {
                if (e.which === 13) {
                    sendMessage();
                    return false;
                }
            });

            // 뒤로 가기 버튼
            $('.back-button').click(function() {
                currentRoomId = null;
                $('.chat-room').hide();
                $('.chat-content, .chat-nav').show();
            });

            // 사원 검색
            $('#employee-search').on('input', function() {
                const keyword = $(this).val().toLowerCase();
                $('.employee-item').each(function() {
                    const $item = $(this);
                    const name = $item.data('name').toLowerCase();
                    const position = $item.find('.employee-position').text().toLowerCase();
                    $item.toggle(name.includes(keyword) || position.includes(keyword));
                });
            });

            // 사원 클릭 시 1:1 채팅방 생성
            $(document).on('click', '.employee-item', function() {
                const targetId = $(this).data('id');
                if (socket && socket.readyState === WebSocket.OPEN) {
                    const message = {
                        type: "CREATE_ROOM",
                        targetId: targetId
                    };
                    socket.send(JSON.stringify(message));
                }
            });

            // 페이지 전환 시 WebSocket 연결 종료
            window.addEventListener('beforeunload', function() {
                if (socket && socket.readyState === WebSocket.OPEN) {
                    socket.close(1000, "페이지 닫힘");
                }
            });

            // 페이지 포커스 시 읽지 않은 메시지 확인
            window.addEventListener('focus', function() {
                if (socket && socket.readyState === WebSocket.OPEN) {
                    socket.send(JSON.stringify({
                        type: "CHECK_UNREAD",
                        userId: currentUserId
                    }));
                }
            });
        }

        // 데이터 로드 함수들
        function loadEmployeeList() {
            if (socket && socket.readyState === WebSocket.OPEN) {
                socket.send(JSON.stringify({
                    type: "GET_USER_LIST",
                    excludeSelf: true
                }));
            }
        }

        function loadChatRooms() {
            if (socket && socket.readyState === WebSocket.OPEN) {
                socket.send(JSON.stringify({
                    type: "GET_ROOM_LIST",
                    userId: currentUserId
                }));
            }
        }

        function loadRoomMessages(roomId) {
            if (socket && socket.readyState === WebSocket.OPEN) {
                socket.send(JSON.stringify({
                    type: "GET_MESSAGE_HISTORY",
                    roomId: roomId,
                    userId: currentUserId
                }));
            }
        }

        // UI 렌더링 함수들
        function renderEmployeeList(employees) {
            const $employeeList = $('.employee-list');
            $employeeList.empty();

            employees.forEach(employee => {
                const $item = $(`
                <div class="employee-item" data-id="${employee.id}" data-name="${employee.name}">
                    <div class="employee-avatar" style="background-image: url('${employee.profileImage || '/images/default-profile.png'}')"></div>
                    <div class="employee-info">
                        <div class="employee-name">${employee.name}</div>
                        <div class="employee-position">${employee.teamName} ${employee.jobName}</div>
                    </div>
                </div>
            `);
                $employeeList.append($item);
            });
        }

        function renderChatRooms(rooms) {
            const $roomList = $('.room-list');
            $roomList.empty();

            rooms.forEach(room => {
                const $item = $(`
                <div class="room-item" data-id="${room.roomId}">
                    <div class="room-avatar" style="background-image: url('${room.roomImage || '/images/default-room.png'}')"></div>
                    <div class="room-info">
                        <div class="room-name">${room.roomName}</div>
                        <div class="last-message">${room.lastMessage || '대화 내용이 없습니다'}</div>
                    </div>
                    ${room.unreadCount > 0 ? `<span class="room-unread">${room.unreadCount}</span>` : ''}
                </div>
            `);
                $roomList.append($item);
            });
        }

        function renderMessages(messages) {
            const $chatMessages = $('.chat-messages');
            $chatMessages.empty();

            messages.forEach(message => {
                const isMe = message.senderId === currentUserId;
                const $message = $(`
                <div class="message ${isMe ? 'my-message' : 'other-message'}">
                    ${!isMe ? `<div class="sender-name">${message.senderName}</div>` : ''}
                    <div class="message-content">${message.content}</div>
                    <div class="message-time">${formatTime(message.timestamp)}</div>
                </div>
            `);
                $chatMessages.append($message);
            });

            $chatMessages.scrollTop($chatMessages[0].scrollHeight);
        }

        function displayChatMessage(message) {
            console.log("메시지 표시 함수 호출 - 보낸 사람:", message.senderId,
                "내 ID:", currentUserId);

            const $chatMessages = $('.chat-messages');
            if ($chatMessages.length === 0) {
                console.error("채팅 메시지 컨테이너를 찾을 수 없습니다!");
                return;
            }
            const isMe = message.senderId === currentUserId;

            // 수정: messageHtml 변수 정의 추가
            const messageHtml = `
        <div class="message ${isMe ? 'my-message' : 'other-message'}">
            ${!isMe ? `<div class="sender-name">${message.senderName}</div>` : ''}
            <div class="message-content">${message.content}</div>
            <div class="message-time">${formatTime(message.timestamp)}</div>
        </div>
    `;

            console.log("생성된 HTML:", messageHtml);
            $chatMessages.append(messageHtml).scrollTop($chatMessages[0].scrollHeight);
        }

        // 유틸리티 함수
        function formatTime(timestamp) {
            const date = new Date(timestamp);
            return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
        }

        function resetUnreadCounts() {
            unreadCounts = {};
            updateTotalUnreadBadge();
        }

        // 초기화 실행
        init();
    });
</script>
</div>
</div>
</div>
</body>
</html>