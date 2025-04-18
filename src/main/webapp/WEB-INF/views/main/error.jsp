<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>페이지를 찾을 수 없습니다</title>
    <link rel="stylesheet" href="/css/color/newColor.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
            background-color: var(--md-sys-color-bg);
            color: var(--md-sys-color-on-primay);
            line-height: 1.6;
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .error-container-box {
            width: 100%;
            max-width: 600px;
            padding: 0 24px;
            text-align: center;
        }

        .error-code {
            font-size: 120px;
            font-weight: 700;
            line-height: 1;
            background: var(--md-sys-color-primary);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 24px;
        }

        .error-message {
            font-size: 24px;
            color: var(--md-sys-color-surface);
            margin-bottom: 16px;
            font-weight: 600;
        }

        .error-description {
            font-size: 16px;
            color: var(--md-sys-color-secondary);
            margin-bottom: 32px;
            line-height: 1.6;
        }

        .button {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 12px 24px;
            background-color: var(--md-sys-color-primary);
            color: var(--md-sys-color-on-primary);
            text-decoration: none;
            border-radius: 8px;
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .button:hover {
            opacity: 0.9;
            transform: translateY(-1px);
        }

        .support-text {
            margin-top: 24px;
            font-size: 14px;
            color: var(--md-sys-color-secondary);
        }

        .support-text a {
            color: var(--md-sys-color-primary);
            text-decoration: none;
            font-weight: 500;
        }

        .support-text a:hover {
            text-decoration: underline;
        }

        @media (max-width: 640px) {
            .error-code {
                font-size: 80px;
            }

            .error-message {
                font-size: 20px;
            }

            .error-description {
                font-size: 14px;
            }
        }

        /* 선택적: 애니메이션 효과 */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes scaleIn {
            from {
                opacity: 0;
                transform: scale(0.8);
            }
            to {
                opacity: 1;
                transform: scale(1);
            }
        }

        .error-code {
            animation: scaleIn 0.8s cubic-bezier(0.16, 1, 0.3, 1) forwards;
            opacity: 0;
        }

        .error-message {
            animation: fadeInUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) 0.2s forwards;
            opacity: 0;
        }

        .error-description {
            animation: fadeInUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) 0.3s forwards;
            opacity: 0;
        }

        .button {
            animation: fadeInUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) 0.4s forwards;
            opacity: 0;
        }

        .support-text {
            animation: fadeInUp 0.8s cubic-bezier(0.16, 1, 0.3, 1) 0.5s forwards;
            opacity: 0;
        }

        /* hover 효과도 더 부드럽게 수정 */
        .button {
            transition: all 0.3s cubic-bezier(0.16, 1, 0.3, 1);
        }

        .button:hover {
            opacity: 0.9;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }

        .button:active {
            transform: translateY(0);
        }


        .error-container-box > * {
            animation: fadeInUp 0.6s ease-out forwards;
        }

        .error-container-box > *:nth-child(1) { animation-delay: 0.1s; }
        .error-container-box > *:nth-child(2) { animation-delay: 0.2s; }
        .error-container-box > *:nth-child(3) { animation-delay: 0.3s; }
        .error-container-box > *:nth-child(4) { animation-delay: 0.4s; }
    </style>
    <script>
        let mode = (sessionStorage.getItem('mode') == null) ? 'light' : sessionStorage.getItem('mode');
        $('html').addClass(mode);
    </script>
</head>
<body>
<div class="error-container-box">
    <div class="error-code">${state}</div>
    <h1 class="error-message">
        ${message}
    </h1>
    <p class="error-description">
        요청하신 페이지가 삭제되었거나 일시적으로 사용할 수 없습니다.<br>
        입력하신 주소가 정확한지 다시 한 번 확인해 주세요.
    </p>
    <a href="/" class="button">메인으로 돌아가기</a>
</div>
</body>
</html>