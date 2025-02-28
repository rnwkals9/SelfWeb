<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*, java.text.SimpleDateFormat" %>

<%
    String no = request.getParameter("no");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String sql = "SELECT n.no, n.title, n.content, n.author, n.created_at, p.uname FROM notice n LEFT JOIN pizza p ON n.author = p.id WHERE n.no = ?";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring5fs", "root", "1234");

        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, no);
        rs = pstmt.executeQuery();

        if (!rs.next()) {
            response.sendRedirect("notice.jsp");
            return;
        }

        // 게시글의 작성자 id 가져오기
        String authorId = rs.getString("author");

        // 현재 로그인한 사용자 가져오기
        String uname = (String) session.getAttribute("uname");
        String loggedInUserId = null;
        if (uname != null) {
            // 로그인한 사용자의 id 가져오기
            String userSql = "SELECT id FROM pizza WHERE uname = ?";
            pstmt = conn.prepareStatement(userSql);
            pstmt.setString(1, uname);
            ResultSet userRs = pstmt.executeQuery();
            if (userRs.next()) {
                loggedInUserId = userRs.getString("id");
            }
        }

        // 시간 포맷팅
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String formattedTime = rs.getTimestamp("created_at") != null ? sdf.format(rs.getTimestamp("created_at")) : "알 수 없음";

        // 게시글 내용 가져오기
        String content = rs.getString("content");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시글 상세보기</title>
    <link rel="stylesheet" href="../mainpage.css">
    <style>
        /* 게시글 컨테이너 */
        .post-container {
            max-width: 700px;
            margin: 50px auto;
            padding: 30px;
            background: white;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            text-align: center;
        }

        /* 제목 스타일 */
        .post-title {
            font-size: 24px;
            font-weight: bold;
            color: #FF9800;
            margin-bottom: 15px;
        }

        /* 작성자 정보 */
        .post-meta {
            font-size: 14px;
            color: #777;
            margin-bottom: 15px;
            border-bottom: 1px solid #ddd;
            padding-bottom: 10px;
        }

        /* 게시글 내용 */
        .post-content {
            font-size: 16px;
            line-height: 1.6;
            color: #333;
            text-align: left;
            margin-top: 10px;
        }

        /* 버튼 스타일 */
        .btn-container {
            display: flex;
            justify-content: center;
            gap: 15px;
            margin-top: 20px;
        }

        .btn {
            padding: 12px 18px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            transition: 0.3s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-edit {
            background-color: #FF9800;
        }

        .btn-edit:hover {
            background-color: #e68900;
        }

        .btn-back {
            background-color: #4CAF50;
        }

        .btn-back:hover {
            background-color: #388E3C;
        }
    </style>
</head>
<body>
    <div class="container">
        <%@ include file="header2.jsp" %>

        <main>
            <div class="post-container">
                <h2 class="post-title">📌 <%= rs.getString("title") %></h2>
                <div class="post-meta">
                    🖊 작성자: <%= rs.getString("uname") != null ? rs.getString("uname") : "알 수 없음" %> | 🕒 작성일: <%= formattedTime %>
                </div>
                <hr>
                <div class="post-content">
                    <%= content != null && !content.isEmpty() ? content.replaceAll("\n", "<br>") : "📄 내용이 없습니다." %>
                </div>

                <div class="btn-container">
                    <% if (loggedInUserId != null && authorId.equals(loggedInUserId)) { %>
                        <!-- 게시글 작성자와 로그인한 사용자가 일치할 경우, 수정 버튼 표시 -->
                        <a href="noticeEdit.jsp?no=<%= no %>" class="btn btn-edit">✏ 수정</a>
                    <% } %>
                    <a href="notice.jsp" class="btn btn-back">📜 목록으로</a>
                </div>
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
