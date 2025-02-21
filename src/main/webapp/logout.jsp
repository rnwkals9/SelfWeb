<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
    // 로그인 쿠키 삭제
    Cookie loginCookie = new Cookie("Id", "");
    loginCookie.setMaxAge(0);
    response.addCookie(loginCookie);
    
    response.sendRedirect("login.jsp");
%> 