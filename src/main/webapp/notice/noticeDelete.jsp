<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ page import="java.sql.*" %>

<%
    String no = request.getParameter("no");  // 삭제할 글 번호
    String uname = (String) session.getAttribute("uname"); // 로그인한 사용자 이름 가져오기

    if (uname == null) {
        out.println("<script>alert('로그인이 필요합니다.'); window.location.href = 'login.jsp';</script>");
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    Statement stmt = null;
    ResultSet rs = null;

    try {
        // MySQL 드라이버 로드
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring5fs", "root", "1234");

        // 1. 해당 게시글 작성자의 id 확인
        String checkSql = "SELECT author FROM notice WHERE no = ?"; // author는 id로 저장됨
        pstmt = conn.prepareStatement(checkSql);
        pstmt.setInt(1, Integer.parseInt(no));
        rs = pstmt.executeQuery();

        if (rs.next()) {
            String authorId = rs.getString("author");  // 게시글 작성자의 id를 가져옴

            // 로그인한 사용자 이름을 이용해 사용자 id를 가져오는 쿼리
            String getUserIdSql = "SELECT id FROM pizza WHERE uname = ?";
            pstmt = conn.prepareStatement(getUserIdSql);
            pstmt.setString(1, uname);
            ResultSet userIdRs = pstmt.executeQuery();

            String loggedInUserId = null;
            if (userIdRs.next()) {
                loggedInUserId = userIdRs.getString("id");
            }

            // 로그인한 사용자 id와 게시글 작성자의 id 비교
            if (!authorId.equals(loggedInUserId)) { // 로그인한 사용자와 작성자가 다르면 삭제 불가
                out.println("<script>alert('본인이 작성한 글만 삭제할 수 있습니다.'); window.location.href = 'notice.jsp';</script>");
                return;
            }
        } else {
            out.println("<script>alert('게시글을 찾을 수 없습니다.'); window.location.href = 'notice.jsp';</script>");
            return;
        }

        // 2. 게시글 삭제
        String deleteSql = "DELETE FROM notice WHERE no = ?";
        pstmt = conn.prepareStatement(deleteSql);
        pstmt.setInt(1, Integer.parseInt(no));
        int rowsAffected = pstmt.executeUpdate();  // 게시글 삭제

        if (rowsAffected > 0) {
            // 3. 삭제된 번호 이후의 글 번호를 1씩 내림
            String updateSql = "UPDATE notice SET no = no - 1 WHERE no > ?";
            pstmt = conn.prepareStatement(updateSql);
            pstmt.setInt(1, Integer.parseInt(no));
            pstmt.executeUpdate();

            // 4. AUTO_INCREMENT 값을 현재 최대 값으로 리셋
            stmt = conn.createStatement();
            String resetSql = "SELECT MAX(no) FROM notice";
            rs = stmt.executeQuery(resetSql);

            if (rs.next()) {
                int maxNo = rs.getInt(1);
                String alterSql = "ALTER TABLE notice AUTO_INCREMENT = " + (maxNo + 1);
                pstmt = conn.prepareStatement(alterSql);
                pstmt.executeUpdate();
            }

            response.sendRedirect("notice.jsp");
        } else {
            out.println("<script>alert('게시글 삭제 실패'); window.location.href = 'notice.jsp';</script>");
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); window.location.href = 'notice.jsp';</script>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
