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
		background-color: #2c3e50;
		color: white;
	}

	.chat-button:hover {
		transform: scale(1.1);
	}

	.chat-button .material-icons {
		font-size: 28px;
	}

	/* 읽지 않은 메시지 배지 */
	.unread-badge {
		position: absolute;
		top: -5px;
		right: -5px;
		background-color: #e74c3c;
		color: white;
		border-radius: 50%;
		width: 20px;
		height: 20px;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 12px;
	}

	/* 채팅 모달 스타일 */
	.chat-modal {
		display: none;
		position: fixed;
		bottom: 90px;
		right: 20px;
		width: 100%;
		max-width: 360px;
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

	.chat-container {
		display: flex;
		height: calc(100% - 60px);
		position: relative;
	}

	.chat-nav {
		width: 60px;
		background: #f8f9fa;
		border-right: 1px solid #eee;
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

	.chat-content {
		flex: 1;
		display: flex;
		flex-direction: column;
		overflow: hidden;
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

	.employee-list, .room-list {
		flex: 1;
		overflow-y: auto;
	}

	.employee-item, .room-item {
		padding: 15px;
		display: flex;
		align-items: center;
		cursor: pointer;
		transition: background-color 0.2s;
	}

	.employee-item:hover, .room-item:hover {
		background-color: #f5f5f5;
	}

	.employee-avatar, .room-avatar {
		width: 40px;
		height: 40px;
		border-radius: 50%;
		margin-right: 12px;
		background-color: #ddd;
		background-size: cover;
		background-position: center;
	}

	.employee-info, .room-info {
		flex: 1;
	}

	.employee-name, .room-name {
		font-weight: bold;
		margin-bottom: 4px;
	}

	.employee-position, .room-last-message {
		font-size: 12px;
		color: #666;
	}

	.room-unread {
		background-color: #e74c3c;
		color: white;
		border-radius: 50%;
		width: 20px;
		height: 20px;
		display: flex;
		align-items: center;
		justify-content: center;
		font-size: 10px;
	}

	/* 채팅방 영역 */
	.chat-room {
		position: absolute;
		top: 0;
		left: 0;
		width: 100%;
		height: 100%;
		display: none;
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

	.chat-messages {
		flex: 1;
		overflow-y: auto;
		padding: 15px;
		background-color: #f9f9f9;
	}

	.message {
		margin-bottom: 15px;
		max-width: 80%;
		padding: 10px 15px;
		border-radius: 18px;
		position: relative;
	}

	.my-message {
		background-color: #2c3e50;
		color: white;
		margin-left: auto;
		border-bottom-right-radius: 5px;
	}

	.other-message {
		background-color: #e9e9e9;
		margin-right: auto;
		border-bottom-left-radius: 5px;
	}

	.message-sender {
		font-weight: bold;
		font-size: 12px;
		margin-bottom: 5px;
	}

	.message-content {
		word-wrap: break-word;
	}

	.message-time {
		font-size: 10px;
		text-align: right;
		margin-top: 5px;
		opacity: 0.7;
	}

	.chat-input-area {
		padding: 15px;
		border-top: 1px solid #eee;
		display: flex;
		gap: 10px;
		background-color: white;
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

	/* 알림 스타일 */
	.notification {
		position: fixed;
		bottom: 100px;
		right: 20px;
		background-color: #2c3e50;
		color: white;
		padding: 10px 15px;
		border-radius: 5px;
		box-shadow: 0 3px 10px rgba(0,0,0,0.2);
		z-index: 1100;
		animation: slideIn 0.3s ease-out;
	}

	@keyframes slideIn {
		from { transform: translateX(100%); }
		to { transform: translateX(0); }
	}

	/* 모바일 반응형 */
	@media (max-width: 768px) {
		.chat-modal {
			width: calc(100% - 40px);
			right: 20px;
			bottom: 90px;
			height: 60vh;
		}
	}
</style>

<!-- 채팅 버튼 -->
<button id="chatButton" class="chat-button">
	<span class="material-icons">chat</span>
	<span id="unreadBadge" class="unread-badge" style="display: none">0</span>
</button>

<!-- 채팅 모달 -->
<div id="chatModal" class="chat-modal">
	<div class="chat-header">
		<h3>채팅</h3>
		<button class="close-chat">
			<span class="material-icons">close</span>
		</button>
	</div>
	<div class="chat-container">
		<!-- 네비게이션 영역 -->
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
				<input type="text" placeholder="검색...">
			</div>
			<div class="employee-list">
				<!-- 사원 목록이 여기에 동적으로 생성됨 -->
			</div>
			<div class="room-list" style="display: none;">
				<!-- 채팅방 목록이 여기에 동적으로 생성됨 -->
			</div>
		</div>

		<!-- 채팅방 영역 (처음에는 숨겨져 있음) -->
		<div class="chat-room">
			<div class="chat-header">
				<button class="back-button">
					<span class="material-icons">arrow_back</span>
				</button>
				<h3 id="chat-user-title"></h3>
			</div>
			<div class="chat-messages"></div>
			<div class="chat-input-area">
				<input type="text" placeholder="메시지를 입력하세요..." id="chat-input">
				<button id="send-button">
					<span class="material-icons">send</span>
				</button>
			</div>
		</div>
	</div>
</div>

<script>
	$(document).ready(function() {
		// 전역 변수
		let currentUserId = "${sessionScope.employee.id}"; // 세션에서 사용자 ID 가져오기
		let currentUserName = "${sessionScope.employee.name}";
		let currentRoomId = null;
		let employees = [];
		let rooms = [];
		let isModalOpen = false;

		// 웹소켓 연결
		const protocol = window.location.protocol === 'https:' ? 'wss://' : 'ws://';
		const wsUrl = protocol + window.location.host + '/chat';
		let ws;

		connectWebSocket();

		function connectWebSocket() {
			ws = new WebSocket(wsUrl);

			ws.onopen = function() {
				console.log("WebSocket connected");
				// 초기 데이터 요청
				sendWsMessage({ type: "GET_USER_LIST" });
				sendWsMessage({ type: "GET_ROOM_LIST" });
				sendWsMessage({ type: "CHECK_UNREAD" });
			};

			ws.onmessage = function(event) {
				const message = JSON.parse(event.data);
				console.log("Received message:", message);

				switch(message.type) {
					case "CHAT":
						handleIncomingChat(message);
						break;
					case "ROOM_CREATED":
						handleRoomCreated(message);
						break;
					case "INVITE":
						handleInvite(message);
						break;
					case "USER_LIST":
						updateEmployeeList(message.users);
						break;
					case "ROOM_LIST":
						updateRoomList(message.rooms);
						break;
					case "MESSAGE_HISTORY":
						displayMessageHistory(message.messages);
						break;
					case "UNREAD_COUNT":
						updateUnreadCount(message.count);
						break;
					default:
						console.log("Unknown message type:", message.type);
				}
			};

			ws.onclose = function() {
				console.log("WebSocket disconnected");
				// 5초 후 재연결 시도
				setTimeout(connectWebSocket, 5000);
			};
		}

		// 메시지 전송 함수
		function sendWsMessage(message) {
			if (ws && ws.readyState === WebSocket.OPEN) {
				ws.send(JSON.stringify(message));
			} else {
				console.error("WebSocket is not open");
			}
		}

		// 채팅 메시지 처리
		function handleIncomingChat(message) {
			if (currentRoomId && currentRoomId == message.roomId) {
				// 현재 열린 채팅방의 메시지면 바로 표시
				appendMessage(message, false);
				// 읽음 표시 전송
				sendWsMessage({
					type: "READ_RECEIPT",
					roomId: message.roomId,
					messageId: message.messageId
				});
			} else {
				// 다른 채팅방의 메시지면 알림 처리
				showNotification(message.senderName + ": " + message.content);
				// 읽지 않은 메시지 수 업데이트
				sendWsMessage({ type: "CHECK_UNREAD" });
			}
		}

		// 채팅 메시지 추가
		function appendMessage(message, isMyMessage) {
			const messageElement = $('<div>').addClass('message');
			if (isMyMessage) {
				messageElement.addClass('my-message');
			} else {
				messageElement.addClass('other-message');
			}

			const sender = $('<div>').addClass('message-sender').text(message.senderName || message.senderId);
			const content = $('<div>').addClass('message-content').text(message.content);
			const time = $('<div>').addClass('message-time').text(formatTime(message.timestamp));

			messageElement.append(sender, content, time);
			$('.chat-messages').append(messageElement);

			// 스크롤 아래로 이동
			$('.chat-messages').scrollTop($('.chat-messages')[0].scrollHeight);
		}

		// 시간 포맷팅
		function formatTime(timestamp) {
			const date = new Date(timestamp);
			return date.toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' });
		}

		// 채팅방 생성 처리
		function handleCreateRoom(targetId, targetName) {
			sendWsMessage({
				type: "CREATE_ROOM",
				targetId: targetId
			});
		}

		// 채팅방 생성 응답 처리
		function handleRoomCreated(response) {
			rooms.push({
				roomId: response.roomId,
				targetId: response.targetId,
				targetName: response.targetName
			});

			// 채팅방으로 이동
			enterChatRoom(response.roomId, response.targetName);
		}

		// 초대 메시지 처리
		function handleInvite(message) {
			// 새 채팅방 추가
			rooms.push({
				roomId: message.roomId,
				inviterId: message.inviterId,
				inviterName: message.inviterName
			});

			// 알림 표시
			showNotification(message.message);

			// 채팅방 목록 업데이트
			sendWsMessage({ type: "GET_ROOM_LIST" });
		}

		// 사원 목록 업데이트
		function updateEmployeeList(userList) {
			employees = userList;
			renderEmployeeList();
		}

		// 채팅방 목록 업데이트
		function updateRoomList(roomList) {
			rooms = roomList;
			renderRoomList();
		}

		// 메시지 기록 표시
		function displayMessageHistory(messages) {
			$('.chat-messages').empty();
			if (messages && messages.length > 0) {
				messages.forEach(msg => {
					appendMessage({
						senderId: msg.senderId,
						senderName: msg.senderName,
						content: msg.content,
						timestamp: msg.timestamp,
						isMyMessage: msg.senderId === currentUserId
					}, msg.senderId === currentUserId);
				});
			}
		}

		// 읽지 않은 메시지 수 업데이트
		function updateUnreadCount(count) {
			const badge = $('#unreadBadge');
			if (count > 0) {
				badge.text(count > 99 ? '99+' : count).show();
			} else {
				badge.hide();
			}
		}

		// 채팅방 입장
		function enterChatRoom(roomId, roomName) {
			currentRoomId = roomId;
			$('.chat-room').show();
			$('.chat-content, .chat-nav').hide();
			$('#chat-user-title').text(roomName || "채팅방");

			// 메시지 기록 요청
			sendWsMessage({
				type: "GET_MESSAGE_HISTORY",
				roomId: roomId
			});
		}

		// 메시지 전송
		function sendChatMessage() {
			const input = $('#chat-input');
			const content = input.val().trim();

			if (content && currentRoomId) {
				sendWsMessage({
					type: "CHAT",
					roomId: currentRoomId,
					content: content
				});

				// 내 메시지 바로 표시 (optimistic UI)
				appendMessage({
					senderId: currentUserId,
					senderName: "나",
					content: content,
					timestamp: Date.now(),
					isMyMessage: true
				}, true);

				input.val('');
			}
		}

		// 알림 표시
		function showNotification(message) {
			const notification = $('<div>').addClass('notification').text(message);
			$('body').append(notification);

			// 3초 후 알림 제거
			setTimeout(() => {
				notification.remove();
			}, 3000);
		}

		// 사원 목록 렌더링
		function renderEmployeeList() {
			const container = $('.employee-list');
			container.empty();
			if (employees.length === 0) {
				container.append($('<div>').addClass('empty-message').text("사원 목록이 없습니다."));
				return;
			}
			employees.forEach(emp => {
				const item = $('<div>').addClass('employee-item').attr('data-id', emp.id).attr('data-name', emp.name || emp.id);

				const avatar = $('<div>').addClass('employee-avatar')
						.css('background-image', `url('${emp.profileImage || 'https://i.pravatar.cc/150?img=3'}')`);

				const info = $('<div>').addClass('employee-info');
				const name = $('<div>').addClass('employee-name').text(emp.name || emp.id);
				const position = $('<div>').addClass('employee-position').text(`${emp.teamName || ''} ${emp.jobName || ''}`.trim());
				info.append(name, position);
				item.append(avatar, info);
				container.append(item);
			});
		}

		// 채팅방 목록 렌더링
		function renderRoomList() {
			const container = $('.room-list');
			container.empty();

			if (rooms.length === 0) {
				container.append($('<div>').addClass('empty-message').text("채팅방이 없습니다."));
				return;
			}

			rooms.forEach(room => {
				const item = $('<div>').addClass('room-item')
						.attr('data-id', room.roomId)
						.attr('data-name', room.roomName || room.targetName || "채팅방");

				const avatar = $('<div>').addClass('room-avatar')
						.css('background-image', `url('https://i.pravatar.cc/150?img=${Math.floor(Math.random() * 70)}')`);

				const info = $('<div>').addClass('room-info');
				const name = $('<div>').addClass('room-name').text(room.roomName || room.targetName || "채팅방");
				const lastMsg = $('<div>').addClass('room-last-message').text(room.lastMessage || "대화를 시작하세요");

				info.append(name, lastMsg);
				item.append(avatar, info);

				if (room.unreadCount > 0) {
					const unread = $('<div>').addClass('room-unread').text(room.unreadCount > 9 ? '9+' : room.unreadCount);
					item.append(unread);
				}

				container.append(item);
			});
		}

		// 모달 토글
		function toggleChatModal() {
			isModalOpen = !isModalOpen;
			if (isModalOpen) {
				$('#chatModal').addClass('active');
				// 모달 열릴 때 데이터 새로고침
				sendWsMessage({ type: "GET_USER_LIST" });
				sendWsMessage({ type: "GET_ROOM_LIST" });
			} else {
				$('#chatModal').removeClass('active');
			}
		}

		// 이벤트 핸들러 설정
		$('#chatButton').on('click', function(e) {
			e.stopPropagation();
			toggleChatModal();
		});

		$('.close-chat').on('click', function(e) {
			e.stopPropagation();
			toggleChatModal();
		});

		$(document).on('click', '.employee-item', function() {
			const employeeId = $(this).data('id');
			const employeeName = $(this).data('name');

			// 이미 존재하는 채팅방 찾기
			const existingRoom = rooms.find(room =>
					room.targetId === employeeId ||
					(room.participants && room.participants.some(p => p.id === employeeId))
			);

			if (existingRoom) {
				enterChatRoom(existingRoom.roomId, employeeName);
			} else {
				handleCreateRoom(employeeId, employeeName);
			}
		});

		$(document).on('click', '.room-item', function() {
			const roomId = $(this).data('id');
			const roomName = $(this).data('name');
			enterChatRoom(roomId, roomName);
		});

		$('#send-button').on('click', sendChatMessage);

		$('#chat-input').on('keydown', function(e) {
			if (e.key === 'Enter') {
				sendChatMessage();
			}
		});

		$('.back-button').on('click', function() {
			currentRoomId = null;
			$('.chat-room').hide();
			$('.chat-content, .chat-nav').show();
		});

		$('.nav-icon').on('click', function() {
			const view = $(this).data('view');
			$('.nav-icon').removeClass('active');
			$(this).addClass('active');

			if (view === 'rooms') {
				$('.employee-list').hide();
				$('.room-list').show();
			} else {
				$('.employee-list').show();
				$('.room-list').hide();
			}
		});

		// 초기화
		function initialize() {
			renderEmployeeList();
			renderRoomList();
		}

		initialize();
	});
</script>
</div>
</div>
</div>
</body>
</html>