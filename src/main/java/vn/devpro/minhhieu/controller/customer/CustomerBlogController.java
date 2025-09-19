
package vn.devpro.minhhieu.controller.customer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.devpro.minhhieu.controller.BaseController;

@Controller
@RequestMapping("/blog")
public class CustomerBlogController extends BaseController {

	@GetMapping
	public String blog(Model model) {
		model.addAttribute("active", "blog");
		return "customer/pages_Blog";
	}
}
