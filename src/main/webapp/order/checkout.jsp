<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, java.util.ArrayList, java.util.HashMap" %>

<%
    // DB 연결 정보
    String URL = "jdbc:mysql://localhost:3306/spring5fs";
    String USER = "root";
    String PASSWORD = "1234";

    // 세션에서 장바구니 가져오기
    ArrayList<HashMap<String, String>> cart = (ArrayList<HashMap<String, String>>) session.getAttribute("cart");

    if (cart == null || cart.isEmpty()) {
        out.println("<script>alert('장바구니가 비어있습니다!'); window.location.href='cart.jsp';</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(URL, USER, PASSWORD);

        String sql = "INSERT INTO orders (pizza, size, quantity, price, order_date) VALUES (?, ?, ?, ?, NOW())";
        pstmt = conn.prepareStatement(sql);

        for (HashMap<String, String> item : cart) {
            pstmt.setString(1, item.get("pizza"));
            pstmt.setString(2, item.get("size"));
            pstmt.setInt(3, Integer.parseInt(item.get("quantity")));
            pstmt.setInt(4, Integer.parseInt(item.get("price")));
            pstmt.executeUpdate();
        }

        // 주문 완료 후 장바구니 비우기
        session.removeAttribute("cart");

        out.println("<script>alert('주문이 완료되었습니다!'); window.location.href='orderHistory.jsp';</script>");
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
