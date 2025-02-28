<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메뉴 보기</title>
    <link rel="stylesheet" href="mainpage.css">
    <style>
        /* 메뉴 컨테이너 */
        .menu-container {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 20px;
            margin-top: 30px;
        }

        /* 개별 메뉴 아이템 */
        .menu-item {
            width: 280px;
            padding: 15px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
            transition: 0.3s;
        }

        /* 메뉴 이미지 */
        .menu-item img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 10px;
        }

        /* 메뉴 제목 */
        .menu-item h3 {
            margin: 10px 0;
            font-size: 1.2em;
            color: #FF9800;
        }

        /* 설명 텍스트 */
        .menu-item p {
            font-size: 0.95em;
            color: #555;
            margin-bottom: 15px;
        }

        /* 주문하기 버튼 */
        .order-btn {
            display: inline-block;
            padding: 10px 15px;
            font-size: 14px;
            font-weight: bold;
            color: white;
            background-color: #FF9800;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
            text-decoration: none;
        }

        .order-btn:hover {
            background-color: #e68900;
        }

        /* 마우스 오버 효과 */
        .menu-item:hover {
            transform: translateY(-5px);
            box-shadow: 0 6px 12px rgba(0, 0, 0, 0.15);
        }

        @media screen and (max-width: 768px) {
            .menu-container {
                flex-direction: column;
                align-items: center;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <%@ include file="header.jsp" %>

        <main>
            <h2>🍕 우리 피자 메뉴</h2>
            <div class="menu-container">
                <!-- 치즈 피자 -->
                <div class="menu-item">
                    <img src="images/pizza1.jpg" alt="치즈 피자">
                    <h3>치즈 피자</h3>
                    <p>진한 치즈가 듬뿍! 기본이지만 가장 인기 있는 피자입니다.</p>
                    <a href="order/order.jsp" class="order-btn">주문하기</a>
                </div>

                <!-- 페퍼로니 피자 -->
                <div class="menu-item">
                    <img src="images/pizza22.jpg" alt="페퍼로니 피자">
                    <h3>페퍼로니 피자</h3>
                    <p>짭짤한 페퍼로니가 듬뿍 들어간 인기 메뉴!</p>
                    <a href="order/order.jsp" class="order-btn">주문하기</a>
                </div>

                <!-- 콤비네이션 피자 -->
                <div class="menu-item">
                    <img src="images/pizza3.jpg" alt="콤비네이션 피자">
                    <h3>콤비네이션 피자</h3>
                    <p>다양한 토핑이 어우러져 최고의 조화를 이루는 피자.</p>
                    <a href="order/order.jsp" class="order-btn">주문하기</a>
                </div>
            </div>
        </main>
    </div>

    <%@ include file="footer.jsp" %>
</body>
</html>
