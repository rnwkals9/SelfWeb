<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">

<head>
    <link rel="stylesheet" href="order.css">
    
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>주문하기</title>
    <link rel="stylesheet" href="../mainpage.css">
    <script>
        // 피자 가격 설정 (기본 가격)
        const pizzaPrices = {
            "치즈 피자": { "소": 8000, "중": 12000, "대": 15000 },
            "페퍼로니 피자": { "소": 9000, "중": 13000, "대": 16000 },
            "콤비네이션 피자": { "소": 10000, "중": 14000, "대": 17000 }
        };

        // 추가 토핑 가격 설정
        const toppingPrices = {
            "추가 치즈": 2000,
            "버섯": 1500,
            "베이컨": 2500,
            "올리브": 1000
        };

        // 가격 업데이트 함수
        function updatePrice() {
            let selectedPizza = document.querySelector('input[name="pizza"]:checked');
            let selectedSize = document.querySelector('input[name="size"]:checked');
            let quantity = document.getElementById("quantity").value || 1;

            if (!selectedPizza || !selectedSize) {
                document.getElementById("totalPrice").innerText = "0 원";
                return;
            }

            let basePrice = pizzaPrices[selectedPizza.value][selectedSize.value];
            let toppingsTotal = 0;

            document.querySelectorAll('input[name="topping"]:checked').forEach((topping) => {
                toppingsTotal += toppingPrices[topping.value];
            });

            let totalPrice = (basePrice + toppingsTotal) * quantity;
            document.getElementById("totalPrice").innerText = totalPrice.toLocaleString() + " 원";

            // Hidden input 필드에 가격 저장
            document.getElementById("hiddenTotalPrice").value = totalPrice;
        }

        // 페이지 로드 시 기본 가격 업데이트
        window.onload = function () {
            updatePrice();
        };
    </script>
</head>
<body>

    <div class="container">
        <%@ include file="header3.jsp" %>

        <main>
            <h2>주문 폼</h2>
            <form method="post">
                <div class="order-container">
                    <label class="order-item">
                        <input type="radio" name="pizza" value="치즈 피자" required onclick="updatePrice()">
                        <img src="../images/pizza1.jpg" alt="치즈 피자">
                        <span>치즈 피자</span>
                    </label>
                    <label class="order-item">
                        <input type="radio" name="pizza" value="페퍼로니 피자" onclick="updatePrice()">
                        <img src="../images/pizza22.jpg" alt="페퍼로니 피자">
                        <span>페퍼로니 피자</span>
                    </label>
                    <label class="order-item">
                        <input type="radio" name="pizza" value="콤비네이션 피자" onclick="updatePrice()">
                        <img src="../images/pizza3.jpg" alt="콤비네이션 피자">
                        <span>콤비네이션 피자</span>
                    </label>
                </div>
                <br>

                <h3>크기 선택</h3>
                <label><input type="radio" name="size" value="소" required onclick="updatePrice()"> 소 (Small)</label>
                <label><input type="radio" name="size" value="중" onclick="updatePrice()"> 중 (Medium)</label>
                <label><input type="radio" name="size" value="대" onclick="updatePrice()"> 대 (Large)</label>
                <br><br>

                <h3>추가 토핑 (선택 가능)</h3>
                <label><input type="checkbox" name="topping" value="추가 치즈" onclick="updatePrice()"> 추가 치즈 (+2000원)</label><br>
                <label><input type="checkbox" name="topping" value="버섯" onclick="updatePrice()"> 버섯 (+1500원)</label><br>
                <label><input type="checkbox" name="topping" value="베이컨" onclick="updatePrice()"> 베이컨 (+2500원)</label><br>
                <label><input type="checkbox" name="topping" value="올리브" onclick="updatePrice()"> 올리브 (+1000원)</label><br>
                <br>

                <label for="quantity">수량:</label>
                <input type="number" id="quantity" name="quantity" min="1" value="1" required oninput="updatePrice()"><br><br>

                <h3>총 가격: <span id="totalPrice">0 원</span></h3>
                
                <!-- Hidden input으로 총 가격 전달 -->
                <input type="hidden" id="hiddenTotalPrice" name="totalPrice" value="0">

                <button type="submit" formaction="cart.jsp?redirect=orderProcess.jsp" class="btn-order">주문하기</button>

                <button type="submit" formaction="cart.jsp" class="btn-cart">장바구니에 추가</button>
            </form>
        </main>
    </div>

    <%@ include file="../footer.jsp" %>
</body>
</html>
