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

    // 회원 정보 저장 변수
    String uname = "";
    String sex = "";
    String phonenum = "";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring5fs", "root", "1234");

        String sql = "SELECT uname, sex, phonenum FROM pizza WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs.next()) {
        	uname = rs.getString("uname");
            sex = rs.getString("sex").equals("M") ? "남자" : "여자";
            phonenum = rs.getString("phonenum");

            // 조회한 정보 세션에 저장
            session.setAttribute("uname", uname);
            session.setAttribute("sex", sex);
            session.setAttribute("phonenum", phonenum);
			
            

            response.sendRedirect("Userinfo.jsp");
        } else {
            response.sendRedirect("login.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("login.jsp");
    } finally {
        try { if (rs != null) rs.close(); } catch (Exception e) {}
        try { if (pstmt != null) pstmt.close(); } catch (Exception e) {}
        try { if (conn != null) conn.close(); } catch (Exception e) {}
    }
%>
