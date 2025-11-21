
package vn.devpro.minhhieu.controller.customer;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.devpro.minhhieu.controller.BaseController;
import vn.devpro.minhhieu.dto.Cart;
import vn.devpro.minhhieu.dto.CartProduct;
import vn.devpro.minhhieu.dto.OrderRequest;
import vn.devpro.minhhieu.model.Product;
import vn.devpro.minhhieu.model.SaleOrder;
import vn.devpro.minhhieu.model.SaleOrderProduct;
import vn.devpro.minhhieu.model.User;
import vn.devpro.minhhieu.service.SaleOrderService;
import vn.devpro.minhhieu.service.UserService;

@Controller
public class CustomerCartController extends BaseController {

	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public String viewCart(final HttpServletRequest request, final Model model, Principal principal) {
		HttpSession session = request.getSession();
		BigDecimal total = BigDecimal.ZERO;
		if (session.getAttribute("cart") != null) {
			Cart cart = (Cart) session.getAttribute("cart");
			for (CartProduct cartProduct : cart.getCartProducts()) {
				total = total.add(cartProduct.totalPrice());
			}
		}
		model.addAttribute("totalCartPrice", total);
		return "customer/pages_Giohang";
	}

	@RequestMapping(value = "/update-product-quantity", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> editProductCart(@RequestBody CartProduct cartProduct,
			final HttpServletRequest request) {

		// Chia 2 trường hợp
		// TH1 : bấm dấu -
		// TH2 : bấm dấu +
		Map<String, Object> jsonResults = new HashMap<String, Object>();
		Cart cart = null;
		HttpSession session = request.getSession();
		if (session.getAttribute("cart") != null) { // có giỏ hàng
			cart = (Cart) session.getAttribute("cart");
			// TÌm hàng trong giỏ hàng cần sửa
			int index = cart.findById(cartProduct.getId());
			if (index != -1) {
				if (cartProduct.getQuantity().intValue() == -1) { // bấm nút -
					if (cart.getCartProducts().get(index).getQuantity().intValue() > 1) {
						cart.getCartProducts().get(index).updateQuantity(new BigInteger("-1"));
					}
				} else { // bấm +
					cart.getCartProducts().get(index).updateQuantity(new BigInteger("1"));

				}
				// Cập nhật lại session
				session.setAttribute("cart", cart);
				jsonResults.put("productId", cartProduct.getId());
				jsonResults.put("newQuantity", cart.getCartProducts().get(index).getQuantity());
				jsonResults.put("totalPrice", toCurrency(cart.getCartProducts().get(index).totalPrice()));
				jsonResults.put("totalCartPrice", toCurrency(cart.totalCartPrice()));
				jsonResults.put("totalCartProducts", super.totalCartProducts(request));

			}

		}
		return ResponseEntity.ok(jsonResults);

	}

	// Hamf chuyển số sang dang chuỗi định dạng tiền tệ
	public StringBuilder toCurrency(BigDecimal money) {
		StringBuilder str = new StringBuilder("" + money.longValue());
		int i = str.length() - 3;
		int j = 0;
		while (i > 0) {
			if (j % 3 == 0) {
				str.insert(j, ", ");
			}
			i--;
			j++;
		}
		return str;
	}

	@RequestMapping(value = "/add-to-cart", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addToCart(HttpServletRequest request,
			@RequestBody CartProduct cartProduct) {
		Map<String, Object> jsonResult = new HashMap<String, Object>();
		String message = "";

		if (cartProduct.getQuantity().intValue() < 1) {
			jsonResult.put("code", 400);
			jsonResult.put("message", "so luong khong hop le");
			return ResponseEntity.badRequest().body(jsonResult);
		} else {// thêm sản phẩm vào giỏ hàng
			// lấy session
			HttpSession session = request.getSession();
			if (session.getAttribute("cart") == null) {// chưa có giỏ hàng
				// khởi tạo giỏ hàng mới
				Cart cart = new Cart();
				session.setAttribute("cart", cart);
			}

			Cart cart = (Cart) session.getAttribute("cart");

			int index = cart.findById(cartProduct.getId());
			if (index == -1) { // sp chưa có trong giỏ hàng
				cart.getCartProducts().add(cartProduct);
			} else {
				cart.getCartProducts().get(index).updateQuantity(cartProduct.getQuantity());
			}
			jsonResult.put("code", 200);
			jsonResult.put("message", "Them san pham thanh cong");
			BigInteger totalCartProducts = BigInteger.ZERO;
			for (CartProduct product : cart.getCartProducts()) {
				totalCartProducts = totalCartProducts.add(product.getQuantity());
			}
			jsonResult.put("totalCartProducts", totalCartProducts);
			return ResponseEntity.ok(jsonResult);
		}
	}

	// Xoá 1 sản phẩm khỏi giỏ
	@RequestMapping(value = "/product-cart-delete/{id}", method = RequestMethod.GET)
	public String deleteProductFromCart(@PathVariable("id") Integer id, final HttpServletRequest request,
			RedirectAttributes redirectAttrs) {

		HttpSession session = request.getSession();
		Object obj = session.getAttribute("cart");
		if (obj instanceof vn.devpro.minhhieu.dto.Cart) {
			Cart cart = (Cart) obj;
			// Tìm theo id (tuỳ chữ ký findById; chuyển kiểu nếu cần)
			int index = cart.findById(id);
			if (index != -1) {
				cart.getCartProducts().remove(index);
				session.setAttribute("cart", cart);
				redirectAttrs.addFlashAttribute("msg", "Đã xoá sản phẩm khỏi giỏ.");
			} else {
				redirectAttrs.addFlashAttribute("msg", "Sản phẩm không còn trong giỏ.");
			}
		} else {
			redirectAttrs.addFlashAttribute("msg", "Giỏ hàng trống.");
		}
		return "redirect:/cart";
	}

	@Autowired
	private UserService userService;
	@Autowired
	private SaleOrderService saleOrderService;

	// ĐẶT HÀNG (AJAX)
	@RequestMapping(value = "customer/orders/place", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> placeOrder(@RequestBody OrderRequest req, Principal principal,
			HttpServletRequest request) {
		Map<String, Object> res = new HashMap<>();

		// 1) bắt buộc đăng nhập
		if (principal == null) {
			res.put("code", 401);
			res.put("message", "Bạn cần đăng nhập");
			return ResponseEntity.status(401).body(res);
		}
		User currentUser = userService.findByUsername(principal.getName());
		if (currentUser == null) {
			res.put("code", 404);
			res.put("message", "Không tìm thấy tài khoản");
			return ResponseEntity.status(404).body(res);
		}

		// 2) lấy giỏ từ session
		HttpSession session = request.getSession();
		Cart cart = (Cart) session.getAttribute("cart");
		if (cart == null || cart.getCartProducts().isEmpty()) {
			res.put("code", 400);
			res.put("message", "Giỏ hàng trống");
			return ResponseEntity.badRequest().body(res);
		}

		// 3) tạo đơn hàng
		SaleOrder order = new SaleOrder();
		order.setCode("QB" + System.currentTimeMillis());
		order.setCustomerName(req.getCustomerName());
		order.setCustomerMobile(req.getCustomerMobile());
		order.setCustomerEmail(req.getCustomerEmail());
		order.setCustomerAddress(req.getCustomerAddress());
		order.setTotal(cart.totalCartPrice());

		order.setUser(currentUser);

		order.setUserCreateSaleOrder(currentUser);

		// 4) chuyển các item trong cart -> SaleOrderProduct
		for (CartProduct cp : cart.getCartProducts()) {
			SaleOrderProduct sop = new SaleOrderProduct();

			// Gắn Product dựa theo id của sản phẩm trong giỏ hàng
			Product product = new Product();
			product.setId(cp.getId()); // chỉ gán id, không cần truy vấn DB
			sop.setProduct(product); // liên kết ManyToOne tới Product

			// Gắn các thông tin khác
			sop.setPrice(cp.getPrice());
			sop.setQuantity(cp.getQuantity().intValue());
			sop.setName(cp.getName()); // nếu CartProduct có name

			// Liên kết ngược lại với đơn hàng
			sop.setSaleOrder(order);

			order.getSaleOrderProducts().add(sop);
		}

		// 5) lưu
		saleOrderService.saveOrUpdate(order);

		// 6) ✅ reset giỏ sau khi đặt
		session.removeAttribute("cart");

		res.put("code", 200);
		res.put("message", "Đặt hàng thành công");
		return ResponseEntity.ok(res);
	}

}
