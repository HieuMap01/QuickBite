package vn.devpro.minhhieu.controller.administrator;

import java.security.Principal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.minhhieu.controller.BaseController;
import vn.devpro.minhhieu.dto.Cart;
import vn.devpro.minhhieu.dto.CartProduct;
import vn.devpro.minhhieu.model.Product;
import vn.devpro.minhhieu.model.SaleOrder;
import vn.devpro.minhhieu.model.SaleOrderProduct;
import vn.devpro.minhhieu.model.User;
import vn.devpro.minhhieu.service.ProductService;
import vn.devpro.minhhieu.service.SaleOrderService;
import vn.devpro.minhhieu.service.UserService;

@Controller
public class SaleOderController extends BaseController {

	@Autowired
	SaleOrderService ss = new SaleOrderService();

	@Autowired
	ProductService ps = new ProductService();

	@Autowired
	private UserService us;

	@RequestMapping(value = "/place-order", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> placeOder(final HttpServletRequest request,
			@RequestBody SaleOrder saleOrder, final Principal principal) {
		Map<String, Object> jsonResult = new HashMap<String, Object>();
		// lưu giỏ hàng

		if (StringUtils.isEmpty(saleOrder.getCustomerName())) {
			jsonResult.put("code", 404);
			jsonResult.put("message", "Bạn chưa điền tên");
			return ResponseEntity.ok(jsonResult);
		}
		if (StringUtils.isEmpty(saleOrder.getCustomerMobile())) {
			jsonResult.put("code", 404);
			jsonResult.put("message", "Bạn chưa điền sđt");
			return ResponseEntity.ok(jsonResult);
		}
		if (StringUtils.isEmpty(saleOrder.getCustomerAddress())) {
			jsonResult.put("code", 404);
			jsonResult.put("message", "Bạn chưa điền địa chỉ");
			return ResponseEntity.ok(jsonResult);
		}

		HttpSession session = request.getSession();

		if (session.getAttribute("cart") == null) {
			jsonResult.put("code", 404);
			jsonResult.put("message", "Bạn chưa có giỏ hàng");
			return ResponseEntity.ok(jsonResult);
		}

		Cart cart = (Cart) session.getAttribute("cart");
		if (cart.getCartProducts().size() < 1) {
			jsonResult.put("code", 404);
			jsonResult.put("message", "Bạn chưa có sp nào trong giỏ hàng");
			return ResponseEntity.ok(jsonResult);
		}

		// tạo 1 hoác đơn - sale order
		saleOrder.setTotal(cart.totalCartPrice());// tổng tiền hóa đơn
		Date date = new Date();
		String code = date.getYear() + date.getMonth() + date.getDay() + date.getHours() + date.getMinutes()
				+ date.getSeconds() + saleOrder.getCustomerMobile();
		saleOrder.setCode(code);
		saleOrder.setCreateDate(date);

		// ---- GÁN USER: nếu đã login -> user hiện tại; nếu chưa -> fallback id=2 ----
		User orderUser = null;
		if (principal != null) {
			User current = us.findByUsername(principal.getName());
			if (current != null) {
				orderUser = current;
			}
		}
		if (orderUser == null) { // fallback guest
			orderUser = new User();
			orderUser.setId(2); // 👈 guest user id (đảm bảo tồn tại trong DB)
		}
		saleOrder.setUser(orderUser);
		saleOrder.setStatus(true);

		// duyệt danh sách sp trong giỏ hàng để kết nối với order và product

		for (CartProduct cartProduct : cart.getCartProducts()) {
			// lấy sẳn phẩm trong db
			Product product = ps.getById(cartProduct.getId());

			SaleOrderProduct saleOrderProduct = new SaleOrderProduct();

			saleOrderProduct.setCreateDate(date);
			saleOrderProduct.setName(product.getName());
			saleOrderProduct.setPrice(product.getPrice());
			saleOrderProduct.setQuantity(cartProduct.getQuantity().intValue());

			// gắn sp da ban voi sp
			saleOrderProduct.setProduct(product);

			// găn sp bán với hóa đơn
			saleOrderProduct.setSaleOrder(saleOrder);

			// lưu
			saleOrder.addRelationalSaleOrderProduct(saleOrderProduct);

		}

		ss.saveOrUpdate(saleOrder);

		jsonResult.put("code", 200);
		jsonResult.put("message", "Bạn đặt hàng thành công");
		return ResponseEntity.ok(jsonResult);
	}

	@RequestMapping(value = "/admin/order/list")
	public String viewListOrders(final Model model) {
		List<SaleOrder> saleOrders = ss.findAll();
		model.addAttribute("saleOrders", saleOrders);
		return "administrator/order/order-list";
	}
}
