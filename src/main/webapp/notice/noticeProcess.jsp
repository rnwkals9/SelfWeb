<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<%
    request.setCharacterEncoding("UTF-8");

    String title = request.getParameter("title");
    String content = request.getParameter("content");
    String no = request.getParameter("no"); // 수정 시 게시글 번호를 받음

    // 로그인한 사용자 정보 가져오기
    String uname = (String) session.getAttribute("uname");  // 세션에서 사용자 이름 가져오기

    if (uname == null) {
        response.sendRedirect("login.jsp"); // 로그인되지 않은 경우 로그인 페이지로 리디렉트
        return;
    }

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    // 사용자 이름을 사용해 pizza 테이블에서 id를 가져오는 SQL
    String getUserIdSql = "SELECT id FROM pizza WHERE uname = ?";

    // 작성자의 id를 가져오는 변수
    String authorId = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/spring5fs?useUnicode=true&characterEncoding=UTF-8", "root", "1234");

        // 사용자 이름을 이용해 id 가져오기
        pstmt = conn.prepareStatement(getUserIdSql);
        pstmt.setString(1, uname);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            authorId = rs.getString("id");  // 사용자 id 가져오기
        }

        if (authorId == null) {
            out.println("<script>alert('사용자를 찾을 수 없습니다.'); window.location.href = 'login.jsp';</script>");
            return;
        }

        if (no == null || no.isEmpty()) {
            // 게시글 삽입
            String sql = "INSERT INTO notice (title, content, author, created_at) VALUES (?, ?, ?, NOW())";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, title);
            pstmt.setString(2, content);
            pstmt.setString(3, authorId);  // 사용자의 id를 author로 설정

            pstmt.executeUpdate();

            response.sendRedirect("notice.jsp");  // 게시글 작성 후 게시판으로 리디렉트
        } else {
            // 게시글 수정
            String checkAuthorSql = "SELECT author FROM notice WHERE no = ?";
            pstmt = conn.prepareStatement(checkAuthorSql);
            pstmt.setString(1, no);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String postAuthorId = rs.getString("author");

                // 게시글 작성자와 로그인한 사용자가 일치하는지 확인
                if (!authorId.equals(postAuthorId)) {
                    out.println("<script>alert('이 게시글을 수정할 권한이 없습니다.'); window.location.href = 'notice.jsp';</script>");
                    return;
                }

                String updateSql = "UPDATE notice SET title = ?, content = ? WHERE no = ?";
                pstmt = conn.prepareStatement(updateSql);
                pstmt.setString(1, title);
                pstmt.setString(2, content);
                pstmt.setString(3, no);

                pstmt.executeUpdate();

                response.sendRedirect("noticeDetail.jsp?no=" + no);  // 수정 후 상세 페이지로 리디렉트
            } else {
                out.println("<script>alert('게시글을 찾을 수 없습니다.'); window.location.href = 'notice.jsp';</script>");
            }
        }

    } catch (Exception e) {
        e.printStackTrace();
        out.println("<script>alert('오류 발생: " + e.getMessage() + "'); window.location.href = 'notice.jsp';</script>");
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
