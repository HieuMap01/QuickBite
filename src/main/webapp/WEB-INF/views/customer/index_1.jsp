<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Trang chủ</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" rel="stylesheet">
	<%-- CSS --%>
	<jsp:include page = "/WEB-INF/views/customer/layout/css.jsp"></jsp:include>
	
</head>
<body>
	  <jsp:include page ="/WEB-INF/views/customer/layout/header.jsp"></jsp:include>
      
      <!-- Navigation bar -->
	  <jsp:include page ="/WEB-INF/views/customer/layout/nav.jsp"></jsp:include>

      <main >
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
                  <button class="btn-back">
                    <i class="fa fa-arrow-left"></i>
                  </button>
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
                  <p>
                    Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.
                  </p>
                  <div class="food-buttons">
                    <button class="btn-main">READ MORE</button>
                    <button class="btn-icon">&#8592;</button>
                  </div>
                </div>

                <!-- Right content -->
                <div class="food-image-wrapper">
                  <div class="border-frame"></div>
                  <div class="food-image">
                    <img src="${env }/customer/assets/Home/images/1.png" alt="food" />
                    <div class="play-icon">
                      
                    </div>
                  </div>
                </div>
              </div>
            </section>
            <section class="section-food">
              <div class="container-food">
                <!-- left content -->
                <div class="food-image-wrapper">
                  <div class="border-frame"></div>
                  <div class="food-image">
                    <img src="${env }/customer/assets/Home/images/1.png" alt="food" />
                    <div class="play-icon">
                      
                    </div>
                  </div>
                </div>
                <!-- right content -->
                <div style="padding-left: 150px;" class="food-text">
                  <h2><strong>Let food be thy medicine<br>medicine be thy food.</strong></h2>
                  <p>
                    Lorem Ipsum available, but the majority have suffered <br> alteration in some form by injected humour randomise <br>
                    words which don't look even slightly believable. If you <br> are going to use a passage
                  </p>
                  <p>
                    Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text.
                  </p>
                  <div class="food-buttons">
                    <button class="btn-main">READ MORE</button>
                    <button class="btn-icon">&#8592;</button>
                  </div>
                </div>               
              </div>
            </section>
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
            <div class="menu-item">
                <div class="info">
                  <h2>Peanut butter <span class="price">$45</span></h2>
                  <p>Lorem Ipsum available, but the majority have suffered alteration in some form...</p>
                  <button>BUY NOW</button>
                </div>
                <div class="image">
                  <img src="${env }/customer/assets/Home/images/2.png" alt="Peanut Butter">
                </div>
              </div>

              <div class="menu-item">
                <div class="info">
                  <h2>Pumpkin pie <span class="price">$35</span></h2>
                  <p>Lorem Ipsum available, but the majority have suffered alteration in <br> some form, by in jectected humour, or randomised words which don't look even slightly</p>
                  <button>BUY NOW</button>
                </div>
                <div class="image">
                  <img src="${env }/customer/assets/Home/images/3.png" alt="Pumpkin Pie" >
                </div>
              </div>

              <div class="menu-item">
                <div class="info">
                  <h2>Jambalaya <span class="price">$50</span></h2>
                  <p>Lorem Ipsum available, but the majority have suffered alteration in some form...</p>
                  <button>BUY NOW</button>
                </div>
                <div class="image">
                  <img src="${env }/customer/assets/Home/images/4.png" alt="Jambalaya">
                </div>
              </div>
            </div>
            <!--  -->
            <div class="banner">
              <div class="text-box">
                <h3>Special</h3>
                <h1><span>SALE 50% DISCOUNT</span></h1>
                <h2>ALL FOOD PRODUCTS</h2>
                <p>Lorem Ipsum available, but the majority have suffered some form, by injected humour, or randomised words of Lorem Ipsum, you need to be sure.</p>
                <a href="#" class="btn">DISCOVER NOW</a>
              </div>
            </div>
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

            <div class="banner2 ">
              <div class="text-box text-box-2" >
                <h3>Special</h3>
                <h1><span>SALE 50% DISCOUNT</span></h1>
                <h2>ALL FOOD PRODUCTS</h2>
                <p>Lorem Ipsum available, but the majority have suffered some form, by injected humour, or randomised words of Lorem Ipsum, you need to be sure.</p>
                <a href="#" class="btn">DISCOVER NOW</a>
              </div>
            </div>

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
                <img src="${env }/customer/assets/Home/images/banhmi_03.png" alt="Hot Dog">
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
                <img src="${env }/customer/assets/Home/images/Hamberger_03.png" alt="Burger">
              </div>
            </div>
      </main>
	  
	  <jsp:include page ="/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>

      <button id="scrollToTopBtn" title="Go to top">↑</button>

	  <%-- JS --%>
	  <jsp:include page ="/WEB-INF/views/customer/layout/js.jsp"></jsp:include>
</body>
</html>