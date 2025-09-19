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

</head>
<body>
	<jsp:include page="/WEB-INF/views/customer/layout/header.jsp"/>
	<jsp:include page="/WEB-INF/views/customer/layout/nav.jsp"/>

	<main class="container my-5">
		<div class="text-center mb-5">
		<h1 class="fw-bold">Pricing</h1>
		<p class="text-muted">Chọn gói phù hợp cho việc đặt đồ ăn, giao nhanh và ưu đãi thành viên.</p>
		</div>
		<div class="row g-4">
		<div class="col-md-4">
			<div class="card h-100 shadow-sm">
			<div class="card-body d-flex flex-column">
				<h5 class="card-title">Free</h5>
				<p class="card-text text-muted">Phù hợp dùng thử</p>
				<h2 class="my-3">0đ <small class="text-muted fs-6">/tháng</small></h2>
				<ul class="list-unstyled mb-4">
				<li><i class="fas fa-check me-2"></i>Đặt món cơ bản</li>
				<li><i class="fas fa-check me-2"></i>Theo dõi đơn hàng</li>
				<li><i class="fas fa-times me-2 text-muted"></i>Không có ưu đãi</li>
				</ul>
				<a href="${env }/customer/register.html" class="btn btn-outline-primary mt-auto">Bắt đầu</a>
			</div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="card h-100 border-primary shadow">
			<div class="card-header bg-primary text-white text-center">Phổ biến</div>
			<div class="card-body d-flex flex-column">
				<h5 class="card-title">Pro</h5>
				<p class="card-text text-muted">Ưu đãi và giao nhanh</p>
				<h2 class="my-3">49.000đ <small class="text-muted fs-6">/tháng</small></h2>
				<ul class="list-unstyled mb-4">
				<li><i class="fas fa-check me-2"></i>Ưu đãi giảm giá</li>
				<li><i class="fas fa-check me-2"></i>Giao nhanh ưu tiên</li>
				<li><i class="fas fa-check me-2"></i>Hỗ trợ 24/7</li>
				</ul>
				<a href="${env }/customer/register.html" class="btn btn-primary mt-auto">Đăng ký Pro</a>
			</div>
			</div>
		</div>
		<div class="col-md-4">
			<div class="card h-100 shadow-sm">
			<div class="card-body d-flex flex-column">
				<h5 class="card-title">Business</h5>
				<p class="card-text text-muted">Dành cho nhóm/đội</p>
				<h2 class="my-3">199.000đ <small class="text-muted fs-6">/tháng</small></h2>
				<ul class="list-unstyled mb-4">
				<li><i class="fas fa-check me-2"></i>Hoá đơn gộp & chia</li>
				<li><i class="fas fa-check me-2"></i>Quản lý đơn theo nhóm</li>
				<li><i class="fas fa-check me-2"></i>CSKH ưu tiên</li>
				</ul>
				<a href="${env }/customer/pages_CONTACT.html" class="btn btn-outline-primary mt-auto">Liên hệ tư vấn</a>
			</div>
			</div>
		</div>
		</div>
	</main>

	<jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"/>
<script src="${env }/customer/js/app.js"></script>
</body>
</html>