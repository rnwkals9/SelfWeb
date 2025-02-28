<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList, java.util.HashMap" %>
<%
    request.setCharacterEncoding("UTF-8");  // 🔥 POST 요청의 문자 인코딩을 UTF-8로 설정
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니</title>
    <link rel="stylesheet" href="../mainpage.css">
    <link rel="stylesheet" href="cart.css">
<%

	// 장바구니 세션 가져오기 (null 체크 추가)
	ArrayList<HashMap<String, String>> cart = (ArrayList<HashMap<String, String>>) session.getAttribute("cart");
	
	if (cart == null) {
	    cart = new ArrayList<>();
	    session.setAttribute("cart", cart);
	}



    // 📥 주문 정보 받기 (한글 값이 직접 저장됨)
    String pizza = request.getParameter("pizza");
    String size = request.getParameter("size");
    String quantityStr = request.getParameter("quantity");
    String[] toppingsArr = request.getParameterValues("topping");
    String priceStr = request.getParameter("totalPrice");

    if (pizza != null && size != null && quantityStr != null && priceStr != null) {
        int quantity = Integer.parseInt(quantityStr);
        int price = Integer.parseInt(priceStr);

        // 🏷️ 선택된 토핑을 문자열로 변환 (콤마 구분)
        String toppings = (toppingsArr != null) ? String.join(", ", toppingsArr) : "없음";

        boolean itemExists = false;

        // 🛒 장바구니에서 동일한 항목이 있는지 확인하고 수량 업데이트
        for (HashMap<String, String> item : cart) {
            if (item.get("pizza").equals(pizza) && item.get("size").equals(size) && item.get("toppings").equals(toppings)) {
                int updatedQuantity = Integer.parseInt(item.get("quantity")) + quantity;
                item.put("quantity", String.valueOf(updatedQuantity));

                int updatedPrice = Integer.parseInt(item.get("price")) + price;
                item.put("price", String.valueOf(updatedPrice));

                itemExists = true;
                break;
            }
        }

        // 🆕 동일한 항목이 없으면 새로 추가
        if (!itemExists) {
            HashMap<String, String> item = new HashMap<>();
            item.put("pizza", pizza);
            item.put("size", size);
            item.put("quantity", String.valueOf(quantity));
            item.put("toppings", toppings);
            item.put("price", String.valueOf(price));

            cart.add(item);
        }

        // 🛒 세션에 장바구니 저장
        session.setAttribute("cart", cart);
    }
%>


</head>
<body>

    <div class="cart-container">
        <%@ include file="header3.jsp" %>

        <h2>🛒 장바구니</h2>

        <%
            if (cart.isEmpty()) {
        %>
            <p>장바구니가 비어 있습니다.</p>
        <%
            } else {
                int totalCartPrice = 0;
        %>
        <div class="cart-items">
            <%
                for (int i = 0; i < cart.size(); i++) {
                    HashMap<String, String> cartItem = cart.get(i);
                    int itemPrice = Integer.parseInt(cartItem.get("price"));
                    totalCartPrice += itemPrice;
            %>
            <%
                // 🖼️ 피자 이미지 매핑
                HashMap<String, String> pizzaImages = new HashMap<>();
                pizzaImages.put("치즈 피자", "pizza1.jpg");
                pizzaImages.put("페퍼로니 피자", "pizza22.jpg");
                pizzaImages.put("콤비네이션 피자", "pizza3.jpg");
            %>
            <div class="cart-item">
                <img src="../images/<%= pizzaImages.get(cartItem.get("pizza")) %>" alt="<%= cartItem.get("pizza") %>">
                <p>🍕 <strong><%= cartItem.get("pizza") %></strong></p>  <!-- 이미 한글 값이라 변환 불필요 -->
                <p>📏 크기: <%= cartItem.get("size") %></p>  <!-- 이미 한글 값이라 변환 불필요 -->
                <p>🔢 수량: <%= cartItem.get("quantity") %></p>
                <p>🌟 토핑: <%= cartItem.get("toppings") %></p>  <!-- 이미 한글 값이라 변환 불필요 -->
                <p class="price">💰 <%= itemPrice %> 원</p>
                <a href="removeItem.jsp?index=<%= i %>" class="delete-btn">🗑️</a>
            </div>
            <%
                }
            %>
        </div>

        <p class="total-price">💵 총 주문 금액: <%= totalCartPrice %> 원</p>

        <div class="btn-container">
            <form action="orderProcess.jsp" method="post">
                <button type="submit" class="btn">✅ 주문하기</button>
            </form>
            <form action="clearCart.jsp" method="post">
                <button type="submit" class="btn">🗑️ 장바구니 비우기</button>
            </form>
        </div>
        <%
            }
        %>
    </div>
    <%@ include file="../footer.jsp" %>
</body>
</html>
