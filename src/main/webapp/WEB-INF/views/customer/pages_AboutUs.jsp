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

		<!-- About Us Section -->
		<section class="py-5 bg-light">
		<div class="container">
			<h2 class="text-center mb-4">VỀ CHÚNG TÔI</h2>
			<div class="row align-items-center">
			<div class="col-md-6 mb-4 mb-md-0">
				<img src="${env }/customer/assets/Home/images/Hamberger_03.png" alt="About Us" class="img-fluid rounded shadow">
			</div>
			<div class="col-md-6">
				<h3>FastTaste – Nhanh, Ngon, Nóng hổi</h3>
				<p>Chúng tôi bắt đầu từ một cửa hàng nhỏ với khát vọng mang đến những bữa ăn nhanh không chỉ tiện lợi mà còn chất lượng. Từ chiếc hamburger đầu tiên đến hàng ngàn đơn hàng mỗi tháng, FastTaste luôn giữ vững cam kết: phục vụ đồ ăn nhanh, sạch, nóng và ngon.</p>
				<p>Nguyên liệu được lựa chọn kỹ càng, chế biến trong ngày và phục vụ ngay sau khi hoàn tất. Chúng tôi tin rằng bạn xứng đáng được thưởng thức bữa ăn nhanh nhưng vẫn đầy đủ hương vị và dinh dưỡng.</p>
				<ul>
				<li>✅ 100% nguyên liệu tươi mỗi ngày</li>
				<li>✅ Phục vụ chưa đến 10 phút</li>
				<li>✅ Menu đa dạng từ burger, pizza, snack đến đồ uống</li>
				</ul>
			</div>
			</div>
		</div>
		</section>

		<!-- Vision & Mission -->
		<section class="py-5">
		<div class="container">
			<div class="row text-center">
			<div class="col-md-6">
				<h4>Tầm Nhìn</h4>
				<p>Trở thành chuỗi cửa hàng đồ ăn nhanh được yêu thích nhất Việt Nam.</p>
			</div>
			<div class="col-md-6">
				<h4>Sứ Mệnh</h4>
				<p>Cung cấp đồ ăn nhanh tiện lợi, chất lượng cao với giá cả hợp lý cho mọi người.</p>
			</div>
			</div>
		</div>
		</section>

		<jsp:include page = "/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>

		<%-- JS --%>
		 <jsp:include page ="/WEB-INF/views/customer/layout/js.jsp"></jsp:include>

</body>
</html>