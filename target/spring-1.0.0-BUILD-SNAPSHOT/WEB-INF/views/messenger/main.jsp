<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    /* 채팅 버튼 스타일 */
    .chat-button {
        position: fixed;
        bottom: 20px;
        right: 20px;
        width: 60px;
        height: 60px;
        border-radius: 50%;
        background-color: #2c3e50;
        color: white;
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

    .chat-button .material-symbols-outlined {
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
        padding: 15px;
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

    /* 다크모드 스타일 */
    html.dark .chat-modal {
        background-color: #1a1a1a;
        color: white;
    }

    html.dark .chat-input-area {
        border-top-color: #333;
    }

    html.dark .chat-input-area input {
        background-color: #333;
        border-color: #444;
        color: white;
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
<button id="chatButton" class="chat-button">
    <span class="material-icons">chat</span>
</button>

<div id="chatModal" class="chat-modal">
    <div class="chat-header">
        <h3>채팅</h3>
        <button class="close-chat">
            <span class="material-icons">close</span>
        </button>
    </div>
    <div class="chat-content">
        <!-- 채팅 내용이 들어갈 영역 -->
        <div class="chat-messages">
            <!-- 채팅 메시지들이 여기에 추가됨 -->
        </div>
        <div class="chat-input-area">
            <input type="text" placeholder="메시지를 입력하세요...">
            <button>
                <span class="material-icons">send</span>
            </button>
        </div>
    </div>
</div>

<script>
    // 채팅 기능 관련 스크립트
    document.addEventListener('DOMContentLoaded', function() {
        const chatButton = document.getElementById('chatButton');
        const chatModal = document.getElementById('chatModal');
        const closeChat = document.querySelector('.close-chat');

        // 채팅 모달 토글
        chatButton.addEventListener('click', function() {
            chatModal.style.display = chatModal.style.display === 'none' ? 'flex' : 'none';
        });

        // 닫기 버튼
        closeChat.addEventListener('click', function() {
            chatModal.style.display = 'none';
        });

        // 모달 외부 클릭 시 닫기
        document.addEventListener('click', function(e) {
            if (!chatModal.contains(e.target) && e.target !== chatButton) {
                chatModal.style.display = 'none';
            }
        });

        // 채팅 입력 처리
        const chatInput = document.querySelector('.chat-input-area input');
        const sendButton = document.querySelector('.chat-input-area button');

        function sendMessage() {
            const message = chatInput.value.trim();
            if (message) {
                // 여기에 메시지 전송 로직 추가
                chatInput.value = '';
            }
        }

        sendButton.addEventListener('click', sendMessage);

        chatInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                sendMessage();
            }
        });
    });
</script>
