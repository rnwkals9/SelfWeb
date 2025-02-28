<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*, java.util.ArrayList, java.util.HashMap" %>

<%
    String uname = (String) session.getAttribute("uname");

    if (uname == null) {
        response.sendRedirect("../login.jsp");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;
    String userId = null;

    // 🛒 장바구니 불러오기 (세션에서 가져옴)
    ArrayList<HashMap<String, String>> cart = (ArrayList<HashMap<String, String>>) session.getAttribute("cart");

    // ⚠ 장바구니가 비어있으면 주문 불가
    if (cart == null || cart.isEmpty()) {
        out.println("<script>alert('장바구니가 비어 있습니다.'); window.location.href = 'cart.jsp';</script>");
        return;
    }

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring5fs", "root", "1234");

        // 🔍 로그인한 사용자 ID 가져오기
        String sqlUser = "SELECT id FROM pizza WHERE uname = ?";
        pstmt = conn.prepareStatement(sqlUser);
        pstmt.setString(1, uname);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            userId = rs.getString("id");
        }

        if (userId == null) {
            out.println("<script>alert('사용자 정보를 찾을 수 없습니다. 다시 로그인해주세요.'); window.location.href = 'login.jsp';</script>");
            return;
        }

        // 🛒 `orders` 테이블에 주문 추가
        String sqlOrder = "INSERT INTO orders (user_id, pizza, size, quantity, toppings, price) VALUES (?, ?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sqlOrder);

        for (HashMap<String, String> item : cart) {
            pstmt.setString(1, userId);
            pstmt.setString(2, item.get("pizza"));
            pstmt.setString(3, item.get("size"));
            pstmt.setInt(4, Integer.parseInt(item.get("quantity")));
            pstmt.setString(5, item.get("toppings"));
            pstmt.setInt(6, Integer.parseInt(item.get("price")));

            pstmt.executeUpdate(); // 주문 정보 DB에 저장
        }

        // 🛒 주문이 완료되었으므로 장바구니 비우기 (로그아웃 X)
        session.removeAttribute("cart");

        out.println("<script>alert('주문이 완료되었습니다!'); window.location.href = 'orderList.jsp';</script>");

    } catch (Exception e) {
        e.printStackTrace(); // 콘솔에 오류 출력 (디버깅용)
        
        // 🔥 오류 발생 위치와 메시지를 화면에 표시
        out.println("<h3 style='color:red;'>⚠ 주문 처리 중 오류 발생</h3>");
        out.println("<p>" + e.getMessage() + "</p>");

        // 🔥 오류가 어디서 발생했는지 확인하기 위해 추가
        StackTraceElement[] trace = e.getStackTrace();
        for (StackTraceElement element : trace) {
            out.println("<p>" + element.toString() + "</p>");
        }
    } finally {
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
