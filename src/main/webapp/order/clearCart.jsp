<%@ page language="java" contentType="text/html; charset=UTF-8"%>

<%
    // 로그인 정보는 유지하고 장바구니 데이터만 삭제
    session.removeAttribute("cart"); // 세션에서 'cart'만 삭제
    response.sendRedirect("cart.jsp"); // 장바구니 페이지로 이동
%>
