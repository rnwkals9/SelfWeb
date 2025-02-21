<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<% 
    String id = (String) session.getAttribute("id");

    if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String uname = null;
    String sex = null;
    String phonenum = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring5fs", "root", "1234");

        String sql = "SELECT * FROM pizza WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            uname = rs.getString("uname");  // "uname"을 가져오기
            sex = rs.getString("sex");
            phonenum = rs.getString("phonenum");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보</title>
    <link rel="stylesheet" href="mainpage.css">
    <style>
        .logout-btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            background-color: #ff4d4d;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            text-decoration: none;
            transition: background-color 0.3s ease;
        }

        .logout-btn:hover {
            background-color: #cc0000;
        }
    </style>
</head>
<body>
    <div class="container">
        <header>
            <h1>내 정보</h1>
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
            <h2>내 정보</h2>
            <p>ID: <%= id %></p>
            <p>이름: <%= uname %></p>
            <p>성별: <%= sex %></p>
            <p>전화번호: <%= phonenum %></p>
            <a href="logout.jsp" class="logout-btn">로그아웃</a>
        </main>
    </div>

    <footer>
        <p>&copy; 2025 피자집. 모든 권리 보유.</p>
    </footer>
</body>
</html>
