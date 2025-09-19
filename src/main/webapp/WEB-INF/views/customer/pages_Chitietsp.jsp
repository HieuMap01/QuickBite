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

	<!-- chi tiet san pham -->
	<div class="single-product mt-150 mb-150">
		<div class="container">
			<div class="row d-flex align-items-center">
				<!-- Content bên trái -->
				<div class="col-md-7">
					<div class="single-product-content">
						<h3>Hamburger Bò Phô Mai</h3>
						<div class="price-wrapper mb-3">
							<div class="product-price">20.000đ</div>
							<div class="strike-price"><strike>420.000đ</strike></div>
						</div>
						<p>
							Hamburger bò phô mai là sự kết hợp hoàn hảo giữa lớp bánh mì mềm, nhân thịt bò đậm đà và lớp phô mai béo ngậy. Món ăn mang hương vị đặc trưng kiểu Mỹ, rất được yêu thích trong các bữa ăn nhanh hoặc tiệc nhẹ.
							Với phần nhân được nướng chín vàng, hòa quyện cùng sốt mayonnaise và rau tươi, hamburger đem lại cảm giác ngon miệng và tiện lợi.
						</p>
						<div class="single-product-form mb-3">
							<form action="${env}/service">
							  <input type="number" min="1" placeholder="Số lượng"/>
							</form>
							<a href="${env}/cart" class="cart-btn">
							  <i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng
							</a>
							<a href="${env}/wishlist" class="cart-btn" style="margin-left: 8px;">
							  <i class="far fa-heart"></i> Yêu thích
							</a>

						</div>

						<p><strong>Thành Phần:</strong> Bánh mì, thịt bò, phô mai, xà lách, cà chua, dưa leo, sốt đặc biệt</p>
						<h4 class="mt-4">Chia sẻ:</h4>
						<ul class="product-share">
							<li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
							<li><a href="#"><i class="fab fa-twitter"></i></a></li>
							<li><a href="#"><i class="fab fa-google-plus-g"></i></a></li>
							<li><a href="#"><i class="fab fa-linkedin"></i></a></li>
						</ul>
					</div>
				</div>

				<!-- Ảnh bên phải -->
				<div class="col-md-5">
					<div class="single-product-img text-center">
						<img src="${env }/customer/assets/Home/images/Hamberger_03.png" width="100%" alt="Hamburger Bò Phô Mai" class="img-fluid rounded shadow">
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page ="/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>

</body>
</html>

