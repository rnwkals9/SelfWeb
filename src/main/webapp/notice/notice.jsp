<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String URL = "jdbc:mysql://localhost:3306/spring5fs";
    String USER = "root";
    String PASSWORD = "1234";

    // 게시판 목록을 가져오는 SQL (ROW_NUMBER() 사용)
    String sql = "SELECT n.no, n.title, n.content, n.author, n.created_at, p.uname, " + 
                 "ROW_NUMBER() OVER (ORDER BY n.no ASC) AS row_num " + 
                 "FROM notice n LEFT JOIN pizza p ON n.author = p.id ORDER BY n.no ASC";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게시판</title>
    <link rel="stylesheet" href="../mainpage.css">
    <style>
        .notice-container {
            max-width: 800px;
            margin: 50px auto;
            background: rgba(255, 255, 255, 0.9);
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background: white;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #e74c3c;
            color: white;
        }
        tr:nth-child(even) {
            background-color: #f9f9f9;
        }
        td a {
            color: #333;
            text-decoration: none;
            font-weight: bold;
        }
        td a:hover {
            color: #e67e22;
            text-decoration: underline;
        }
        .write-btn {
            display: block;
            width: 150px;
            margin: 20px auto;
            padding: 10px;
            background-color: #f39c12;
            color: white;
            text-align: center;
            border-radius: 5px;
            text-decoration: none;
            font-weight: bold;
        }
        .write-btn:hover {
            background-color: #e67e22;
        }
        .delete-btn {
            color: red;
            cursor: pointer;
            font-weight: bold;
        }
        .delete-btn:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <div class="container">
        <%@ include file="header2.jsp" %> <!-- 공통 헤더 포함 -->

        <main>
            <div class="notice-container">
                <h2>게시판 목록</h2>
                <table>
                    <tr>
                        <th>번호</th>
                        <th>제목</th>
                        <th>작성자</th>
                        <th>작성일</th>
                        <th>삭제</th>
                    </tr>
                    <%
                        try {
                            Class.forName("com.mysql.cj.jdbc.Driver");
                            conn = DriverManager.getConnection(URL, USER, PASSWORD);
                            pstmt = conn.prepareStatement(sql);
                            rs = pstmt.executeQuery();

                            while (rs.next()) {
                                int rowNum = rs.getInt("row_num");  // 동적으로 매겨진 번호
                                String title = rs.getString("title");
                                String authorName = rs.getString("uname"); // 작성자의 uname 가져오기
                                String createdAt = rs.getString("created_at");
                                String content = rs.getString("content"); // 게시글 내용 가져오기
                    %>
                    <tr>
                        <td><%= rowNum %></td>  <!-- 동적 번호 출력 -->
                        <td><a href="noticeDetail.jsp?no=<%= rs.getInt("no") %>"><%= title %></a></td>
                        <td><%= authorName %></td>
                        <td><%= createdAt %></td>
                        <td>
                            <a href="noticeDelete.jsp?no=<%= rs.getInt("no") %>" class="delete-btn" onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
                        </td>
                    </tr>
                    <% 
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                        } finally {
                            if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                            if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                        }
                    %>
                </table>
                <a href="./noticeWrite.jsp" class="write-btn">글 작성하기</a>
            </div>
        </main>
    </div>

    <%@ include file="../footer.jsp" %> <!-- 공통 푸터 포함 -->
</body>
</html>
