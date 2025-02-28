<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, java.util.HashMap" %>

<%
    int index = Integer.parseInt(request.getParameter("index"));

    ArrayList<HashMap<String, String>> cart = (ArrayList<HashMap<String, String>>) session.getAttribute("cart");

    if (cart != null && index >= 0 && index < cart.size()) {
        cart.remove(index); // 해당 인덱스의 아이템 삭제
    }

    session.setAttribute("cart", cart); // 세션 업데이트
    response.sendRedirect("cart.jsp"); // 장바구니 페이지로 이동
%>
