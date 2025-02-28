<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // 세션에서 사용자 정보 가져오기
    String uname = (String) session.getAttribute("uname");
    String userId = null;

    if (uname != null) {
        try {
            String url = "jdbc:mysql://localhost:3306/spring5fs";
            String user = "root";
            String password = "1234";

            // 데이터베이스 연결
            Class.forName("com.mysql.cj.jdbc.Driver");
            try (Connection conn = DriverManager.getConnection(url, user, password);
                 PreparedStatement pstmt = conn.prepareStatement("SELECT id FROM pizza WHERE uname = ?")) {

                pstmt.setString(1, uname);
                ResultSet rs = pstmt.executeQuery();

                if (rs.next()) {
                    userId = rs.getString("id"); // 사용자 ID 가져오기
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 로그인되지 않은 경우 로그인 페이지로 리디렉트
    if (userId == null) {
        response.sendRedirect("../login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 작성</title>
    <link rel="stylesheet" href="../mainpage.css">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f5f5f5;
            margin: 0;
            padding: 0;
        }

        .container {
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        h2 {
            color: #333;
            margin-bottom: 20px;
            font-size: 26px;
            font-weight: bold;
        }

        form {
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
        }

        label {
            font-weight: bold;
            text-align: left;
            width: 100%;
            max-width: 500px;
            font-size: 16px;
        }

        input[type="text"],
        textarea {
            width: 100%;
            max-width: 500px;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 16px;
            transition: 0.3s;
            background: #fafafa;
        }

        input[type="text"]:focus,
        textarea:focus {
            border-color: #FF9800;
            outline: none;
            background: #fff;
            box-shadow: 0 0 5px rgba(255, 152, 0, 0.5);
        }

        textarea {
            resize: vertical;
            height: 160px;
        }

        .btn-container {
            margin-top: 20px;
        }

        button {
            width: 100%;
            max-width: 500px;
            padding: 12px;
            font-size: 18px;
            font-weight: bold;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
            background-color: #FF9800;
            color: white;
            text-transform: uppercase;
        }

        button:hover {
            background-color: #e68900;
        }

    </style>
</head>
<body>
    <div class="container">
        <%@ include file="header2.jsp" %> <!-- 공통 헤더 포함 -->

        <h2>📢 게시글 작성</h2>
        <form action="noticeProcess.jsp" method="post">
            <label for="title">제목</label>
            <input type="text" id="title" name="title" required placeholder="제목을 입력하세요">

            <label for="content">내용</label>
            <textarea id="content" name="content" rows="5" required placeholder="내용을 입력하세요"></textarea>

            <!-- 사용자 ID를 hidden 필드로 전달 -->
            <input type="hidden" name="userId" value="<%= userId %>">

            <div class="btn-container">
                <button type="submit">✍ 작성 완료</button>
            </div>
        </form>
    </div>

    <%@ include file="../footer.jsp" %> <!-- 공통 푸터 포함 -->
</body>
</html>
