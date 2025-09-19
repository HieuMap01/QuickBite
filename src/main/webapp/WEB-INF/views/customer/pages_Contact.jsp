<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<!DOCTYPE html>
	<html>
	<head>
	    <meta charset='utf-8'>
	    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
	    <title>Liên hệ</title>
	    <meta name='viewport' content='width=device-width, initial-scale=1'>
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
	    <!-- CSS -->
	    <jsp:include page="/WEB-INF/views/customer/layout/css.jsp"></jsp:include>
	</head>
	<body>
	  <jsp:include page="/WEB-INF/views/customer/layout/header.jsp"></jsp:include>
	  <jsp:include page="/WEB-INF/views/customer/layout/nav.jsp"></jsp:include>

	  <main class="container my-5">
	    <div class="row g-4">
	      <div class="col-lg-6">
	        <h1 class="fw-bold">Liên hệ</h1>
	        <p class="text-muted">Gửi cho chúng tôi câu hỏi, góp ý hoặc yêu cầu hỗ trợ.</p>

	        <!-- Flash message sau redirect (nếu set trong controller) -->
	        <c:if test="${not empty msg}">
	          <div class="alert alert-success">${msg}</div>
	        </c:if>

	        <sf:form id="contactForm"
	                 method="post"
	                 modelAttribute="contact"
	                 action="${pageContext.request.contextPath}/contact/save-sf"
					 enctype="multipart/form-data">>
	          <div class="mb-3">
	            <label class="form-label" for="fullname">Họ và tên</label>
	            <sf:input class="form-control" path="fullname" id="fullname"  required="required" />
	            <sf:errors path="fullname" cssClass="text-danger" />
	          </div>

	          <div class="mb-3">
	            <label class="form-label" for="email">Email</label>
	            <sf:input class="form-control" type="email" path="email" id="email"  required="required" />
	            <sf:errors path="email" cssClass="text-danger" />
	          </div>

	          <div class="mb-3">
	            <label class="form-label" for="phone">Số điện thoại</label>
	            <sf:input class="form-control" type="tel" path="phone" id="phone" pattern="[0-9]{10,11}"  required="required" />
	            <sf:errors path="phone" cssClass="text-danger" />
	          </div>

	          <div class="mb-3">
	            <label class="form-label" for="address">Địa chỉ</label>
	            <sf:input class="form-control" type="text" path="address" id="address"  required="required" />
	            <sf:errors path="address" cssClass="text-danger" />
	          </div>

	          <div class="mb-3">
	            <label class="form-label" for="subject">Chủ đề</label>
	            <sf:input class="form-control" path="subject" id="subject"  required="required" />
	            <sf:errors path="subject" cssClass="text-danger" />
	          </div>

	          <div class="mb-3">
	            <label class="form-label" for="message">Nội dung</label>
	            <sf:textarea class="form-control" path="message" id="message" rows="5"  required="required"></sf:textarea>
	            <sf:errors path="message" cssClass="text-danger" />
	          </div>
			  
			  <div class="mb-3">
			    <label class="form-label" for="contactFile">Tệp đính kèm</label>
			    <!-- name phải trùng với @RequestParam ở controller -->
			    <input class="form-control" type="file" id="contactFile" name="contactFile" accept="image/*,.pdf,.doc,.docx" multiple="multiple"/>
			    <small class="text-muted">Bạn có thể chọn nhiều tệp (≤ 10MB mỗi tệp).</small>
			    <div id="filePreview" class="mt-2 d-flex flex-wrap gap-2"></div>
			  </div>

	          <!-- CSRF (nếu dùng Spring Security) -->
	          <c:if test="${not empty _csrf}">
	            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
	          </c:if>

	          <sf:button class="btn btn-primary" type="submit">
	            <i class="fas fa-paper-plane"></i> Gửi
	          </sf:button>
	        </sf:form>
	      </div>

	      <div class="col-lg-6">
	        <div class="card h-100">
	          <div class="card-body">
	            <h5 class="card-title">Thông tin</h5>
	            <p class="mb-1"><i class="fas fa-map-marker-alt me-2"></i>Hà Nội, Việt Nam</p>
	            <p class="mb-1"><i class="fas fa-phone me-2"></i>0123 456 789</p>
	            <p class="mb-3"><i class="fas fa-envelope me-2"></i>support@example.com</p>
	            <div class="ratio ratio-16x9">
	              <iframe src="https://www.google.com/maps?q=Hanoi&output=embed"
	                      loading="lazy" style="border:0;" allowfullscreen></iframe>
	            </div>
	          </div>
	        </div>
	      </div>
	    </div>
	  </main>

	  <jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>
	  <!-- JS -->
	  <jsp:include page="/WEB-INF/views/customer/layout/js.jsp"></jsp:include>
	</body>
	</html>
