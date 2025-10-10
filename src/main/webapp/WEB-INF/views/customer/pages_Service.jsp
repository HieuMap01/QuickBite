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

	<%-- CSS --%>
	<jsp:include page="/WEB-INF/views/customer/layout/css.jsp"></jsp:include>


    <style>


    </style>
</head>

<body>
	<%@ include file="/WEB-INF/views/common/variables.jsp" %>
    <jsp:include page="/WEB-INF/views/customer/layout/header.jsp"/>
    <jsp:include page="/WEB-INF/views/customer/layout/nav.jsp"/>

    <div class="container mt-150 mb-150">
        <div class="row">
            <!-- Filter bên trái -->
            <div class="col-md-3">
                <div class="filter-menu">
                    <h4 class="filter-title">Danh Mục</h4>
					<ul class="filter-list list-unstyled">
					  <li class="${empty activeCatId ? 'active' : ''}">
					    <a href="${env}/service">Tất Cả</a>
					  </li>
					  <c:forEach var="cat" items="${categories}">
					    <li class="${activeCatId == cat.id ? 'active' : ''}">
					      <a href="${env}/service?catId=${cat.id}">${cat.name}</a>
					    </li>
					  </c:forEach>
					</ul>

                </div>
            </div>

            <!-- Danh sách sản phẩm -->
            <div class="col-md-9">
                <div class="row product-lists">
                    <c:choose>
                        <c:when test="${not empty products}">
                            <c:forEach var="p" items="${products}">
                                <c:set var="catClass" value="${p.category != null ? 'cat'.concat(p.category.id) : 'uncat'}" />
                                <!-- Gắn class theo ID category để filter -->
                                <div class="col-lg-4 col-md-6 text-center product-card ${catClass}">
                                    <div class="single-product-item">
                                        <div class="product-image">
                                            <a href="${env}/product/${p.id}">
                                                <img src="${env}/UploadFiles/${p.avatar}" alt="${p.name}" loading="lazy">
                                            </a>
                                        </div>
                                        <h3>${p.name}</h3>

                                        <!-- Hiển thị giá -->
                                        <div class="product-price">
                                            <c:choose>
                                                <c:when test="${p.salePrice != null and p.salePrice gt 0}">
                                                    <span class="old">
                                                        <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true" minFractionDigits="0" />đ
                                                    </span>
                                                    <span class="new">
                                                        <fmt:formatNumber value="${p.salePrice}" type="number" groupingUsed="true" minFractionDigits="0" />đ
                                                    </span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span>
                                                        <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true" minFractionDigits="0" />đ
                                                    </span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
										<c:choose>
										    <c:when test="${p.salePrice ne null and p.salePrice gt 0 and p.salePrice lt p.price}">
										      <c:set var="displayPrice" value="${p.salePrice}" />
										    </c:when>
										    <c:otherwise>
										      <c:set var="displayPrice" value="${p.price}" />
										    </c:otherwise>
									   </c:choose>

                                        <button class="cart-btn"
                                            onclick="addToCart(
                                                ${p.id},
                                                1,
                                                ${displayPrice},
                                                '${fn:escapeXml(p.name)}',
                                                '${p.avatar}'
                                            )">
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
	<%-- JS --%>
	<jsp:include page="/WEB-INF/views/customer/layout/js.jsp"></jsp:include>



	<!-- Add to cart -->
	<script type="text/javascript">
		addToCart = function(_productId, _quantity, _price, _productName, _avatar) {		
			alert("Thêm "  + _quantity + " sản phẩm '" + _productName + "' vào giỏ hàng ");
			let data = {
				id: _productId, //lay theo id
				quantity: _quantity,
				price: _price,
				name: _productName,
				avatar: _avatar
			};
				
			//$ === jQuery
			jQuery.ajax({
				url : "/add-to-cart",
				type : "POST",
				contentType: "application/json",
				data : JSON.stringify(data),
				dataType : "json", //Kieu du lieu tra ve tu controller la json
				
				success : function(jsonResult) {
					alert(jsonResult.code + ": " + jsonResult.message);
					let totalProducts = jsonResult.totalCartProducts;
					$("#totalCartProducts").html(totalProducts);
				},
				
				error : function(jqXhr, textStatus, errorMessage) {
					alert(jsonResult.code + ': Đã có lỗi xảy ra...!')
				},
			});
		}
	</script>


</body>
</html>
