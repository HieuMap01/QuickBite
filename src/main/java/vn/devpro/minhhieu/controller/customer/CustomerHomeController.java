package vn.devpro.minhhieu.controller.customer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.devpro.minhhieu.controller.BaseController;

@Controller
@RequestMapping({ "/", "/home", "/index" })
public class CustomerHomeController extends BaseController {

	@GetMapping
	public String home(Model model) {
		model.addAttribute("active", "home");
		return "customer/index";
	}
}
