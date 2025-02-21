<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>메뉴 보기</title>
    <link rel="stylesheet" href="mainpage.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>메뉴 보기</h1>
            <nav>
                <ul>
                    <li><a href="signup.jsp">회원가입</a></li>
                    <li><a href="login.jsp">로그인</a></li>
                    <li><a href="menu.jsp">메뉴보기</a></li>
                    <li><a href="order.jsp">주문하기</a></li>
                    <li><a href="Userinfo.jsp">내 정보</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <h2>우리의 피자 메뉴</h2>
            <div class="menu-container">
                <!-- 치즈 피자 -->
                <div class="menu-item">
                    <img src="images/pizza1.jpg" alt="치즈 피자">
                    <h3>치즈 피자</h3>
                    <p>진한 치즈가 듬뿍! 기본이지만 가장 인기 있는 피자입니다.</p>
                </div>

                <!-- 페페로니 피자 -->
                <div class="menu-item">
                    <img src="images/pizza22.jpg" alt="페페로니 피자">
                    <h3>페페로니 피자</h3>
                    <p>짭짤한 페페로니가 듬뿍 들어간 인기 메뉴!</p>
                </div>

                <!-- 콤비네이션 피자 -->
                <div class="menu-item">
                    <img src="images/pizza3.jpg" alt="콤비네이션 피자">
                    <h3>콤비네이션 피자</h3>
                    <p>다양한 토핑이 어우러져 최고의 조화를 이루는 피자.</p>
                </div>

                
            </div>
        </main>
    </div>

    <footer>
        <p>&copy; 2025 피자집. 모든 권리 보유.</p>
    </footer>
</body>
</html>
