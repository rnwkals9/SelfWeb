<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String no = request.getParameter("no");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = "SELECT n.no, n.title, n.content, n.author, n.created_at, p.uname FROM notice n LEFT JOIN pizza p ON n.author = p.id WHERE n.no = ?";

    String title = "";
    String content = "";
    String uname = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring5fs", "root", "1234");

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, no);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            title = rs.getString("title");
            content = rs.getString("content");
            uname = rs.getString("uname");
        } else {
            response.sendRedirect("notice.jsp");
            return;
        }

        // 게시글 작성자와 로그인한 사용자가 일치하는지 확인
        String loggedInUser = (String) session.getAttribute("uname");
        if (loggedInUser == null || !loggedInUser.equals(uname)) {
            response.sendRedirect("notice.jsp"); // 권한 없는 사용자가 접근 시 리디렉트
            return;
        }
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 수정</title>
    <link rel="stylesheet" href="../mainpage.css">
    <style>
        /* 컨테이너 스타일 */
        .post-edit-container {
            max-width: 600px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        /* 제목 스타일 */
        .post-edit-container h2 {
            color: #FF9800;
            margin-bottom: 20px;
        }

        /* 입력 필드 스타일 */
        .form-group {
            margin-bottom: 15px;
            text-align: left;
        }

        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
            color: #333;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 14px;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
        }

        /* 버튼 스타일 */
        .btn {
            display: inline-block;
            padding: 12px 20px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            background-color: #FF9800;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
            text-decoration: none;
            margin-top: 10px;
        }

        .btn:hover {
            background-color: #e68900;
        }

        /* 목록으로 돌아가기 버튼 */
        .back-btn {
            background-color: #4CAF50;
            margin-left: 10px;
        }

        .back-btn:hover {
            background-color: #388E3C;
        }

    </style>
</head>
<body>
    <div class="container">
        <%@ include file="header2.jsp" %>

        <main>
            <div class="post-edit-container">
                <h2>📃 게시글 수정</h2>
                <form action="noticeProcess.jsp" method="post">
                    <input type="hidden" name="no" value="<%= no %>">

                    <div class="form-group">
                        <label for="title">제목</label>
                        <input type="text" id="title" name="title" value="<%= title %>" required>
                    </div>

                    <div class="form-group">
                        <label for="content">내용</label>
                        <textarea id="content" name="content" rows="5" required><%= content %></textarea>
                    </div>

                    <button type="submit" class="btn">✏ 수정하기</button>
                    <a href="notice.jsp" class="btn back-btn">📜 목록으로</a>
                </form>
            </div>
        </main>
    </div>

    <%@ include file="../footer.jsp" %>
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
