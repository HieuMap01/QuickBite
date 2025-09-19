package vn.devpro.minhhieu.controller.customer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.devpro.minhhieu.controller.BaseController;

@Controller
@RequestMapping("/pricing")
public class CustomerPricingController extends BaseController {

	@GetMapping
	public String pricing(Model model) {
		model.addAttribute("active", "pricing");
		return "customer/pages_Pricing";
	}
}
