<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.nio.charset.StandardCharsets" %>
<%@ page import="javax.servlet.http.HttpSession" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>피자집 - 홈</title>
    <link rel="stylesheet" href="mainpage.css">
    <style>
        /* 전체 페이지 스타일 */
        body, html {
            margin: 0;
            padding: 0;
            width: 100%;
        }

        /* 메인 배너 스타일 */
        .main-banner {
            width: 100%;
            height: 250px; /* 배너 높이 조정 */
            display: flex;
            align-items: center;
            justify-content: center;
            background: #FF9800; /* 피자 느낌의 주황색 */
            color: white;
            text-align: center;
            font-size: 24px;
            font-weight: bold;
        }

        /* 배너 내부 텍스트 스타일 */
        .banner-text {
            padding: 20px;
        }

        /* 버튼 컨테이너 */
        .btn-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 15px;
        }

        /* 버튼 스타일 */
        .btn {
            padding: 12px 20px;
            font-size: 18px;
            font-weight: bold;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
            text-decoration: none;
        }

        .btn-menu {
            background-color: #F57C00;
        }

        .btn-menu:hover {
            background-color: #E65100;
        }

        .btn-order {
            background-color: #4CAF50;
        }

        .btn-order:hover {
            background-color: #388E3C;
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- 헤더 포함 -->
        <%@ include file="header.jsp" %>

        <!-- 메인 배너 -->
        <div class="main-banner">
            <div class="banner-text">
                <h1>🍕 우리 피자집에 오신 것을 환영합니다! 🍕</h1>
                <p>신선한 재료로 만든 수제 피자! 최고의 맛을 경험하세요.</p>
                <div class="btn-container">
                    <a href="menu.jsp" class="btn btn-menu">📜 메뉴 보기</a>
                    <a href="order/order.jsp" class="btn btn-order">🛒 주문하기</a>
                </div>
            </div>
        </div>

        <!-- 푸터 포함 -->
        <%@ include file="footer.jsp" %>
    </div>
</body>
</html>
