package vn.devpro.minhhieu.controller.customer;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.devpro.minhhieu.controller.BaseController;
import vn.devpro.minhhieu.model.SaleOrder;
import vn.devpro.minhhieu.model.User;
import vn.devpro.minhhieu.service.SaleOrderService;
import vn.devpro.minhhieu.service.UserService;

@Controller
@RequestMapping("/account")
public class CustomerProfileController extends BaseController {

	@Autowired
	private UserService us;

	@GetMapping("/profile")
	public String profile(Model model, Principal principal) {
		if (principal == null) { // <— chặn NPE
			return "redirect:/login";
		}
		User u = us.findByUsername(principal.getName());
		if (u == null) {
			return "redirect:/login?error=user_not_found";
		}
		model.addAttribute("user", u);
		return "customer/profile/profile_view";
	}

	@GetMapping("/profile/edit")
	public String editForm(Model model, Principal principal) {
		if (principal == null) {
			return "redirect:/login";
		}
		User u = us.findByUsername(principal.getName());
		if (u == null) {
			return "redirect:/login?error=user_not_found";
		}
		model.addAttribute("user", u);
		return "customer/profile/profile_edit"; // đổi đúng view của bạn
	}

	@PostMapping("/profile/edit-save")
	public String saveEdit(@ModelAttribute("user") User formUser, Principal principal, RedirectAttributes ra) {
		if (principal == null) { // <— chặn NPE
			return "redirect:/login";
		}
		us.updateProfile(principal.getName(), formUser);
		ra.addFlashAttribute("msg", "Cập nhật hồ sơ thành công!");
		return "redirect:/account/profile"; // đảm bảo đường dẫn đúng
	}

	@Autowired
	private SaleOrderService saleOrderService;
	@Autowired
	private UserService userService;

	@GetMapping("/orders")
	public String myOrders(Model model, Principal principal) {
		if (principal == null)
			return "redirect:/login";

		User u = userService.findByUsername(principal.getName());
		if (u == null)
			return "redirect:/login?error=user_not_found";

		// ✅ gọi theo userId
		List<SaleOrder> orders = saleOrderService.findAllByUserId(u.getId());
		model.addAttribute("orders", orders);
		return "customer/orders/my_orders"; // nhớ đúng đường dẫn JSP
	}

	@GetMapping("/orders/{id}")
	public String orderDetail(@PathVariable Integer id, Model model, Principal principal) {
		if (principal == null)
			return "redirect:/login";

		SaleOrder order = saleOrderService.findOrderWithItems(id);
		if (order == null)
			return "redirect:/account/orders?error=notfound";

		User u = userService.findByUsername(principal.getName());
		if (u == null || !order.getUser().getId().equals(u.getId())) // ✅ so sánh theo id
			return "redirect:/account/orders?error=unauthorized";

		model.addAttribute("order", order);
		return "customer/orders/my_order_detail";
	}

}
