package vn.devpro.minhhieu.controller.customer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.devpro.minhhieu.controller.BaseController;

@Controller
@RequestMapping("/service")
public class CustomerServiceController extends BaseController {

	@GetMapping
	public String service(Model model) {
		model.addAttribute("active", "service");
		return "customer/pages_Service";
	}
}
