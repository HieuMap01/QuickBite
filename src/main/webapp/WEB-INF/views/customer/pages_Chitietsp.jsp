<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="utf-8">
  <title>${product != null ? product.name : 'Chi tiết sản phẩm'}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <%-- CSS --%>
  <jsp:include page="/WEB-INF/views/customer/layout/css.jsp"></jsp:include>
</head>

<body>
  
  <%@ include file="/WEB-INF/views/common/variables.jsp" %>

  <!-- Header + Nav -->
  <jsp:include page="/WEB-INF/views/customer/layout/header.jsp"/>
  <jsp:include page="/WEB-INF/views/customer/layout/nav.jsp"/>

  <div class="single-product mt-150 mb-150">
    <div class="container">
      <div class="row align-items-start">
        <!-- ====== CỘT TRÁI: THÔNG TIN ====== -->
        <div class="col-lg-7 order-2 order-lg-1">
          <h2 class="mb-2">${product.name}</h2>

          <c:set var="displayPrice"
                 value="${product.salePrice != null and product.salePrice gt 0 ? product.salePrice : product.price}" />
          <div class="d-flex align-items-baseline mb-3">
            <span class="h3 text-success mb-0 mr-3">
              <fmt:formatNumber value="${displayPrice}" type="number" groupingUsed="true" minFractionDigits="0" />đ
            </span>
            <c:if test="${product.salePrice != null and product.salePrice gt 0}">
              <span class="text-muted">
                <del><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" minFractionDigits="0" />đ</del>
              </span>
            </c:if>
          </div>

          <p class="mb-3"><strong>Mô tả ngắn:</strong> ${product.shortDescription}</p>

          <!-- Nhập số lượng + nút thêm -->
          <div class="d-flex align-items-center mb-4">
            <input type="number" id="quantity_${product.id}" min="1" value="1"
                   class="form-control mr-3" style="width:110px" placeholder="Số lượng"/>

            <button type="button" class="btn btn-success mr-2"
                    onclick="addToCart(
                      ${product.id},
                      document.getElementById('quantity_${product.id}').value,
                      ${displayPrice},
                      '${fn:escapeXml(product.name)}',
                      '${fn:escapeXml(product.avatar)}'
                    )">
              <i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng
            </button>

            <a href="#" class="btn btn-outline-success">
              <i class="far fa-heart"></i> Yêu thích
            </a>
          </div>

          <p><strong>Mô tả chi tiết:</strong> ${product.detailDescription}</p>
        </div>

        <!-- ====== CỘT PHẢI: ẢNH/CAROUSEL ====== -->
        <div class="col-lg-5 order-1 order-lg-2">
          <div class="single-product-img">

            <!-- chuẩn hóa URL avatar -->
            <c:choose>
              <c:when test="${fn:startsWith(product.avatar,'/UploadFiles') || fn:startsWith(product.avatar,'UploadFiles')}">
                <c:set var="avatarUrl" value="${product.avatar}"/>
              </c:when>
              <c:otherwise>
                <c:set var="avatarUrl" value="${'UploadFiles/'.concat(product.avatar)}"/>
              </c:otherwise>
            </c:choose>
            <c:set var="avatarUrl" value="${fn:startsWith(avatarUrl,'/') ? avatarUrl : '/'.concat(avatarUrl)}"/>

            <c:choose>

              <c:when test="${empty images}">
                <img class="img-fluid rounded shadow w-100"
                     src="<c:url value='${avatarUrl}'/>"
                     alt="${product.name}" loading="lazy">
              </c:when>


              <c:otherwise>
                <div id="productCarousel" class="carousel slide" data-ride="carousel" data-interval="3500">
                  <div class="carousel-inner">
                    <div class="carousel-item active">
                      <img src="<c:url value='${avatarUrl}'/>" class="d-block w-100" alt="${product.name}">
                    </div>

                    <c:forEach var="img" items="${images}">
                      <c:choose>
                        <c:when test="${fn:startsWith(img.path,'/UploadFiles') || fn:startsWith(img.path,'UploadFiles')}">
                          <c:set var="imgUrl" value="${img.path}"/>
                        </c:when>
                        <c:otherwise>
                          <c:set var="imgUrl" value="${'UploadFiles/'.concat(img.path)}"/>
                        </c:otherwise>
                      </c:choose>
                      <c:set var="imgUrl" value="${fn:startsWith(imgUrl,'/') ? imgUrl : '/'.concat(imgUrl)}"/>

                      <div class="carousel-item">
                        <img src="<c:url value='${imgUrl}'/>" class="d-block w-100"
                             alt="${img.title != null ? img.title : product.name}">
                      </div>
                    </c:forEach>
                  </div>

                  <!-- Prev/Next -->
                  <a class="carousel-control-prev" href="#productCarousel" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                  </a>
                  <a class="carousel-control-next" href="#productCarousel" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                  </a>

                  <!-- Dots -->
                  <ol class="carousel-indicators" style="margin-bottom:-18px;">
                    <li data-target="#productCarousel" data-slide-to="0" class="active"></li>
                    <c:forEach var="img" items="${images}" varStatus="st">
                      <li data-target="#productCarousel" data-slide-to="${st.index + 1}"></li>
                    </c:forEach>
                  </ol>
                </div>

                <!-- Thumbnails -->
                <div class="d-flex flex-wrap mt-3" style="gap:8px;">
                  <img src="<c:url value='${avatarUrl}'/>" class="thumb" data-target="#productCarousel" data-slide-to="0" alt="thumb">
                  <c:forEach var="img" items="${images}" varStatus="st">
                    <c:choose>
                      <c:when test="${fn:startsWith(img.path,'/UploadFiles') || fn:startsWith(img.path,'UploadFiles')}">
                        <c:set var="tUrl" value="${img.path}"/>
                      </c:when>
                      <c:otherwise>
                        <c:set var="tUrl" value="${'UploadFiles/'.concat(img.path)}"/>
                      </c:otherwise>
                    </c:choose>
                    <c:set var="tUrl" value="${fn:startsWith(tUrl,'/') ? tUrl : '/'.concat(tUrl)}"/>
                    <img src="<c:url value='${tUrl}'/>" class="thumb" data-target="#productCarousel" data-slide-to="${st.index + 1}" alt="thumb">
                  </c:forEach>
                </div>
              </c:otherwise>
            </c:choose>

          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- ================== JS: THỨ TỰ CHUẨN ================== -->
  <!-- jQuery FULL (có AJAX) - chỉ 1 lần -->
  <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

  <!-- Popper (cho Bootstrap 4) -->
  <script src="<c:url value='/customer/js/popper.min.js'/>"></script>

  <!-- Bootstrap JS (đúng 1 file, không lặp) -->
  <script src="<c:url value='/customer/js/bootstrap.min.js'/>"></script>

  <!-- (Tuỳ) JS chung của site, nhớ SỬA file nếu có code đụng DOM null -->
  <!-- <script src="<c:url value='/customer/js/js.js'/>"></script> -->
  <!-- <script src="<c:url value='/customer/js/app.js'/>"></script> -->

  <!-- Khởi tạo carousel (an toàn) -->
  <script>
    jQuery(function($){
      var $carousel = $('#productCarousel');
      if ($carousel.length && $.fn.carousel) {
        $carousel.carousel({ interval: 3500, ride: 'carousel', pause: false, wrap: true });
      }
    });
  </script>

  <!-- ADD TO CART (AJAX) -->
  <script>
    function addToCart(id, quantity, price, name, avatar){
      var $ = window.jQuery;
      if (!($ && $.ajax)) { alert('jQuery chưa sẵn sàng!'); return; }

      var qty = parseInt(quantity, 10);
      if (isNaN(qty) || qty < 1) qty = 1;

      $.ajax({
        url: '<c:url value="/add-to-cart"/>',
        type: 'POST',
        contentType: 'application/json; charset=UTF-8',
        data: JSON.stringify({
          id: id,
          quantity: qty,
          price: price,
          name: name,
          avatar: avatar
        }),
        dataType: 'json',
        success: function(res){
          if (res && typeof res.totalCartProducts !== 'undefined') {
            $('#totalCartProducts').text(res.totalCartProducts);
          }
          // Optional: thông báo
          // alert(res.code + ': ' + res.message);
        },
        error: function(xhr, status, err){
          console.error('Add-to-cart lỗi:', status, err, xhr.responseText);
          alert('Thêm giỏ hàng thất bại. Kiểm tra console.');
        }
      });
    }
  </script>
</body>
</html>
