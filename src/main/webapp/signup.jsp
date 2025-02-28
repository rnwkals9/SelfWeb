<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="mainpage.css">
    <style>
        .signup-container {
            max-width: 400px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            color: #FF9800;
            margin-bottom: 20px;
        }

        .input-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .input-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }

        .input-group input, .input-group select {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .btn-signup {
            width: 100%;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            background-color: #FF9800;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
        }

        .btn-signup:hover {
            background-color: #e68900;
        }

        .login-link {
            margin-top: 15px;
            font-size: 14px;
        }

        .login-link a {
            color: #FF9800;
            font-weight: bold;
            text-decoration: none;
        }

        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <%@ include file="header.jsp" %> <!-- 공통 헤더 포함 -->

        <div class="signup-container">
            <h2>회원가입</h2>
            <form action="signupProcess.jsp" method="post">
                <div class="input-group">
                    <label for="username">아이디</label>
                    <input type="text" id="username" name="id" required>
                </div>

                <div class="input-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" required>
                </div>

                <div class="input-group">
                    <label for="name">이름</label>
                    <input type="text" id="name" name="uname" required>
                </div>

                <div class="input-group">
                    <label for="sex">성별</label>
                    <select id="sex" name="sex" required>
                        <option value="">성별 선택</option>
                        <option value="M">남자</option>
                        <option value="F">여자</option>
                    </select>
                </div>

                <div class="input-group">
                    <label for="phonenum">전화번호</label>
                    <input type="tel" id="phonenum" name="phonenum" required placeholder="010-1234-5678">
                </div>

                <button type="submit" class="btn-signup">가입하기</button>
            </form>

            <p class="login-link">이미 계정이 있으신가요? <a href="login.jsp">로그인</a></p>
        </div>
    </div>

    <%@ include file="footer.jsp" %> <!-- 공통 푸터 포함 -->
</body>
</html>
