
package vn.devpro.minhhieu.controller.customer;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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

@Controller
public class CustomerCartController extends BaseController {

	@RequestMapping(value = "/cart", method = RequestMethod.GET)
	public String viewCart(final HttpServletRequest request, final Model model) {
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

}
