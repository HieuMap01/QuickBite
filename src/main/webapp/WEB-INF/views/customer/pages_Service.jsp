<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<fmt:setLocale value="vi_VN" />

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Danh sách sản phẩm</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="stylesheet" href="${env}/customer/css/bootstrap.min.css">
    <link rel="stylesheet" href="${env}/customer/css/style.css">
    <link rel="stylesheet" href="${env}/customer/css/style_service.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css">

    <style>
        .single-product-item {
            border: 1px solid #eee;
            border-radius: 12px;
            padding: 14px;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            background: #fff;
            margin-bottom: 20px;
        }
        .single-product-item .product-image img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 10px;
        }
        .product-price {
            font-weight: 600;
            color: #222;
        }
        .cart-btn {
            background: #222;
            color: #fff;
            border: none;
            padding: 10px 12px;
            border-radius: 10px;
            cursor: pointer;
        }
        .cart-btn:hover {
            opacity: 0.9;
        }
        .filter-menu .filter-list li {
            cursor: pointer;
            padding: 6px 10px;
            border-radius: 8px;
        }
        .filter-menu .filter-list li.active {
            background: #608b14;
            color: #fff;
        }
    </style>
</head>

<body>
    <jsp:include page="/WEB-INF/views/customer/layout/header.jsp"/>
    <jsp:include page="/WEB-INF/views/customer/layout/nav.jsp"/>

    <div class="container mt-150 mb-150">
        <div class="row">
            <!-- Filter bên trái -->
            <div class="col-md-3">
                <div class="filter-menu">
                    <h4 class="filter-title">Danh Mục</h4>
                    <ul class="filter-list list-unstyled">
                        <li class="active" data-filter="*">Tất Cả</li>
                        <li data-filter=".food">Đồ Ăn</li>
                        <li data-filter=".drinking">Đồ Uống</li>
                        <li data-filter=".desert">Tráng Miệng</li>
                    </ul>
                </div>
            </div>

            <!-- Danh sách sản phẩm -->
            <div class="col-md-9">
                <div class="row product-lists">
                    <c:choose>
                        <c:when test="${not empty products}">
                            <c:forEach var="p" items="${products}">
                                <c:set var="catName" value="${p.category != null ? fn:toLowerCase(p.category.name) : 'food'}" />
                                <div class="col-lg-4 col-md-6 text-center ${catName}">
                                    <div class="single-product-item">
                                        <div class="product-image">
                                            <a href="${env}/product/${p.id}">
                                                <img src="${env}/UploadFiles/${p.avatar}" alt="${p.name}" loading="lazy">
                                            </a>
                                        </div>
                                        <h3>${p.name}</h3>
                                        <div class="product-price">
                                            <fmt:formatNumber value="${p.salePrice != 0 ? p.salePrice : p.price}" type="number" groupingUsed="true" minFractionDigits="0"/>đ
                                        </div>

                                        <button class="cart-btn" 
                                                onclick="addToCart(${p.id}, 1, ${p.salePrice != 0 ? p.salePrice : p.price}, '${fn:escapeXml(p.name)}', '${p.avatar}')">
                                            <i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng
                                        </button>
                                    </div>
                                </div>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <div class="col-12">
                                <div class="alert alert-secondary text-center">Hiện chưa có sản phẩm nào để hiển thị.</div>
                            </div>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"/>

    <script>
        // Filter theo danh mục
        document.addEventListener("DOMContentLoaded", function () {
            const filterButtons = document.querySelectorAll(".filter-list li");
            const products = document.querySelectorAll(".product-lists > div");

            filterButtons.forEach(button => {
                button.addEventListener("click", function () {
                    filterButtons.forEach(btn => btn.classList.remove("active"));
                    this.classList.add("active");

                    const filterValue = this.getAttribute("data-filter");
                    products.forEach(product => {
                        if (filterValue === "*" || product.classList.contains(filterValue.slice(1))) {
                            product.style.display = "block";
                        } else {
                            product.style.display = "none";
                        }
                    });
                });
            });
        });
    </script>
</body>
</html>
