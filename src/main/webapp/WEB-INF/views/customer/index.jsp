<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>



<%-- JSTL --%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions" %>
<fmt:setLocale value="vi_VN"/>
<!--
<%-- Nếu trang cha quên include variables.jsp, tự set env --%>
<c:if test="${empty env}">
  <c:set var="env" value="${pageContext.request.contextPath}" scope="request"/>
</c:if>
-->
<!DOCTYPE html>
<html>
<head>
  <meta charset='utf-8'>
  <meta http-equiv='X-UA-Compatible' content='IE=edge'>
  <title>Trang chủ</title>
  <meta name='viewport' content='width=device-width, initial-scale=1'>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">

  <%-- CSS --%>
  <jsp:include page="/WEB-INF/views/customer/layout/css.jsp"></jsp:include>
</head>
<body>

  <%-- Header & Nav --%>
  <%@ include file="/WEB-INF/views/common/variables.jsp" %>
  <jsp:include page="/WEB-INF/views/customer/layout/header.jsp"></jsp:include>
  <jsp:include page="/WEB-INF/views/customer/layout/nav.jsp"></jsp:include>

  <main>
    <div class="hero-banner">
      <div class="container">
        <div class="row align-items-center">
          <div class="col-md-6 hero-text">
            <h1>AMERICAN FOOD</h1>
            <h2>The Best Taste Food</h2>
            <hr>
            <p>Lorem Ipsum available, but the majority have <br> suffered alteration in some form, by injected <br> humour, or randomised words</p>
            <div class="button-group">
              <button class="btn-order">ORDER NOW</button>
              <button class="btn-back"><i class="fa fa-arrow-left"></i></button>
            </div>
          </div>
        </div>
      </div>
    </div>

    <!-- About us -->
    <section class="about-header-section">
      <div class="container text-center">
        <h2 class="about-header-title">
          <span class="background-text">ABOUT US</span>
          <span class="foreground-text">ABOUT US</span>
        </h2>
        <p class="about-description">
          Lorem Ipsum available, but the majority have suffered alteration<br>
          in some form by injected humour
        </p>
      </div>
    </section>

    <section class="section-food">
      <div class="container-food">
        <!-- Left content -->
        <div class="food-text">
          <h2><strong>Let food be thy medicine<br>medicine be thy food.</strong></h2>
          <p>
            Lorem Ipsum available, but the majority have suffered <br> alteration in some form by injected humour randomise <br>
            words which don't look even slightly believable. If you <br> are going to use a passage
          </p>
          <p>Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.</p>
          <div class="food-buttons">
            <button class="btn-main">READ MORE</button>
            <button class="btn-icon">&#8592;</button>
          </div>
        </div>

        <!-- Right content -->
        <div class="food-image-wrapper">
          <div class="border-frame"></div>
          <div class="food-image">
            <img src="<c:url value='${env}/customer/assets/Home/images/1.png'/>" alt="food" />
            <div class="play-icon"></div>
          </div>
        </div>
      </div>
    </section>

    <section class="section-food">
      <div class="container-food">
        <!-- Left content (image) -->
        <div class="food-image-wrapper">
          <div class="border-frame"></div>
          <div class="food-image">
            <img src="<c:url value='${env}/customer/assets/Home/images/1.png'/>" alt="food" />
            <div class="play-icon"></div>
          </div>
        </div>
        <!-- Right content (text) -->
        <div style="padding-left: 150px;" class="food-text">
          <h2><strong>Let food be thy medicine<br>medicine be thy food.</strong></h2>
          <p>
            Lorem Ipsum available, but the majority have suffered <br> alteration in some form by injected humour randomise <br>
            words which don't look even slightly believable. If you <br> are going to use a passage
          </p>
          <p>Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.</p>
          <div class="food-buttons">
            <button class="btn-main">READ MORE</button>
            <button class="btn-icon">&#8592;</button>
          </div>
        </div>
      </div>
    </section>

    <%-- =========================
         SERVICE (DYNAMIC PRODUCTS)
         ========================= --%>
    <section class="service-section">
      <div class="title-container">
        <h1 class="bg-title">SERVICE</h1>
        <h2 class="main-title">SERVICE</h2>
      </div>
      <p class="description">
        Lorem Ipsum available, but the majority have suffered alteration<br>
        in some form by injected humour
      </p>
    </section>

    <div class="container" style="max-width:1200px;">
      <div class="row">
        <c:forEach items="${products}" var="p">
          <div class="col-12 col-sm-6 col-lg-4 mb-4">
            <div class="service-card" style="text-align:center; border:1px solid #eee; border-radius:12px; padding:10px; height:100%; display:flex; flex-direction:column; justify-content:space-between;">
              <div class="service-card-img">
                <a href="<c:url value='/product/${p.id}'/>">
                  <img src="<c:url value='/UploadFiles/${p.avatar}'/>"
                       alt="<c:out value='${p.name}'/>"
                       style="width:100%; height:180px; object-fit:cover; border-radius:10px;">
                </a>
              </div>

              <div class="service-card-body" style="margin-top:10px;">
                <h5 style="font-size:18px; margin:5px 0;"><c:out value="${p.name}"/></h5>
                <div class="price-box">
                  <c:choose>
                    <c:when test="${p.salePrice ne null and p.salePrice gt 0 and p.salePrice lt p.price}">
                      <span class="price-old">
                        <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true" minFractionDigits="0" />đ
                      </span>
                      <span class="price-new">
                        <fmt:formatNumber value="${p.salePrice}" type="number" groupingUsed="true" minFractionDigits="0" />đ
                      </span>
                    </c:when>
                    <c:otherwise>
                      <span style="color:#222; font-weight:700;">
                        <fmt:formatNumber value="${p.price}" type="number" groupingUsed="true" minFractionDigits="0" />đ
                      </span>
                    </c:otherwise>
                  </c:choose>
                </div>

                <c:if test="${not empty p.shortDescription}">
                  <p style="font-size:14px; color:#777; margin:5px 0 10px;">
                    <c:out value="${p.shortDescription}"/>
                  </p>
                </c:if>
              </div>

			  <c:choose>
			    <c:when test="${p.salePrice ne null and p.salePrice gt 0 and p.salePrice lt p.price}">
			      <c:set var="displayPrice" value="${p.salePrice}" />
			    </c:when>
			    <c:otherwise>
			      <c:set var="displayPrice" value="${p.price}" />
			    </c:otherwise>
			  </c:choose>

			  <div class="service-card-footer" style="margin-top:auto; display:flex; gap:4px;">
			    <button type="button"
			            class="btn btn-dark btn-add flex-fill"
			            style="flex: 0 0 56%;"
			            onclick="addToCart(${p.id}, 1, ${displayPrice}, '${p.name}', '${p.avatar}')">
			      THÊM GIỎ HÀNG
			    </button>
			    <a href="<c:url value='/product/${p.id}'/>"
			       class="btn btn-outline-dark flex-fill"
			       style="flex: 0 0 44%; text-align:center;">
			      CHI TIẾT
			    </a>
			  </div>

            </div>
          </div>
        </c:forEach>
      </div>

      <!-- Xem thêm -->
      <div style="text-align:center; margin-top:12px;">
        <a class="btn btn-outline-dark" href="<c:url value='/customer/danhmuc.html'/>">XEM THÊM</a>
      </div>
    </div>
    <%-- ===== END SERVICE ===== --%>

    <!-- Banner -->
    <div class="banner">
      <div class="text-box">
        <h3>Special</h3>
        <h1><span>SALE 50% DISCOUNT</span></h1>
        <h2>ALL FOOD PRODUCTS</h2>
        <p>Lorem Ipsum available, but the majority have suffered some form, by injected humour, or randomised words of Lorem Ipsum, you need to be sure.</p>
        <a href="#" class="btn">DISCOVER NOW</a>
      </div>
    </div>

    <!-- Pricing -->
    <section class="service-section">
      <div class="title-container">
        <h1 class="bg-title">PRICING</h1>
        <h2 class="main-title">PRICING</h2>
      </div>
      <p class="description">
        Lorem Ipusm available, but the majority have suffered alteration <br> in some form by injected humour.
      </p>
    </section>

    <div class="pricing-table">
      <div class="pricing-card">
        <div class="highlight">
          <h3>Basic</h3>
          <span class="">$19.99</span>
        </div>
        <p>Lorem Ipsum available</p>
        <p>Lorem Ipsum available</p>
        <p>Lorem Ipsum available</p>
        <button>BUY NOW</button>
      </div>
      <div class="pricing-card">
        <div class="highlight">
          <h3>Basic</h3>
          <span class="">$19.99</span>
        </div>
        <p>Lorem Ipsum availabla</p>
        <p>Lorem Ipsum available</p>
        <p>Lorem Ipsum available</p>
        <button>BUY NOW</button>
      </div>
      <div class="pricing-card">
        <div class="highlight">
          <h3>Basic</h3>
          <span class="">$19.99</span>
        </div>
        <p>Lorem Ipsum available, </p>
        <p>Lorem Ipsum available</p>
        <p>Lorem Ipsum available</p>
        <button>BUY NOW</button>
      </div>
    </div>

    <div class="banner2">
      <div class="text-box text-box-2">
        <h3>Special</h3>
        <h1><span>SALE 50% DISCOUNT</span></h1>
        <h2>ALL FOOD PRODUCTS</h2>
        <p>Lorem Ipsum available, but the majority have suffered some form, by injected humour, or randomised words of Lorem Ipsum, you need to be sure.</p>
        <a href="#" class="btn">DISCOVER NOW</a>
      </div>
    </div>

    <!-- Blog -->
    <section class="service-section">
      <div class="title-container">
        <h1 class="bg-title">BLOG</h1>
        <h2 class="main-title">BLOG</h2>
      </div>
      <p class="description">
        Lorem Ipusm available, but the majority have suffered alteration <br> in some form by injected humour.
      </p>
    </section>

    <div class="blog-post">
      <div class="post-box">
        <img src="<c:url value='${env}/customer/assets/Home/images/banhmi_03.png'/>" alt="Hot Dog">
      </div>

      <div class="post-box post-content-box">
        <div class="post-content">
          <h3 class="post-title">Eat food. Not too much mostly plants.</h3>
          <p class="post-description">
            Lorem Ipsum available, but the majority have suffered alteration some form, by injected humour randomised words.
          </p>
          <button class="btn">Read More</button>
        </div>
      </div>

      <div class="post-box">
        <img src="<c:url value='${env}/customer/assets/Home/images/Hamberger_03.png'/>" alt="Burger">
      </div>
    </div>
  </main>

  <%-- Footer --%>
  <jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>

  <button id="scrollToTopBtn" title="Go to top">↑</button>

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
