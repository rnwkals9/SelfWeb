<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // 세션 무효화 (모든 세션 속성 삭제)
    session.invalidate();

    // 로그인 쿠키 삭제
    Cookie loginCookie = new Cookie("Id", "");
    loginCookie.setMaxAge(0);
    response.addCookie(loginCookie);
    
    // 로그아웃 후 로그인 페이지로 이동
    response.sendRedirect("login.jsp");
%>
