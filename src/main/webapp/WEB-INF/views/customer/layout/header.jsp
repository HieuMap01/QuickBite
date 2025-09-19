<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="/WEB-INF/views/common/variables.jsp" %>

<header class="bg-custom text-white py-2">
  <div class="container">
    <div class="row align-items-center">

      <!-- Cột 1: Search -->
      <div class="col-md-4 search-container bg-custom p-2">
        <div class="input-group">
          <input type="text" id="searchInput" class="form-control search-input text-white" placeholder="Search here">
          <div class="input-group-append">
            <button class="btn search-btn" id="searchBtn"><i class="fas fa-search"></i></button>
          </div>
        </div>
      </div>

      <!-- Cột 2: Logo (giữa) -->
      <div class="col-md-4 text-center">
        <a href="${env}/home">
          <img src="${env}/customer/assets/Home/images/Logo.png" alt="Company Logo" height="40">
        </a>
      </div>

      <!-- Cột 3: Register / Login + Tim + Giỏ -->
      <div class="col-md-4 text-right d-flex justify-content-end align-items-center">
        <a href="${env}/auth/register" class="text-white mr-1">Register</a>
        <span class="text-white">/</span>
        <a href="${env}/auth/login" class="text-white ml-1">Login</a>

        <a href="${env}/wishlist" class="text-white position-relative mx-3">
          <img src="${env}/customer/assets/Home/images/icon_tim.png" alt="Wishlist">
          <span class="badge position-absolute rounded-circle" style="top:-10px; right:-10px; background-color:#608b14">
            <c:out value="${wishlistCount}" default="0"/>
          </span>
        </a>

        <a href="${env}/cart" class="text-white position-relative">
          <img src="${env}/customer/assets/Home/images/icon_giohang.png" alt="Cart">
          <span class="badge position-absolute rounded-circle" style="top:-10px; right:-10px; background-color:#608b14">
            <c:out value="${cartCount}" default="0"/>
          </span>
        </a>
      </div>

    </div>
  </div>
</header>
