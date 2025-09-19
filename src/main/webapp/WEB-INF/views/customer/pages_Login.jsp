<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
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

			<form action="#" method="POST">
			<input type="email" name="email" placeholder="Email Address" required />
			<input type="password" name="password" placeholder="Password" required />
			
			<button type="submit" class="auth-btn">Log In</button>
			</form>

			<p class="auth-link">Don't have an account? <a href="${env }/customer/register.html">Sign Up</a></p>
		</div>
	</div>

</body>
</html>