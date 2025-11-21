<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%> <%-- BẮT BUỘC vì dùng c:out --%>

<!DOCTYPE html>
<html lang="vi">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Hồ sơ cá nhân</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
	<link rel="stylesheet" href="${env}/customer/css/bootstrap.min.css">
	<link rel="stylesheet" href="${env}/customer/css/style.css">
</head>
<body>
	<jsp:include page="/WEB-INF/views/customer/layout/header.jsp"/>
	<jsp:include page="/WEB-INF/views/customer/layout/nav.jsp"/>

	<main class="container">
	  <div class="profile-card" style="max-width:900px;margin:40px auto;background:#fff;border-radius:16px;box-shadow:0 6px 20px rgba(0,0,0,.06);">
	    
	    <!-- Header -->
	    <div style="display:flex;align-items:center;gap:24px;padding:24px;border-bottom:1px solid #eee;">
			<img 
			  src="<c:out value='${user.avatar != null && user.avatar ne "" ? user.avatar : "/customer/assets/Home/images/avatar-default.png"}'/>"
			  alt="Avatar"
			  style="width:110px;height:110px;border-radius:50%;object-fit:cover;border:3px solid #f3f4f6;">
			<div>

	        <h2 style="margin:0;font-size:24px;color:#111;">
	          <c:out value="${user.name != null && user.name ne '' ? user.name : user.username}"/>
	        </h2>
	        <p style="color:#6b7280;margin-top:4px;">Thông tin tài khoản</p>
	      </div>
	    </div>

	    <!-- Body -->
	    <div style="padding:24px;">
	      <div style="display:grid;grid-template-columns:180px 1fr;gap:16px;padding:8px 0;border-bottom:1px dashed #eee;">
	        <div style="font-weight:600;">Username</div>
	        <div><c:out value="${user.username}"/></div>
	      </div>

	      <div style="display:grid;grid-template-columns:180px 1fr;gap:16px;padding:8px 0;border-bottom:1px dashed #eee;">
	        <div style="font-weight:600;">Họ & Tên</div>
	        <div><c:out value="${user.name}"/></div>
	      </div>

	      <div style="display:grid;grid-template-columns:180px 1fr;gap:16px;padding:8px 0;border-bottom:1px dashed #eee;">
	        <div style="font-weight:600;">Số điện thoại</div>
	        <div><c:out value="${user.mobile}"/></div>
	      </div>

	      <div style="display:grid;grid-template-columns:180px 1fr;gap:16px;padding:8px 0;border-bottom:1px dashed #eee;">
	        <div style="font-weight:600;">Email</div>
	        <div><c:out value="${user.email}"/></div>
	      </div>

	      <div style="display:grid;grid-template-columns:180px 1fr;gap:16px;padding:8px 0;">
	        <div style="font-weight:600;">Địa chỉ</div>
	        <div><c:out value="${user.address}"/></div>
	      </div>
	    </div>

	    <div style="padding:20px 24px;border-top:1px solid #eee;display:flex;justify-content:flex-end;">
	      <a href="${env}/account/profile/edit" <%-- SỬA LẠI ĐÚNG PREFIX /account --%>
	         style="background:#226b1f;color:#fff;padding:10px 18px;border-radius:10px;text-decoration:none;">
	         Edit
	      </a>
	    </div>
	  </div>
	</main>

	<script src="${env}/customer/js/app.js"></script>
</body>
</html>
