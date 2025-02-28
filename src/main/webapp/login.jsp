<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인</title>
    <link rel="stylesheet" href="mainpage.css">
    <style>
        .login-container {
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

        .input-group input {
            width: 100%;
            padding: 10px;
            border: 1px solid #ddd;
            border-radius: 5px;
            font-size: 16px;
        }

        .btn-login {
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

        .btn-login:hover {
            background-color: #e68900;
        }

        .signup-link {
            margin-top: 15px;
            font-size: 14px;
        }

        .signup-link a {
            color: #FF9800;
            font-weight: bold;
            text-decoration: none;
        }

        .signup-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <%@ include file="header.jsp" %> <!-- 공통 헤더 포함 -->

        <div class="login-container">
            <h2>로그인</h2>
            <form action="loginProcess.jsp" method="post">
                <div class="input-group">
                    <label for="userid">아이디</label>
                    <input type="text" id="userid" name="id" required>
                </div>

                <div class="input-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="pass" required>
                </div>

                <button type="submit" class="btn-login">로그인</button>
            </form>

            <p class="signup-link">아직 계정이 없으신가요? <a href="signup.jsp">회원가입</a></p>
        </div>
    </div>

    <%@ include file="footer.jsp" %> <!-- 공통 푸터 포함 -->
</body>
</html>
