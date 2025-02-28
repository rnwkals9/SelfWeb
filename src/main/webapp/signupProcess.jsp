<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    // 회원가입 폼에서 데이터 가져오기
    request.setCharacterEncoding("UTF-8");  // 인코딩 설정
    String id = request.getParameter("id");
    String pass = request.getParameter("password");
    String uname = request.getParameter("uname");
    String sex = request.getParameter("sex");
    String phonenum = request.getParameter("phonenum");

    Connection conn = null;
    PreparedStatement pstmt = null;

    try {
        // MySQL 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");

        // 데이터베이스 연결
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring5fs?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Seoul"
, "root", "1234");

        // SQL 쿼리 준비 (회원 정보 삽입)
        String sql = "INSERT INTO pizza (id, pass, uname, sex, phonenum) VALUES (?, ?, ?, ?, ?)";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, pass);
        pstmt.setString(3, uname);
        pstmt.setString(4, sex);
        pstmt.setString(5, phonenum);

        // 쿼리 실행
        int result = pstmt.executeUpdate();

        if (result > 0) {
            // 회원가입 성공 시 로그인 페이지로 이동
            response.sendRedirect("login.jsp");
        } else {
            // 실패 시 회원가입 페이지로 다시 이동
            response.sendRedirect("signup.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        response.sendRedirect("signup.jsp"); // 오류 발생 시 회원가입 페이지로 이동
    } finally {
        try {
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
%>
