<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // 현재 로그인한 사용자 가져오기
    String uname = (String) session.getAttribute("uname");

    if (uname == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmtUser = null;
    PreparedStatement pstmtOrders = null;
    ResultSet rsUser = null;
    ResultSet rsOrders = null;
    String userId = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring5fs", "root", "1234");

        // 로그인한 사용자의 ID 가져오기
        String sqlUser = "SELECT id FROM pizza WHERE uname = ?";
        pstmtUser = conn.prepareStatement(sqlUser);
        pstmtUser.setString(1, uname);
        rsUser = pstmtUser.executeQuery();

        if (rsUser.next()) {
            userId = rsUser.getString("id"); // 사용자의 ID 가져오기
        }

        if (userId == null) {
            out.println("<script>alert('사용자 정보를 찾을 수 없습니다. 다시 로그인해주세요.'); window.location.href = 'login.jsp';</script>");
            return;
        }

        // 사용자의 주문 내역 가져오기 (사용자별 주문번호 적용)
        String sqlOrders = "SELECT (@rownum := @rownum + 1) AS user_order_id, o.* " +
                           "FROM orders o, (SELECT @rownum := 0) r " +
                           "WHERE o.user_id = ? ORDER BY o.order_date DESC";
        pstmtOrders = conn.prepareStatement(sqlOrders);
        pstmtOrders.setString(1, userId);
        rsOrders = pstmtOrders.executeQuery();
%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문 내역</title>
    <link rel="stylesheet" href="../mainpage.css">
    <style>
        .order-container {
            width: 80%;
            margin: auto;
            text-align: center;
            padding: 20px;
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
        .no-orders {
            font-size: 18px;
            color: gray;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="order-container">
        <%@ include file="header3.jsp" %>

        <h2><%= uname %>님의 주문 내역</h2>

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
                    <td><%= rsOrders.getInt("user_order_id") %></td> <!-- 사용자별 주문번호 -->
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
    <%@ include file="../footer.jsp" %>
</body>
</html>

<%
    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('주문 내역을 불러오는 중 오류 발생.'); window.location.href = 'menu.jsp';</script>");
    } finally {
        if (rsUser != null) try { rsUser.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (rsOrders != null) try { rsOrders.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmtUser != null) try { pstmtUser.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmtOrders != null) try { pstmtOrders.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
