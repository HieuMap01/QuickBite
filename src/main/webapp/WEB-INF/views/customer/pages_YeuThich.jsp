<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Yêu thích</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
	<link rel='stylesheet' type='text/css' media='screen' href='${env }/customer/css/bootstrap.min.css'>
	<link rel='stylesheet' type='text/css' media='screen' href='${env }/customer/css/style.css'>
</head>
<body>
	<jsp:include page="/WEB-INF/views/customer/layout/header.jsp"/>
	<jsp:include page="/WEB-INF/views/customer/layout/nav.jsp"/>

	<main class="container my-5">
		<div class="d-flex justify-content-between align-items-center mb-3">
		<h1 class="fw-bold mb-0"><i class="far fa-heart me-2"></i>Danh sách Yêu thích</h1>
		<a href="${env }/customer/index.html" class="btn btn-outline-secondary"><i class="fas fa-arrow-left"></i> Tiếp tục xem món</a>
		</div>
		<div id="fav-list" class="favorite-list"></div>
	</main>


	<jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"/>
	
<script src="${env }/customer/js/app.js"></script>
</body>
</html>