<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/variables.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset='utf-8'>
	<meta http-equiv='X-UA-Compatible' content='IE=edge'>
	<title>Đăng Nhập</title>
	<meta name='viewport' content='width=device-width, initial-scale=1'>
	<link rel='stylesheet' type='text/css' media='screen' href='${env }/customer/css/auth.css'>
	<script src='main.js'></script>
</head>
<body>
	<div class="auth-page">
		<div class="auth-container">
			<h1>Welcome Back</h1>
			<p class="subtitle">Log in to your account</p>			
			<form action="${env}/login_processing_url" method="POST">
			  <!-- Username hoặc Email -->
			  <div class="form-outline mb-4">
			    <label class="form-label" for="username"></label>
			    <input type="text" id="username" name="username" class="form-control" placeholder="Username" required />
			  </div>

			  <!-- Password -->
			  <div class="form-outline mb-4">
			    <label class="form-label" for="password"></label>
			    <input type="password" id="password" name="password" class="form-control" placeholder="Password" required />
			  </div>

			  <button type="submit" class="auth-btn">Login</button>
			</form>

			<p class="auth-link">Don't have an account? <a href="${env}/register">Sign Up</a></p>

		</div>
	</div>

</body>
</html>