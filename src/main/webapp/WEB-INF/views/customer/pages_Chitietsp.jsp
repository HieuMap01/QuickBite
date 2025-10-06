<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <title>${product != null ? product.name : 'Chi tiết sản phẩm'}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">

  <!-- CSS chung -->
  <jsp:include page="/WEB-INF/views/customer/layout/css.jsp"/>

  <!-- Style CHỈ cho carousel của trang này -->
  <style>
    /* ảnh slide */
    #productCarousel .carousel-item img{
      width:100%;
      height:480px;
      object-fit:cover;
      border-radius:12px;
    }
    /* prev/next dạng nút tròn, không chiếm cả cột */
    #productCarousel .carousel-control-prev,
    #productCarousel .carousel-control-next{
      width:44px;height:44px;top:50%;transform:translateY(-50%);
      background:rgba(0,0,0,.35);border-radius:50%;opacity:.95;
    }
    #productCarousel .carousel-control-prev:hover,
    #productCarousel .carousel-control-next:hover{ background:rgba(0,0,0,.5); }
    /* icon mũi tên giữ nguyên của Bootstrap 4 */
    #productCarousel .carousel-control-prev-icon,
    #productCarousel .carousel-control-next-icon{ filter: invert(1) grayscale(1); }
    /* nếu theme làm hỏng .sr-only thì ép ẩn lại */
    #productCarousel .sr-only{
      position:absolute;width:1px;height:1px;padding:0;margin:-1px;overflow:hidden;clip:rect(0,0,0,0);border:0;
    }
    /* chấm chỉ báo (dots) nhỏ, gọn */
    #productCarousel .carousel-indicators li{
      width:8px;height:8px;border-radius:50%;
    }
    /* chặn các pseudo “hình bầu dục xanh” của theme nếu có */
    .single-product-img::before,
    .single-product-img::after{ content:none !important; display:none !important; }

    /* thumbnail */
    .thumb{ width:80px;height:80px;object-fit:cover;cursor:pointer;border-radius:8px; }
	
  </style>
</head>

<body>
  <jsp:include page="/WEB-INF/views/customer/layout/header.jsp"/>
  <jsp:include page="/WEB-INF/views/customer/layout/nav.jsp"/>

  <div class="single-product mt-150 mb-150">
    <div class="container">
      <div class="row align-items-start">
        <!-- ================== CỘT THÔNG TIN (TRÁI) ================== -->
        <div class="col-lg-7 order-2 order-lg-1">
          <h2 class="mb-2">${product.name}</h2>

          <div class="d-flex align-items-baseline mb-3">
            <span class="h3 text-success mb-0 mr-3">
              <fmt:formatNumber value="${product.salePrice != null && product.salePrice gt 0 ? product.salePrice : product.price}"
                                type="number" groupingUsed="true" minFractionDigits="0"/>đ
            </span>
            <c:if test="${product.salePrice != null && product.salePrice gt 0}">
              <span class="text-muted">
                <del><fmt:formatNumber value="${product.price}" type="number" groupingUsed="true" minFractionDigits="0"/>đ</del>
              </span>
            </c:if>
          </div>

          <p><strong>Mô tả ngắn:</strong> ${product.shortDescription}</p>

          <div class="d-flex align-items-center mb-4">
            <input type="number" min="1" value="1" class="form-control mr-3" style="width:110px" placeholder="Số lượng">
            <a href="#" class="btn btn-success mr-2">
              <i class="fas fa-shopping-cart"></i> Thêm vào giỏ hàng
            </a>
            <a href="#" class="btn btn-outline-success">
              <i class="far fa-heart"></i> Yêu thích
            </a>
          </div>

          <p><strong>Mô tả chi tiết:</strong> ${product.detailDescription}</p>
<!--
		  <h4 class="mt-4">Chia sẻ:</h4>
		  <ul class="product-share">
		    <li><a href="#"><i class="fab fa-facebook-f"></i></a></li>
		    <li><a href="#"><i class="fab fa-twitter"></i></a></li>
		    <li><a href="#"><i class="fab fa-google-plus-g"></i></a></li>
		    <li><a href="#"><i class="fab fa-linkedin"></i></a></li>
		  </ul>
		  -->
        </div>

        <!-- ================== CỘT ẢNH (PHẢI) ================== -->
        <div class="col-lg-5 order-1 order-lg-2">
          <div class="single-product-img">

            <%-- Chuẩn hóa URL avatar: thêm /UploadFiles/ nếu DB chỉ lưu Product/Avatar/... --%>
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
                      <%-- Chuẩn hóa URL ảnh con --%>
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

                  
                  <a class="carousel-control-prev" href="#productCarousel" role="button" data-slide="prev">
                    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                    <span class="sr-only">Previous</span>
                  </a>
                  <a class="carousel-control-next" href="#productCarousel" role="button" data-slide="next">
                    <span class="carousel-control-next-icon" aria-hidden="true"></span>
                    <span class="sr-only">Next</span>
                  </a>

                  <!-- Indicators -->
                  <ol class="carousel-indicators" style="margin-bottom:-18px;">
                    <li data-target="#productCarousel" data-slide-to="0" class="active"></li>
                    <c:forEach var="img" items="${images}" varStatus="st">
                      <li data-target="#productCarousel" data-slide-to="${st.index + 1}"></li>
                    </c:forEach>
                  </ol>
                </div>

                <!-- Thumbnails -->
                <div class="d-flex flex-wrap mt-3" style="gap:8px;">
                  <img src="<c:url value='${avatarUrl}'/>" class="thumb"
                       data-target="#productCarousel" data-slide-to="0" alt="thumb">
                  <c:forEach var="img" items="${images}" varStatus="st">
                    <c:choose>
                      <c:when test="${fn:startsWith(img.path,'/UploadFiles') || fn:startsWith(img.path,'UploadFiles')}">
                        <c:set var="imgUrl" value="${img.path}"/>
                      </c:when>
                      <c:otherwise>
                        <c:set var="imgUrl" value="${'UploadFiles/'.concat(img.path)}"/>
                      </c:otherwise>
                    </c:choose>
                    <c:set var="imgUrl" value="${fn:startsWith(imgUrl,'/') ? imgUrl : '/'.concat(imgUrl)}"/>
                    <img src="<c:url value='${imgUrl}'/>" class="thumb"
                         data-target="#productCarousel" data-slide-to="${st.index + 1}" alt="thumb">
                  </c:forEach>
                </div>
              </c:otherwise>
            </c:choose>

          </div>
        </div>
      </div>
    </div>
  </div>

  <!-- ===== JS: Bootstrap 4 (KHÔNG include thêm js.jsp để tránh trùng) ===== -->
  <script src="<c:url value='/customer/js/jquery-3.2.1.slim.min.js'/>"></script>
  <script src="<c:url value='/customer/js/popper.min.js'/>"></script>
  <script src="<c:url value='/customer/js/bootstrap.min.js'/>"></script>

  <!-- Ép carousel tự chạy (Bootstrap 4 dùng jQuery) -->
  <script>
    $(function () {
      $('#productCarousel').carousel({
        interval: 3500,
        ride: 'carousel',
        pause: false,
        wrap: true
      });
    });
  </script>

  <!-- Các JS khác của bạn (nếu cần) -->
  <script src="<c:url value='/customer/js/js.js'/>"></script>
  <script src="<c:url value='/customer/js/app.js'/>"></script>
</body>
</html>
