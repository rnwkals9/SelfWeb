<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문하기</title>
    <link rel="stylesheet" href="mainpage.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>주문하기</h1>
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
            <h2>주문 폼</h2>
            <form action="/order" method="post">
                <div class="order-container">
                    <!-- 치즈 피자 -->
                    <label class="order-item">
                        <input type="radio" name="pizza" value="cheese" required>
                        <img src="images/pizza1.jpg" alt="치즈 피자">
                        <span>치즈 피자</span>
                    </label>

                    <!-- 페페로니 피자 -->
                    <label class="order-item">
                        <input type="radio" name="pizza" value="pepperoni">
                        <img src="images/pizza22.jpg" alt="페페로니 피자">
                        <span>페페로니 피자</span>
                    </label>

                    <!-- 콤비네이션 피자 -->
                    <label class="order-item">
                        <input type="radio" name="pizza" value="combination">
                        <img src="images/pizza3.jpg" alt="콤비네이션 피자">
                        <span>콤비네이션 피자</span>
                    </label>
                </div>

                <br>

                <label for="quantity">수량:</label>
                <input type="number" id="quantity" name="quantity" min="1" required><br><br>

                <button type="submit">주문하기</button>
            </form>
        </main>
    </div>

    <footer>
        <p>&copy; 2025 피자집. 모든 권리 보유.</p>
    </footer>
</body>
</html>
