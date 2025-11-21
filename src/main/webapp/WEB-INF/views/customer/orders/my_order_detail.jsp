<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>my order detail</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
	<link rel='stylesheet' type='text/css' media='screen' href='${env }/customer/css/bootstrap.min.css'>
	<link rel='stylesheet' type='text/css' media='screen' href='${env }/customer/css/style.css'>
</head>
<body>
	<jsp:include page="/WEB-INF/views/customer/layout/header.jsp"/>
	<jsp:include page="/WEB-INF/views/customer/layout/nav.jsp"/>


	<main class="container" style="max-width:900px;margin:24px auto;">
	  <h4>Đơn hàng #${order.id} - Mã: ${order.code}</h4>
	  <p>
	    Ngày: <fmt:formatDate value="${order.createDate}" pattern="dd/MM/yyyy HH:mm"/>
	    <br/>Khách: ${order.customerName} | ${order.customerMobile}
	    <br/>Địa chỉ: ${order.customerAddress}
	  </p>

	  <table class="table table-striped">
	    <thead>
	      <tr>
	        <th>Sản phẩm</th>
	        <th class="text-right">Đơn giá</th>
	        <th class="text-center">SL</th>
	        <th class="text-right">Thành tiền</th>
	      </tr>
	    </thead>
	    <tbody>
	      <c:set var="sum" value="0"/>
	      <c:forEach var="it" items="${order.items}">
	        <tr>
	          <td>${it.product.name}</td>
	          <td class="text-right"><fmt:formatNumber value="${it.price}" type="currency"/></td>
	          <td class="text-center">${it.quantity}</td>
	          <td class="text-right">
	            <fmt:formatNumber value="${it.price * it.quantity}" type="currency"/>
	          </td>
	        </tr>
	        <c:set var="sum" value="${sum + (it.price * it.quantity)}"/>
	      </c:forEach>
	    </tbody>
	    <tfoot>
	      <tr>
	        <th colspan="3" class="text-right">Tổng tạm tính</th>
	        <th class="text-right"><fmt:formatNumber value="${sum}" type="currency"/></th>
	      </tr>
	      <tr>
	        <th colspan="3" class="text-right">Tổng đơn (DB)</th>
	        <th class="text-right"><fmt:formatNumber value="${order.total}" type="currency"/></th>
	      </tr>
	    </tfoot>
	  </table>

	  <a class="btn btn-secondary" href="${env}/account/orders">← Quay lại</a>
	</main>


	<jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"/>
	
<script src="${env }/customer/js/app.js"></script>
</body>
</html>