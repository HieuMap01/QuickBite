<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset='utf-8'>
	<meta http-equiv='X-UA-Compatible' content='IE=edge'>
	<title>Trang chủ</title>
	<meta name='viewport' content='width=device-width, initial-scale=1'>
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
	<%-- CSS --%>
	<jsp:include page = "/WEB-INF/views/customer/layout/css.jsp"></jsp:include>
		
</head>
<body>
	<jsp:include page ="/WEB-INF/views/customer/layout/header.jsp"></jsp:include>
	      
	<!-- Navigation bar -->
	<jsp:include page ="/WEB-INF/views/customer/layout/nav.jsp"></jsp:include>


		<!-- giỏ hàng -->
	<div class="cart-section mt-150 mb-150">
		<div class="container">
			<div class="row">
				<div class="col-lg-8 col-md-12">
					<div class="cart-table-wrap">
						<table class="cart-table">
							<thead class="cart-table-head">
								<tr class="table-head-row">
									<th class="product-remove"></th>
									<th class="product-image">Ảnh Sản Phẩm</th>
									<th class="product-name">Tên Sản Phẩm</th>
									<th class="product-price">Giá</th>
									<th class="product-quantity">Số lượng</th>
									<th class="product-total">Tổng</th>
								</tr>
							</thead>
							<tbody>
								<tr class="table-body-row">
									<td class="product-remove"><a href="#"><i class="far fa-window-close"></i></a></td>
									<td class="product-image"><img src="${env }/customer/assets/Home/images/Hamberger_03.png" width="100%" alt="berger"></td>
									<td class="product-name">berger</td>
									<td class="product-price">25000đ</td>
									<td class="product-quantity"><input type="number" placeholder="0" value="1"></td>
									<td class="product-total">1</td>
								</tr>
							</tbody>
							<tbody>
								<tr class="table-body-row">
									<td class="product-remove"><a href="#"><i class="far fa-window-close"></i></a></td>
									<td class="product-image"><img src="${env }/customer/assets/Home/images/banhmi_03.png" width="100%" alt="Bánh mì xúc xích"></td>
									<td class="product-name">Bánh mì xúc xích</td>
									<td class="product-price">25000đ</td>
									<td class="product-quantity"><input type="number" placeholder="0" value="1"></td>
									<td class="product-total">1</td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>

				<div class="col-lg-4">
					<div class="total-section">
						<table class="total-table">
							<thead class="total-table-head">
								<tr class="table-total-row">
									<th>Tổng Cộng</th>
									<th>Giá</th>
								</tr>
							</thead>
							<tbody>
								<tr class="total-data">
									<td><strong>Tổng tiền sản phẩm </strong></td>
									<td id="tong-gia"></td>
								</tr>
								<tr class="total-data">
									<td><strong>Vận chuyển </strong></td>
									<td>25000đ</td>
								</tr>
								<tr class="total-data">
									<td><strong>Tổng  </strong></td>
									<td id="Tong"></td>
								</tr>
							</tbody>
						</table>
						<div class="cart-buttons">
							<a href="" class="boxed-btn">Làm Mới</a>
							<a href="" class="boxed-btn black">Thanh Toán</a>
						</div>
					</div>

					<div class="coupon-section">
						<h3>Voucher</h3>
						<div class="coupon-form-wrap">
							<form action="">
								<p><input type="text" placeholder="Nhập Voucher"></p>
								<p><input type="submit" value="Xác Nhận"></p>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page ="/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>

	<script>
	function updateCartTotal() {
		const rows = document.querySelectorAll(".table-body-row");
		let total = 0;

		rows.forEach(row => {
		const priceText = row.querySelector(".product-price").innerText;
		const price = parseInt(priceText.replace(/[^\d]/g, '')) || 0;
		const quantity = parseInt(row.querySelector("input[type='number']").value) || 0;
		const rowTotal = price * quantity;

		row.querySelector(".product-total").innerText = rowTotal.toLocaleString() + "đ";
		total += rowTotal;
		});

		document.getElementById("tong-gia").innerText = total.toLocaleString() + "đ";

		const shipping = 25000;
		const finalTotal = total + shipping;
		document.getElementById("Tong").innerText = finalTotal.toLocaleString() + "đ";
	}

	// Gắn sự kiện thay đổi số lượng
	document.addEventListener("DOMContentLoaded", () => {
		updateCartTotal(); // Tính ngay khi tải trang

		const inputs = document.querySelectorAll(".product-quantity input");
		inputs.forEach(input => {
		input.addEventListener("input", updateCartTotal);
		});

		// Làm mới giỏ hàng (reset số lượng về 1)
		const resetBtn = document.querySelector(".cart-buttons a[href='']");
		if (resetBtn) {
		resetBtn.addEventListener("click", (e) => {
			e.preventDefault();
			inputs.forEach(input => input.value = 1);
			updateCartTotal();
		});
		}
	});
	</script>


</body>
</html>