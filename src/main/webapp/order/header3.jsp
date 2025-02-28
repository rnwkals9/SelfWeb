<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<header>
    <nav>
        <ul>
            <% if (session.getAttribute("uname") != null) { %>
                <li><strong><%= session.getAttribute("uname") %>님 환영합니다!</strong></li>
                <li><a href="../logout.jsp">로그아웃</a></li> <!-- 로그인 상태면 로그아웃 버튼 -->
            <% } else { %>
                <li><a href="../signup.jsp">회원가입</a></li>
                <li><a href="../login.jsp">로그인</a></li>
            <% } %>

            <li><a href="../menu.jsp">메뉴보기</a></li>
            <li><a href="order.jsp">주문하기</a></li>
            <li><a href="cart.jsp">장바구니</a></li>
            <li><a href="../Userinfo.jsp">내 정보</a></li>
            <li><a href=../notice/notice.jsp>게시판</a></li>
        </ul>
    </nav>
</header>

