<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="mainpage.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>로그인</h1>
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
            <h2>로그인 폼</h2>
            <form action="/login" method="post">
                <label for="username">사용자 이름:</label>
                <input type="text" id="username" name="username" required><br><br>

                <label for="password">비밀번호:</label>
                <input type="password" id="password" name="password" required><br><br>

                <button type="submit">로그인</button>
            </form>
        </main>
    </div>

    <footer>
        <p>&copy; 2025 피자집. 모든 권리 보유.</p>
    </footer>
</body>
</html>
