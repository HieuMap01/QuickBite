package vn.devpro.minhhieu.controller.customer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.devpro.minhhieu.controller.BaseController;

@Controller
@RequestMapping("/wishlist")
public class CustomerWishlistController extends BaseController {

	@GetMapping
	public String view(Model model) {
		model.addAttribute("active", "wishlist");
		return "customer/pages_YeuThich";
	}
}
