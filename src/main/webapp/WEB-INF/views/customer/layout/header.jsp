
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>




<header class="bg-custom text-white py-1">
  <div class="container">
    <div class="row align-items-center">

		<!-- ========== Cột 1: Search ========== -->
		<div class="col-md-4 search-container bg-custom p-2">
			<form action="${env}/service/search" method="get" class="w-100">
			  <div class="input-group">
			    <input type="text" name="q" class="form-control" placeholder="Search here" required />
			    <div class="input-group-append">
			      <button type="submit" class="btn search-btn"><i class="fas fa-search"></i></button>
			    </div>
			  </div>
			</form>

		</div>

      <!-- ========== Cột 2: Logo (giữa) ========== -->
      <div class="col-md-4 text-center">
        <a href="${env}/index">
          <img src="${env}/customer/assets/Home/images/Logo_demo.png"
               alt="Company Logo"
               class="logo">
        </a>
      </div>

      <!-- ========== Cột 3: Register / Login / Wishlist / Cart ========== -->
      <div class="col-md-4 text-right d-flex justify-content-end align-items-center">
		<!-- Anonymous: hiện Register / Login -->
		<sec:authorize access="isAnonymous()">
		  <a href="${env}/register" class="text-white mr-1">Register</a>
		  <span class="text-white">/</span>
		  <a href="${env}/login" class="text-white ml-1">Login</a>
		</sec:authorize>

		<!-- Authenticated: hiện avatar + dropdown -->
		<%--<sec:authorize access="isAuthenticated()">
		  <c:set var="avatarUrl" value="${empty currentUser || empty currentUser.avatar ? 
		    env.concat('/customer/assets/Home/images/avatar-default.png') 
		    : currentUser.avatar }" />--%>
		<sec:authorize access="isAuthenticated()">
			    <c:set var="avatarUrl" value="/customer/assets/Home/images/avatar-default.png" />
		

		  
		  <div class="dropdown mx-3">
		    <a class="d-flex align-items-center text-white dropdown-toggle" href="#" id="userMenu" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="text-decoration:none;">
		      <img src="${avatarUrl}" alt="Avatar" class="qb-avatar mr-2">
		      <span class="d-none d-sm-inline">
		        <sec:authentication property="principal.username"/>
		      </span>
		    </a>
			<div class="dropdown-menu dropdown-menu-right" aria-labelledby="userMenu">

			  <a class="dropdown-item nav-link" href="${env}/account/profile">Thông tin cá nhân</a>
			  <a class="dropdown-item nav-link" href="${env}/account/orders">Đơn hàng của tôi</a>

			  <div class="dropdown-divider"></div>

			  <form action="${env}/logout" method="post" class="m-0">
			    <button type="submit" class="dropdown-item nav-link text-danger">Đăng xuất</button>
			  </form>

			</div>

		  </div>
		</sec:authorize>

        <!-- ===== Wishlist ===== -->
        <a href="${env}/wishlist" class="text-white position-relative mx-3">
          <img src="${env}/customer/assets/Home/images/icon_tim.png" alt="Wishlist">
          <span class="badge position-absolute rounded-circle"
                style="top:-10px; right:-10px; background-color:#608b14">
            <c:out value="${wishlistCount}" default="0"/>
          </span>
        </a>

        <!-- ===== Cart ===== -->
        <a href="${env}/cart" class="text-white position-relative">
          <img src="${env}/customer/assets/Home/images/icon_giohang.png" alt="Cart">
          <span class="badge position-absolute rounded-circle"
                style="top:-10px; right:-10px; background-color:#608b14"
                id="totalCartProducts">
				${totalCartProducts }
            <!--<c:choose>
              <c:when test="${not empty totalCartProducts}">
                ${totalCartProducts}
              </c:when>
              <c:otherwise>
                ${sumQty}
              </c:otherwise>
            </c:choose>-->
          </span>
        </a>
      </div>

    </div>
  </div>
</header>
