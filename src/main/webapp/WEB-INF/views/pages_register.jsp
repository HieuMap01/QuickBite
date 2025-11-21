<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/variables.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset='utf-8'>
	<meta http-equiv='X-UA-Compatible' content='IE=edge'>
	<title>Đăng ký</title>
	<meta name='viewport' content='width=device-width, initial-scale=1'>
	
	<link rel='stylesheet' type='text/css' media='screen' href="${env }/customer/css/auth.css" />
</head>
<body>
	<div class="auth-page">
		<div class="auth-container">
			<h1>Create Your Account</h1>
			<p class="subtitle">Join us and enjoy the best food experience!</p>
			
			<form action="${pageContext.request.contextPath}/register" method="POST">

			  <input type="text" name="username" placeholder="Username" required />
			  <input type="text" name="name" placeholder="Full Name" />
			  <input type="email" name="email" placeholder="Email Address" required />
			  <input type="tel" name="mobile" placeholder="Phone Number" />
			  <input type="text" name="address" placeholder="Address" required />
			  <input type="password" name="password" placeholder="Password" required />
			  <input type="password" name="confirmPassword" placeholder="Confirm Password" required />

			  <button type="submit" class="auth-btn">Sign Up</button>
			</form>

			<c:if test="${not empty error}">
			  <div class="alert alert-danger">${error}</div>
			</c:if>
			<c:if test="${not empty success}">
			  <div class="alert alert-success">${success}</div>
			</c:if>

			<script>
			  // kiểm tra khớp mật khẩu trước khi submit
			  document.querySelector('form').addEventListener('submit', function(e){
			    const pw = this.password.value.trim();
			    const cpw = this.confirmPassword.value.trim();
			    if (pw !== cpw) { e.preventDefault(); alert('Password và Confirm password không khớp!'); }
			  });
			</script>


			<p class="auth-link">Already have an account? <a href="${env }/login">Log In</a></p>


		</div>
	</div>

</body>
</html>
