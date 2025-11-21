<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>my orders</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
	<link rel='stylesheet' type='text/css' media='screen' href='${env }/customer/css/bootstrap.min.css'>
	<link rel='stylesheet' type='text/css' media='screen' href='${env }/customer/css/style.css'>
</head>
<body>
	<jsp:include page="/WEB-INF/views/customer/layout/header.jsp"/>
	<jsp:include page="/WEB-INF/views/customer/layout/nav.jsp"/>

	<main class="container" style="max-width:900px;margin:40px auto;">
	  <h2 class="mb-4 text-center">Đơn hàng của tôi</h2>

	  <c:choose>
	    <c:when test="${empty orders}">
	      <div class="alert alert-info text-center">
	        Bạn chưa có đơn hàng nào.
	      </div>
	    </c:when>

	    <c:otherwise>
	      <table class="table table-bordered table-hover align-middle">
	        <thead class="thead-light">
	          <tr class="text-center">
	            <th>#</th>
	            <th>Mã đơn</th>
	            <th>Ngày đặt</th>
	            <th>Tổng tiền</th>
	            <th>Trạng thái</th>
	            <th>Thao tác</th>
	          </tr>
	        </thead>

	        <tbody>
	          <c:forEach var="o" items="${orders}" varStatus="st">
	            <tr>
	              <td class="text-center">${st.index + 1}</td>
	              <td class="text-center">${o.code}</td>
	              <td class="text-center">
	                <fmt:formatDate value="${o.createDate}" pattern="dd/MM/yyyy HH:mm" />
	              </td>
	              <td class="text-right">
	                <fmt:formatNumber value="${o.total}" type="currency" />
	              </td>
	              <td class="text-center">
	                <c:choose>
	                  <c:when test="${o.orderStatus == 0}">Chờ xác nhận</c:when>
	                  <c:when test="${o.orderStatus == 1}">Đang xử lý</c:when>
	                  <c:when test="${o.orderStatus == 2}">Hoàn tất</c:when>
	                  <c:otherwise>Hủy</c:otherwise>
	                </c:choose>
	              </td>
	              <td class="text-center">
	                <a class="btn btn-sm btn-outline-primary"
	                   href="${env}/account/orders/${o.id}">
	                  <i class="fas fa-eye"></i> Xem
	                </a>
	              </td>
	            </tr>
	          </c:forEach>
	        </tbody>
	      </table>
	    </c:otherwise>
	  </c:choose>
	</main>



	<jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"/>
	
<script src="${env }/customer/js/app.js"></script>
</body>
</html>