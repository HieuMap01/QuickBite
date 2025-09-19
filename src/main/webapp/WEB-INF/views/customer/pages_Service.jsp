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
	<link rel='stylesheet' type='text/css' media='screen' href='${env }/customer/css/bootstrap.min.css'>
	<link rel='stylesheet' type='text/css' media='screen' href='${env }/customer/css/style.css'>
	<link rel='stylesheet' type='text/css' media='screen' href='${env }/customer/css/style_service.css'>

</head>
<body>
	<jsp:include page="/WEB-INF/views/customer/layout/header.jsp"/>
	<jsp:include page="/WEB-INF/views/customer/layout/nav.jsp"/>
	
	<div class="container mt-150 mb-150">
		<div class="row">
			<!-- Menu bên trái -->
			<div class="col-md-3">
				<div class="filter-menu">
					<h4 class="filter-title">Danh Mục</h4>
					<ul class="filter-list">
						<li class="active" data-filter="*">Tất Cả</li>
						<li data-filter=".food">Đồ Ăn</li>
						<li data-filter=".drinking">Đồ Uống</li>
						<li data-filter=".desert">Tráng Miệng</li>
					</ul>
				</div>
			</div>

		<!-- Sản phẩm bên phải -->
		<div class="col-md-9">
			<div class="row product-lists">
				<div class="col-lg-4 col-md-6 text-center food">
					<div class="single-product-item">
						<div class="product-image">
							<a href="${env}/product"><img src="${env }/customer/assets/Home/images/Hamberger_03.png" width="100%" alt=""></a>
						</div>
						<h3>Berger</h3>
						<div class="product-price" style="font-size: 20px;">20.000đ <strike>420.000đ</strike></div>
							<p>Còn lại: 20</p>
							<button class="cart-btn"><i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 text-center food">
					<div class="single-product-item">
						<div class="product-image">
							<a href="${env}/product"><img src="${env }/customer/assets/Home/images/Hamberger_03.png" width="100%" alt=""></a>
						</div>
						<h3>Berger</h3>
						<div class="product-price" style="font-size: 20px;">20.000đ <strike>420.000đ</strike></div>
						<p>Còn lại: 20</p>
						<button class="cart-btn"><i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 text-center food">
					<div class="single-product-item">
						<div class="product-image">
							<a href="${env}/product"><img src="${env }/customer/assets/Home/images/Hamberger_03.png" width="100%" alt=""></a>
						</div>
						<h3>Berger</h3>
						<div class="product-price" style="font-size: 20px;">20.000đ <strike>420.000đ</strike></div>
						<p>Còn lại: 20</p>
						<button class="cart-btn"><i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 text-center food">
					<div class="single-product-item">
						<div class="product-image">
							<a href="${env}/product"><img src="${env }/customer/assets/Home/images/Hamberger_03.png" width="100%" alt=""></a>
						</div>
						<h3>Berger</h3>
						<div class="product-price" style="font-size: 20px;">20.000đ <strike>420.000đ</strike></div>
						<p>Còn lại: 20</p>
						<button class="cart-btn"><i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 text-center food">
					<div class="single-product-item">
						<div class="product-image">
							<a href="${env}/product"><img src="${env }/customer/assets/Home/images/Hamberger_03.png" width="100%" alt=""></a>
						</div>
						<h3>Berger</h3>
						<div class="product-price" style="font-size: 20px;">20.000đ <strike>420.000đ</strike></div>
						<p>Còn lại: 20</p>
						<button class="cart-btn"><i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 text-center food">
					<div class="single-product-item">
						<div class="product-image">
							<a href="${env}/product"><img src="${env }/customer/assets/Home/images/Hamberger_03.png" width="100%" alt=""></a>
						</div>
						<h3>Berger</h3>
						<div class="product-price" style="font-size: 20px;">20.000đ <strike>420.000đ</strike></div>
						<p>Còn lại: 20</p>
						<button class="cart-btn"><i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 text-center food">
					<div class="single-product-item">
						<div class="product-image">
							<a href="${env}/product"><img src="${env }/customer/assets/Home/images/Hamberger_03.png" width="100%" alt=""></a>
						</div>
						<h3>Berger</h3>
						<div class="product-price" style="font-size: 20px;">20.000đ <strike>420.000đ</strike></div>
						<p>Còn lại: 20</p>
						<button class="cart-btn"><i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 text-center drinking">
					<div class="single-product-item">
						<div class="product-image">
							<a href="#"><img src="${env }/customer/assets/Home/images/Hamberger_03.png" width="100%" alt=""></a>
						</div>
						<h3>coca</h3>
						<div class="product-price" style="font-size: 20px;">20.000đ <strike>420.000đ</strike></div>
						<p>Còn lại: 20</p>
						<button class="cart-btn"><i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
					</div>
				</div>
				<div class="col-lg-4 col-md-6 text-center desert">
					<div class="single-product-item">
						<div class="product-image">
							<a href="#"><img src="${env }/customer/assets/Home/images/Hamberger_03.png" width="100%" alt=""></a>
						</div>
						<h3>Bánh ngọt</h3>
						<div class="product-price" style="font-size: 20px;">20.000đ <strike>420.000đ</strike></div>
						<p>Còn lại: 20</p>
						<button class="cart-btn"><i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>


	<jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"/>


	<script>
		document.addEventListener("DOMContentLoaded", function () {
			const filterButtons = document.querySelectorAll(".filter-list li");
			const products = document.querySelectorAll(".product-lists > div");

			filterButtons.forEach(button => {
			button.addEventListener("click", function () {
				// Bỏ active ở tất cả
				filterButtons.forEach(btn => btn.classList.remove("active"));
				this.classList.add("active");

				const filterValue = this.getAttribute("data-filter");

				products.forEach(product => {
				if (filterValue === "*" || product.classList.contains(filterValue.slice(1))) {
					product.style.display = "block";
				} else {
					product.style.display = "none";
				}
				});
			});
			});
		});
	</script>


</body>
</html>
