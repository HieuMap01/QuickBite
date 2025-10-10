<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"   uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn"  uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<fmt:setLocale value="vi_VN"/>

<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <title>${title != null ? title : 'Giỏ hàng'}</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">


  <%-- CSS --%>
  <jsp:include page="/WEB-INF/views/customer/layout/css.jsp"></jsp:include>

</head>

<body>
<div class="wrapper">
  <!-- HEADER + NAV (tuỳ bạn giữ hay bỏ) -->
  <jsp:include page="/WEB-INF/views/customer/layout/header.jsp"></jsp:include>
  <jsp:include page="/WEB-INF/views/customer/layout/nav.jsp"></jsp:include>

  <main class="main">
    <div class="main__products">
      <div class="container" id="cartView">

        <div class="main__products-title">
          <p>GIỎ HÀNG CỦA BẠN</p>
        </div>

        <c:choose>
          <c:when test="${totalCartProducts > 0}">
            <!-- BẢNG GIỎ HÀNG -->
            <div class="row">
              <div class="col-12">
                <div class="qb-card">
                  <div class="card-body">
                    <div class="row">
                      <div class="col-12">
                        <table class="table table-striped table-bordered no-wrap">
                          <thead>
                          <tr>
                            <th class="text-center" style="width:56px;">No.</th>
                            <th class="text-center" style="width:100px;">Ảnh</th>
                            <th class="text-center">Sản phẩm</th>
                            <th class="text-center" style="width:160px;">Số lượng</th>
                            <th class="text-center" style="width:140px;">Giá</th>
                            <th class="text-center" style="width:160px;">Tổng</th>
                            <th class="text-center" style="width:160px;">Thao tác</th>
                          </tr>
                          </thead>

                          <tbody>
                          <c:forEach var="p" items="${cart.cartProducts}" varStatus="loop">
                            <tr>
                              <th scope="row" class="text-center" data-title="No.">${loop.index + 1}</th>

                              <td class="text-center" data-title="Ảnh">
                                <img src="<c:url value='/UploadFiles/${p.avatar}'/>" width="80" class="img-fluid" alt="${p.name}"/>
                              </td>

                              <td data-title="Sản phẩm">
                                <div class="font-weight-bold">${p.name}</div>
                              </td>

                              <td class="text-center" data-title="Số lượng">
                                <div class="qty-stepper">
                                  <button type="button" onclick="updateProductQuantity(${p.id}, -1)">−</button>
                                  <span id="productQuantity_${p.id}">${p.quantity}</span>
                                  <button type="button" onclick="updateProductQuantity(${p.id}, 1)">+</button>
                                </div>
                              </td>

                              <td class="text-right" data-title="Giá">
                                <span class="price"><fmt:formatNumber value="${p.price}" minFractionDigits="0"/>đ</span>
                              </td>

                              <td class="text-right" data-title="Tổng">
                                <span id="totalPrice_${p.id}" class="price">
                                  <fmt:formatNumber value="${p.price * p.quantity}" minFractionDigits="0"/>đ
                                </span>
                              </td>

                              <td class="text-center" data-title="Thao tác">
                                <a href="<c:url value='/product/${p.id}'/>" class="chip chip-view">Xem</a>
                                <a href="<c:url value='/product-cart-delete/${p.id}'/>" class="chip chip-del">Xóa</a>
                              </td>
                            </tr>
                          </c:forEach>
                          </tbody>
                        </table>
                      </div>
                    </div>

                    <!-- TỔNG TIỀN + NÚT -->
                    <div class="row align-items-start mt-3">
                      <div class="col-md-6">
                        <div class="total-box">
                          <div class="total-line">
                            <span class="label">Tổng tiền sản phẩm</span>
                            <span><strong id="totalCartPriceId">
                              <fmt:formatNumber value="${totalCartPrice}" minFractionDigits="0"/>
                            </strong>đ</span>
                          </div>
                          <div class="total-line">
                            <span class="label">Vận chuyển</span>
                            <span><strong>25.000</strong>đ</span>
                          </div>
                          <div class="total-line final">
                            <span>Tổng thanh toán</span>
                            <span id="Tong"><fmt:formatNumber value="${totalCartPrice + 25000}" minFractionDigits="0"/>đ</span>
                          </div>
                        </div>
                      </div>


                  </div>
                </div>
              </div>
            </div>

            <!-- FORM THÔNG TIN -->
            <div class="row mt-3">
              <div class="col-12">
                <div class="qb-card">
                  <div class="card-body qb-form">
                    <div class="main__products-title"><p>Thông tin khách hàng</p></div>
                    <div class="row">
                      <div class="col-md-6">
                        <label>Họ tên</label>
                        <input type="text" id="txtName" class="form-control" value="${loginedUser.name}"/>
                      </div>
                      <div class="col-md-6">
                        <label>Điện thoại</label>
                        <input type="text" id="txtMobile" class="form-control" value="${loginedUser.mobile}"/>
                      </div>
                      <div class="col-md-6 mt-2">
                        <label>Email</label>
                        <input type="email" id="txtEmail" class="form-control" value="${loginedUser.email}"/>
                      </div>
                      <div class="col-md-6 mt-2">
                        <label>Địa chỉ</label>
                        <input type="text" id="txtAddress" class="form-control" value="${loginedUser.address}"/>
                      </div>
                      <div class="col-12 mt-3">
                        <a href="<c:url value='/index'/>" class="btn btn-outline-qb mr-2">Quay lại shop</a>
                        <button class="btn btn-qb" onclick="_placeOrder()">Đặt hàng</button>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>

          </c:when>
          <c:otherwise>
            <div class="row">
              <div class="col-12" align="center">
                <h3>Giỏ hàng trống</h3>
                <a href="<c:url value='/index'/>" class="btn btn-qb">Mua sắm ngay</a>
              </div>
            </div>
          </c:otherwise>
        </c:choose>

      </div>
    </div>
  </main>

  <!-- FOOTER (tuỳ) -->
  <jsp:include page="/WEB-INF/views/customer/layout/footer.jsp"></jsp:include>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
  // --- Helpers ---
  function parseVNDToNumber(val) {
    if (typeof val === "number") return val;
    if (!val) return 0;
    // nhận cả "1.234.567đ" hoặc "1,234,567"
    return Number(String(val).replace(/[^\d]/g, "")) || 0;
  }
  function formatVND(num) {
    return Number(num).toLocaleString("vi-VN");
  }

  // --- Cộng/trừ số lượng: tên hàm & payload y như của thầy ---
  function updateProductQuantity(_productId, _quantity) {
    const data = { id: _productId, quantity: _quantity };

    jQuery.ajax({
      url: "<c:url value='/update-product-quantity'/>",   // vẫn an toàn với context-path
      type: "POST",
      contentType: "application/json",
      data: JSON.stringify(data),
      dataType: "json",
      success: function (jsonResult) {
        // Controller của thầy trả về: productId, newQuantity, totalCartPrice, totalPrice, totalCartProducts
        // (các field ở ROOT, không có res.code/res.data)
        try {
          // 1) số lượng của dòng
          jQuery("#productQuantity_" + jsonResult.productId).html(jsonResult.newQuantity);

          // 2) tổng tiền của dòng
          // nếu server đã format sẵn → dùng luôn; nếu là số raw → tự format
          const lineTotalIsNumber = typeof jsonResult.totalPrice === "number";
		  const lineTotal = parseVNDToNumber(jsonResult.totalPrice);
		  jQuery("#totalPrice_" + jsonResult.productId).html(formatVND(lineTotal) + "đ");


          // 3) tổng tiền giỏ
          const cartTotalIsNumber = typeof jsonResult.totalCartPrice === "number";
		  const cartTotal = parseVNDToNumber(jsonResult.totalCartPrice);
		  jQuery("#totalCartPriceId").html(formatVND(cartTotal));


          // 4) badge trên header
          jQuery("#totalCartProducts").html(jsonResult.totalCartProducts);

          // 5) tổng thanh toán (giữ UI của bạn: + 25k ship)
          const rawCartTotal = cartTotalIsNumber
            ? jsonResult.totalCartPrice
            : parseVNDToNumber(jsonResult.totalCartPrice);
          jQuery("#Tong").text(formatVND(rawCartTotal + 25000) + "đ");
        } catch (e) {
          alert("Cập nhật thất bại");
        }
      },
      error: function () {
        alert("Có lỗi xảy ra");
      }
    });
  }

  // --- Đặt hàng: tên field & endpoint y như của thầy ---
  function _placeOrder() {
    const data = {
      customerName:   jQuery("#txtName").val(),
      customerEmail:  jQuery("#txtEmail").val(),
      customerMobile: jQuery("#txtMobile").val(),
      customerAddress:jQuery("#txtAddress").val()
    };

    jQuery.ajax({
      url: "<c:url value='/place-order'/>",
      type: "POST",
      contentType: "application/json",
      data: JSON.stringify(data),
      dataType: "json",
      success: function (jsonResult) {
        // bản của thầy alert code + message
        alert((jsonResult.code || "OK") + ": " + (jsonResult.message || "Đặt hàng thành công"));
        // reload lại giỏ
        window.location.href = "<c:url value='/cart'/>";
      },
      error: function () {
        alert("Có lỗi khi đặt hàng");
      }
    });
  }
</script>

</body>
</html>
