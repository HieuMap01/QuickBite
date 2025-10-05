package vn.devpro.minhhieu.controller.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.minhhieu.controller.BaseController;
import vn.devpro.minhhieu.model.Product;
import vn.devpro.minhhieu.service.ProductService;

@Controller
@RequestMapping({ "/", "/home", "/index" })
public class CustomerHomeController extends BaseController {

	@Autowired
	ProductService ps;

	@GetMapping
	@RequestMapping(method = RequestMethod.GET)
	public String home(Model model) {
		List<Product> products = ps.findAllActive();
		model.addAttribute("products", products);
		return "customer/index";
	}

}
