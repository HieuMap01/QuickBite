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
	<jsp:include page = "/WEB-INF/views/customer/layout/header.jsp"></jsp:include>
			
	<jsp:include page = "/WEB-INF/views/customer/layout/nav.jsp"></jsp:include>

	<main class="container my-5">
		<div class="row">
		<div class="col-lg-8">
			<h1 class="fw-bold mb-4">Blog</h1>
			<article class="card mb-4" data-item-id="blog-1" data-item-name="Món mới theo mùa">
			<img src="${env }/customer/assets/Home/images/seasonal.jpg" class="card-img-top" alt="Món mới theo mùa">
			<div class="card-body">
				<h3 class="card-title">Món mới theo mùa</h3>
				<p class="card-text">Khám phá các món ăn theo mùa với nguyên liệu tươi mới, đem lại trải nghiệm vị giác tuyệt vời.</p>
				<button class="btn btn-outline-primary btn-fav"><i class="far fa-heart"></i> Yêu thích</button>
			</div>
			</article>
			<article class="card mb-4" data-item-id="blog-2" data-item-name="Bí quyết đặt món nhanh">
			<img src="${env }/customer/assets/Home/images/tips.jpg" class="card-img-top" alt="Tips">
			<div class="card-body">
				<h3 class="card-title">Bí quyết đặt món nhanh</h3>
				<p class="card-text">Một vài mẹo nhỏ giúp bạn đặt món nhanh hơn, tiết kiệm thời gian vào giờ cao điểm.</p>
				<button class="btn btn-outline-primary btn-fav"><i class="far fa-heart"></i> Yêu thích</button>
			</div>
			</article>
		</div>
		<aside class="col-lg-4">
			<div class="card mb-4">
			<div class="card-body">
				<h5 class="card-title">Tìm kiếm</h5>
				<input id="search" class="form-control" type="search" placeholder="Tìm bài viết...">
			</div>
			</div>
			<div class="card">
			<div class="card-body">
				<h5 class="card-title">Chủ đề</h5>
				<ul class="list-unstyled mb-0">
				<li><a href="#">Ưu đãi</a></li>
				<li><a href="#">Món mới</a></li>
				<li><a href="#">Kinh nghiệm</a></li>
				</ul>
			</div>
			</div>
		</aside>
		</div>
	</main>

	<jsp:include page = "/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>

	<%-- JS --%>
	 <jsp:include page ="/WEB-INF/views/customer/layout/js.jsp"></jsp:include>
	</body>
</html>