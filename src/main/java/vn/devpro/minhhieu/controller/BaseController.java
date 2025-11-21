package vn.devpro.minhhieu.controller;

import java.math.BigInteger;
import java.security.Principal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;

import vn.devpro.minhhieu.dto.Cart;
import vn.devpro.minhhieu.dto.CartProduct;
import vn.devpro.minhhieu.model.User;
import vn.devpro.minhhieu.service.UserService;

@Controller
public class BaseController {

	@ModelAttribute("totalCartProducts")
	public BigInteger totalCartProducts(final HttpServletRequest request) {
		// lấy giỏ hàng - session
		BigInteger total = BigInteger.ZERO;

		HttpSession session = request.getSession();
		if (session.getAttribute("cart") != null) {
			Cart cart = (Cart) session.getAttribute("cart");
			for (CartProduct cartProduct : cart.getCartProducts()) {
				total = total.add(cartProduct.getQuantity());
			}

		}

		return total;
	}

	@Autowired
	private UserService us;

//chạy trước mọi request để thêm dữ liệu dùng chung (currentUser) vào Model.
	@ModelAttribute
	public void addCommonData(Model model, Principal principal) {
		if (principal != null) {
			User u = us.findByUsername(principal.getName());
			model.addAttribute("currentUser", u);
		}
	}

}
