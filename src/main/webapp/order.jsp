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
                    <li><a href="/signup">회원가입</a></li>
                    <li><a href="/login">로그인</a></li>
                    <li><a href="/menu">메뉴보기</a></li>
                    <li><a href="/order">주문하기</a></li>
                    <li><a href="/store">가까운 매장 찾기</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <h2>주문 폼</h2>
            <form action="/order" method="post">
                <label for="pizza">피자 선택:</label>
                <select id="pizza" name="pizza">
                    <option value="cheese">치즈 피자</option>
                    <option value="pepperoni">페페로니 피자</option>
                    <option value="combination">콤비네이션 피자</option>
                </select><br><br>

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
