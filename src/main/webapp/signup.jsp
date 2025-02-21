<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="mainpage.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>회원가입</h1>
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
            <h2>회원가입 폼</h2>
            <form action="signupProcess.jsp" method="post">
                <label for="username">아이디:</label>
                <input type="text" id="username" name="id" required><br><br>

                <label for="password">비밀번호:</label>
                <input type="password" id="password" name="password" required><br><br>

                <label for="name">이름:</label>
                <input type="text" id="name" name="uname" required><br><br>

                <label for="sex">성별:</label>
                <select id="sex" name="sex" required>
                    <option value="">성별 선택</option>
                    <option value="M">남자</option>
                    <option value="F">여자</option>
                </select><br><br>

                <label for="phonenum">전화번호:</label>
                <input type="tel" id="phonenum" name="phonenum" required placeholder="010-1234-5678"><br><br>

                <button type="submit">가입하기</button>
            </form>
        </main>
    </div>

    <footer>
        <p>&copy; 2025 피자집. 모든 권리 보유.</p>
    </footer>
</body>
</html>
