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
		height: 97%;
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

	.invite-sidebar.active ~ .chat-nav,
	.invite-sidebar.active ~ .chat-content {
		margin-left: 280px;
		width: calc(100% - 280px);
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
	.room-list {
		width: 100%;
		height: 100%;
		overflow-y: auto;
	}
	.chat.me {
		text-align: right;
		color: #2c3e50;
	}

	.invite-sidebar {
		width: 280px;
		height: 100%;
		background: white;
		border-right: 1px solid #eee;
		display: flex;
		flex-direction: column;
		position: absolute;
		left: 0;
		z-index: 3;
	}
</style>
<button id="chatButton" class="chat-button surface-bright">
	<span class="material-icons">chat</span>
</button>

<div id="chatModal" class="chat-modal surface-bright">
	<div class="chat-header">
		<h3>채팅</h3>
		<button class="invite-chat" style="display: none">
			<span class="material-icons">add</span>
		</button>
		<button class="close-chat">
			<span class="material-icons">close</span>
		</button>
	</div>
	<div class="chat-container">

		<div class="invite-sidebar" style="display: none;">
			<div class="search-box">
				<input type="text" placeholder="사원 검색...">
			</div>
			<div class="employee-list">
				<!-- 사원 목록이 여기에 동적으로 생성됨 -->
			</div>
		</div>

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

		<div class="room-list" style="display: none;">
			<!-- 채팅방 목록이 여기에 생성됨 -->
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
				<button type="button">
					<span class="material-icons">send</span>
				</button>
			</div>
		</div>
	</div>
</div>
<input type="hidden" id="selected-employee-id" value="">
<input type="hidden" id="sender-employee-id" value=${employee.id}>
<input type="hidden" id="sender-name" value="${employee.name}">
<script>
	$(document).ready(function() {
		let ws = new WebSocket("ws://10.10.55.9/chat");
		let employees = [];
		let chatRooms = [];
		let currentRoomId = 0;

		//채팅방 더미데이터
		<%--const dummyRooms = Array.from({ length: 10 }, (_, i) => ({--%>
		<%--	id: i + 1,--%>
		<%--	title: `채팅방 ${i + 1}`,--%>
		<%--	lastMessage: `마지막 메시지 ${i + 1}`--%>
		<%--}));--%>
		refreshChatRoomList();

		//메시지 수신
		ws.onmessage = function (e) {
			let msg = JSON.parse(e.data);
			console.log(msg);

			if (msg.type === "invite") {
				alert(msg.sender + "님이 " + msg.recipientId + "님을 초대하였습니다.");
				return;
			}

			if (msg.type === "NEW_CHAT_ROOM") {
				currentRoomId = msg.roomId;
				addNewChatRoomItem(msg);
				return;
			} else if(msg.type === "history") {
				console.log(msg);
				let historyChat = $("<div>")
						.addClass(msg.employeeId === $("#sender-employee-id").val() ? "chat me" : "chat")
						.html(msg.sender + " : " + msg.message);
				$(".chat-messages").append(historyChat);
				$(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
				return;
			}
			let chat = $("<div>")
					.addClass(msg.senderId === $("#sender-employee-id").val() ? "chat me" : "chat")
					.html(msg.sender + " : " + msg.message);
			$(".chat-messages").append(chat);
			$(".chat-messages").scrollTop($(".chat-messages")[0].scrollHeight);
			updateLastMessageInRoom(msg);
		}

		//사원 목록 출력
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
		refreshChatRoomList();
		function refreshChatRoomList() {
				$.ajax({
				url:"/messenger/chatListAll"
			}).done(function (resp) {
				chatRooms = resp.chatListAll;
				renderRoomList(chatRooms);
			});
		}

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

		function addNewChatRoomItem(roomInfo) {
			let newRoomElement = makeChatRoomListItem(roomInfo);
			$(".room-list").prepend(newRoomElement);
		}

		function updateLastMessageInRoom(msg) {
			let updatedRoom = null;
			for (let i = 0; i < chatRooms.length; i++) {
				let roomIdValue = chatRooms[i].roomId || chatRooms[i].messageRoomId;
				if (String(roomIdValue) === String(msg.roomId)) {
					chatRooms[i].lastMessage = msg.message || "No messages yet";
					chatRooms.splice(i, 1);
					chatRooms.unshift(updatedRoom);
					break;
				}
			}
			if (updatedRoom) {
				let newRoomElement = makeChatRoomListItem(updatedRoom);
				$(".room-list").children(".employee-item").filter(function() {
					return $(this).data("room-id") == msg.roomId;
				}).remove();
				$(".room-list").prepend(newRoomElement);
			} else {
				refreshChatRoomList();
			}
		}

		function sendMessage() {
			const message = chatInput.val().trim();
			if (message) {
				chatInput.val('');
			} else if(message == '') {
				return;
			}
			const payload = {
				id: $('#sender-employee-id').val(),
				message: message,
				recipient: $('#selected-employee-id').val(),
				roomId: currentRoomId
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
			$('.invite-sidebar .employee-list').empty();
			$('.chat-content .employee-list').empty();

			listData.forEach((employee, index) => {
				const employeeItem = makeChatEmployeeList(employee, index);
				$('.invite-sidebar .employee-list').append(employeeItem.clone());
				$('.chat-content .employee-list').append(employeeItem.clone());
			});
		}

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

		// 초대 버튼 클릭 이벤트 핸들러
		// $('.invite-chat').on("click", function() {
		// 	const $inviteSidebar = $('.invite-sidebar');
		// 	if ($inviteSidebar.is(':visible')) {
		// 		$inviteSidebar.hide();
		// 		$('.chat-nav, .chat-content').css('margin-left', '0');
		// 	} else {
		// 		$inviteSidebar.show();
		// 		$('.chat-nav, .chat-content').css('margin-left', '280px');
		// 		renderEmployeeList(); // 사원 목록 다시 렌더링
		// 	}
		// 	const inviteeId = $('#selected-employee-id').val();
		// 	let inviteMessage = {
		// 		type: "invite",
		// 		recipientId: inviteeId,
		// 		roomId: currentRoomId
		// 	};
		// 	ws.send(JSON.stringify(inviteMessage));
		// });
		$('.invite-chat').on("click", function() {
			const $inviteSidebar = $('.invite-sidebar');
			// 사이드바가 열려 있으면, 선택된 사용자가 있는지 확인 후 초대 메시지 전송
			if ($inviteSidebar.is(':visible')) {
				const inviteeId = $('#selected-employee-id').val();
				console.log("초대 전 currentRoomId:", currentRoomId);
				if (!currentRoomId || currentRoomId === 0) {
					alert("유효한 대화방 정보가 없습니다. 대화방을 확인해주세요.");
					return;
				}
				let inviteMessage = {
					type: "invite",
					recipientId: inviteeId,
					roomId: currentRoomId
				};
				ws.send(JSON.stringify(inviteMessage));
				alert("초대 메시지가 전송되었습니다.");
				$inviteSidebar.hide();
				$('.chat-nav, .chat-content').css('margin-left', '0');
			} else {
				// 사이드바가 닫혀 있다면 열면서 목록 재렌더링
				$inviteSidebar.show();
				$('.chat-nav, .chat-content').css('margin-left', '280px');
				// 초대용 사원 목록을 새로 불러오거나 기존 배열을 이용해 렌더링
				renderEmployeeList();
			}
		});



		// 사원 목록의 각 항목 클릭 시 (초대 대상 선택)
		$(document).on('click', '.invite-sidebar .employee-item', function() {
			const employeeId = $(this).data('id');
			$('#selected-employee-id').val(employeeId);
			$('.invite-sidebar .employee-item').removeClass('active');
			$(this).addClass('active');
		});


		// 사원 목록 렌더링 함수 수정
		function renderEmployeeList(data) {
			const listData = data || employees;

			// 두 개의 영역을 모두 비웁니다.
			$('.invite-sidebar .employee-list, .chat-content .employee-list').empty();

			listData.forEach((employee, index) => {
				const employeeItem = makeChatEmployeeList(employee, index);

				// 초대 사이드바 & 메인 컨텐츠 영역 둘 다에 같은 목록 표시
				$('.invite-sidebar .employee-list').append(employeeItem.clone(true));
				$('.chat-content .employee-list').append(employeeItem.clone(true));
			});
		}


		$(document).on('click', '.invite-sidebar .employee-item', function() {
			const employeeId = $(this).data('id');
			const employeeName = $(this).data('name');

			// 초대 메시지 전송
			const payload = {
				type: "invite",
				id: $('#sender-employee-id').val(),
				senderName: $('#sender-name').val(),
				recipientId: employeeId,
				message: employeeName + " 님을 채팅방에 초대하였습니다"
			};

			ws.send(JSON.stringify(payload));;

			// 초대 사이드바 닫기
			$('.invite-sidebar').hide();
			$('.chat-nav, .chat-content').css('margin-left', '0');
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
			const roomId = $(this).data('room-id');
			$('#selected-employee-id').val(employeeId);
			showChatRoom(employeeId, employeeName, roomId);
		});

		//채팅방 생성
		function showChatRoom(employeeId, employeeName, roomId) {

			$(".chat-messages").empty();

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
			$('#selected-employee-id').val(employeeId);

			// 채팅방 표시
			$('.chat-content, .chat-nav, .room-list').hide();
			$('.chat-room').show();
			$('.invite-chat').show();

			$('.invite-sidebar').hide(); // 채팅방 열릴 때 초대 사이드바 닫기
			$('.chat-nav, .chat-content').css('margin-left', '0');
			currentRoomId = roomId;

			//기존 메시지 불러오기 로직 필요
			const payload = {
				type: "roomEnter",
				roomId: roomId
			};
			ws.send(JSON.stringify(payload));
		}

		function makeChatRoomListItem(room) {
			const roomId = room.roomId || room.messageRoomId;
			const div = $('<div>').addClass('employee-item').attr('data-room-id', roomId);
/*			const div = $('<div>').addClass('employee-item').attr('data-room-id', room.messageRoomId);*/
			const avatar = $('<div>').addClass('employee-avatar').css('background-color', '#bbb');
			const info = $('<div>').addClass('employee-info');
			const name = $('<div>').addClass('employee-name').text(room.roomName);
			const lastMsg = $('<div>').addClass('employee-position').text(room.lastMessage || "No messages yet");

			info.append(name, lastMsg);
			div.append(avatar, info);
			return div;
		}

		function renderRoomList() {
			const roomListContainer = $('.room-list');
			roomListContainer.empty();
			if (chatRooms && chatRooms.length > 0) {
				chatRooms.forEach(room => {
					roomListContainer.append(makeChatRoomListItem(room));
				});
			} else {
				roomListContainer.append('<div class="no-rooms">No chat rooms available</div>');
			}
		}

		// 뒤로가기 버튼 이벤트
		$('.back-button').on('click', function() {
			const view = $('.nav-icon.active').data('view');
			$('.invite-chat').hide();
			if(view === 'employees') {
				$('.chat-room').hide();
				$('.chat-content, .chat-nav').show();
				renderEmployeeList();
			} else if (view === 'rooms') {
				$('.chat-room').hide();
				$('.chat-content, .chat-nav, .room-list').show();
				renderRoomList();
			}

		});

		// 네비게이션 아이콘 클릭 이벤트
		$('.nav-icon').on('click', function() {
			$('.nav-icon').removeClass('active');
			$(this).addClass('active');
			const view = $(this).data('view');

			// 여기에 각 뷰에 따른 컨텐츠 전환 로직 추가
			if(view === 'employees') {
				$('.employee-list').show();
				$('.search-box').show();
				$('.chat-content').show();
				$('.room-list').hide();
				renderEmployeeList();
			} else if (view === 'rooms') {
				$('.employee-list').hide();
				$('.search-box').hide();
				$('.chat-content').hide();
				$('.room-list').show();
				renderRoomList();
			}
		});
		$('form').on('submit', function(e) {
			e.preventDefault();
		});

	});
</script>
</div>
</div>
</div>
</body>
</html>