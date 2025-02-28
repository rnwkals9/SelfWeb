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
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring5fs?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Seoul", "root", "1234");

        // 사용자 정보 가져오기
        String sql = "SELECT * FROM pizza WHERE id=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            uname = rs.getString("uname");
            sex = rs.getString("sex");
            phonenum = rs.getString("phonenum");
        }

        // 사용자의 주문 내역 가져오기 (주문 날짜순으로 정렬)
        String sqlOrders = "SELECT order_id, pizza, size, quantity, toppings, price, order_date FROM orders WHERE user_id = ? ORDER BY order_date ASC";
        pstmt = conn.prepareStatement(sqlOrders);
        pstmt.setString(1, id);
        ResultSet rsOrders = pstmt.executeQuery();

        // 로그인한 사용자별 주문번호 초기화
        int userOrderId = 1;
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 정보</title>
    <link rel="stylesheet" href="mainpage.css">
    <style>
        .user-container {
            width: 80%;
            margin: auto;
            text-align: center;
            padding: 20px;
        }
        .info-box {
            background-color: #fffaf0;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            text-align: left;
            margin-bottom: 20px;
        }
        .info-box h2 {
            color: #ff6600;
            border-bottom: 2px solid #ff6600;
            padding-bottom: 10px;
            margin-bottom: 15px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #FF9800;
            color: white;
        }
        td {
            background-color: #fffaf0;
        }
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
            margin-top: 15px;
        }
        .logout-btn:hover {
            background-color: #cc0000;
        }
        .no-orders {
            font-size: 18px;
            color: gray;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="user-container">
        <%@ include file="header.jsp" %> <!-- 공통 헤더 포함 -->

        <div class="info-box">
            <h2>내 정보</h2>
            <p><strong>ID:</strong> <%= id %></p>
            <p><strong>이름:</strong> <%= uname %></p>
            <p><strong>성별:</strong> <%= sex %></p>
            <p><strong>전화번호:</strong> <%= phonenum %></p>
            <a href="logout.jsp" class="logout-btn">로그아웃</a>
        </div>

        <div class="info-box">
            <h2>주문 내역</h2>

            <%
                if (!rsOrders.isBeforeFirst()) { // 주문 내역이 없을 경우
            %>
                <p class="no-orders">주문 내역이 없습니다.</p>
            <%
                } else {
            %>
                <table>
                    <tr>
                        <th>주문 번호</th>
                        <th>피자 종류</th>
                        <th>크기</th>
                        <th>수량</th>
                        <th>토핑</th>
                        <th>가격</th>
                        <th>주문 날짜</th>
                    </tr>
                    <%
                        while (rsOrders.next()) {
                    %>
                    <tr>
                        <td><%= userOrderId++ %></td> <%-- 사용자별 주문번호 1부터 시작 --%>
                        <td><%= rsOrders.getString("pizza") %></td>
                        <td><%= rsOrders.getString("size") %></td>
                        <td><%= rsOrders.getInt("quantity") %></td>
                        <td><%= rsOrders.getString("toppings") %></td>
                        <td><%= rsOrders.getInt("price") %> 원</td>
                        <td><%= rsOrders.getTimestamp("order_date") %></td>
                    </tr>
                    <%
                        }
                    %>
                </table>
            <%
                }
            %>
        </div>
    </div>

    <%@ include file="footer.jsp" %> <!-- 공통 푸터 포함 -->
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('내 정보를 불러오는 중 오류 발생.'); window.location.href = 'menu.jsp';</script>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
