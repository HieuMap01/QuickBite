
package vn.devpro.minhhieu.controller.customer;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.devpro.minhhieu.controller.BaseController;

@Controller
@RequestMapping("/product")
public class CustomerProductController extends BaseController {

	@GetMapping
	public String detailDefault(Model model) {
		model.addAttribute("active", "product");
		return "customer/pages_Chitietsp";
	}

	@GetMapping("/{idOrSlug}")
	public String detail(@PathVariable String idOrSlug, Model model) {
		model.addAttribute("active", "product");
		// (chưa cần data động) — chỉ mở trang
		return "customer/pages_Chitietsp";
	}
}
