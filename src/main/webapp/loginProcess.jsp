<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    String id = request.getParameter("id");
    String pass = request.getParameter("pass");

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        // MySQL JDBC 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring5fs?useUnicode=true&characterEncoding=UTF-8&serverTimezone=Asia/Seoul", "root", "1234");

        // 아이디와 비밀번호로 사용자 조회
        String sql = "SELECT uname FROM pizza WHERE id=? AND pass=?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        pstmt.setString(2, pass);

        rs = pstmt.executeQuery();

        if (rs.next()) { 
            String uname = rs.getString("uname"); // DB에서 uname 가져오기
            
            session.setAttribute("id", id);
            session.setAttribute("pass", pass);
            session.setAttribute("uname", uname); // 세션에 사용자 이름 저장

            response.sendRedirect("Userinfo.jsp"); // 로그인 성공 시 이동
        } else {
%>
            <script>
                alert("로그인 실패! 아이디 또는 비밀번호를 확인하세요.");
                window.location.href = "login.jsp";
            </script>
<%
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        // 자원 해제
        if (rs != null) try { rs.close(); } catch (Exception e) {}
        if (pstmt != null) try { pstmt.close(); } catch (Exception e) {}
        if (conn != null) try { conn.close(); } catch (Exception e) {}
    }
%>
