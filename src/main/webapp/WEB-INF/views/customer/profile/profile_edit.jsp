<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%> <%-- BẮT BUỘC vì dùng c:out --%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>Hồ sơ cá nhân</title> <%-- Sửa tiêu đề --%>
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
	<link rel="stylesheet" href="${env}/customer/css/bootstrap.min.css">
	<link rel="stylesheet" href="${env}/customer/css/style.css">
</head>
<body> <%-- CHỈ MỘT <body> --%>
	<jsp:include page="/WEB-INF/views/customer/layout/header.jsp"/>
	<jsp:include page="/WEB-INF/views/customer/layout/nav.jsp"/>

  <main class="container" style="max-width:700px;margin:40px auto;">
    <h2 class="mb-4 text-center">Chỉnh sửa hồ sơ</h2>
    <form action="${env}/account/profile/edit-save" method="post" modelAttribute="user">
		<input type="hidden" name="id" value="${user.id}"/>
      <div class="form-group mb-3">
        <label>Họ và Tên</label>
        <input type="text" name="name" value="${user.name}" class="form-control" required>
      </div>

      <div class="form-group mb-3">
        <label>Số điện thoại</label>
        <input type="text" name="mobile" value="${user.mobile}" class="form-control">
      </div>

      <div class="form-group mb-3">
        <label>Email</label>
        <input type="email" name="email" value="${user.email}" class="form-control">
      </div>

      <div class="form-group mb-3">
        <label>Địa chỉ</label>
        <input type="text" name="address" value="${user.address}" class="form-control">
      </div>

      <%-- Nếu bạn muốn cho phép đổi avatar, thêm dòng này:
      <div class="form-group mb-3">
        <label>Ảnh đại diện</label>
        <input type="file" name="avatar" class="form-control-file">
      </div>
      --%>

      <div class="text-end">
        <a href="${env}/account/profile" class="btn btn-secondary">Hủy</a>
        <button type="submit" class="btn btn-success">Lưu thay đổi</button>
      </div>
    </form>
  </main>

  <script src="${env}/customer/js/app.js"></script>
</body>
</html>
