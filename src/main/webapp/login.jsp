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
                    <li><a href="signup.jsp">회원가입</a></li>
                    <li><a href="login.jsp">로그인</a></li>
                    <li><a href="menu.jsp">메뉴보기</a></li>
                    <li><a href="order.jsp">주문하기</a></li>
                    <li><a href="Userinfo.jsp">내 정보</a></li>
                </ul>
            </nav>
        </header>

        <main>
            <h2>로그인</h2>
            <form action="loginProcess.jsp" method="post">
                <label for=userid>아이디:</label>
                <input type="text" id="userid" name="id" required><br><br>

                <label for="password">비밀번호:</label>
                <input type="password" id="password" name="pass" required><br><br>

                <button type="submit">로그인</button>
            </form>
        </main>
    </div>

    <footer>
        <p>&copy; 2025 피자집. 모든 권리 보유.</p>
    </footer>
</body>
</html>
