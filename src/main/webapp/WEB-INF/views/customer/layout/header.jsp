
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>



<!--
<%-- Nếu chưa có biến env (trường hợp trang cha quên include), tự tạo --%>
<c:if test="${empty env}">
  <c:set var="env" value="${pageContext.request.contextPath}" scope="request" />
</c:if>

<%-- ===== Fallback tính số lượng giỏ hàng từ session nếu model không có ===== --%>
<c:set var="cart" value="${empty cart ? sessionScope.cart : cart}" />
<c:set var="sumQty" value="0" />
<c:if test="${not empty cart and not empty cart.cartProducts}">
  <c:forEach var="p" items="${cart.cartProducts}">
    <c:set var="sumQty" value="${sumQty + p.quantity}" />
  </c:forEach>
</c:if>
-->


<header class="bg-custom text-white py-1">
  <div class="container">
    <div class="row align-items-center">

      <!-- ========== Cột 1: Search ========== -->
      <div class="col-md-4 search-container bg-custom p-2">
        <div class="input-group">
          <input type="text" id="searchInput" class="form-control search-input text-white" placeholder="Search here">
          <div class="input-group-append">
            <button class="btn search-btn" id="searchBtn">
              <i class="fas fa-search"></i>
            </button>
          </div>
        </div>
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
        <a href="${env}/auth/register" class="text-white mr-1">Register</a>
        <span class="text-white">/</span>
        <a href="${env}/auth/login" class="text-white ml-1">Login</a>

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
