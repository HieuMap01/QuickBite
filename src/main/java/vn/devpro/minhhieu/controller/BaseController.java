package vn.devpro.minhhieu.controller;

import java.math.BigInteger;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;

import vn.devpro.minhhieu.dto.Cart;
import vn.devpro.minhhieu.dto.CartProduct;

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
}
