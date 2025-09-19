package vn.devpro.minhhieu.controller.customer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.devpro.minhhieu.controller.BaseController;

@Controller
@RequestMapping("/about")
public class CustomerAboutController extends BaseController {

	@GetMapping
	public String about(Model model) {
		model.addAttribute("active", "about");
		return "customer/pages_AboutUs";
	}
}
