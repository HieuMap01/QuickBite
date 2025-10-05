package vn.devpro.minhhieu.controller.customer;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.devpro.minhhieu.controller.BaseController;
import vn.devpro.minhhieu.model.Product;
import vn.devpro.minhhieu.service.CategoryService;
import vn.devpro.minhhieu.service.ProductService;

@Controller
@RequestMapping("/service")
public class CustomerServiceController extends BaseController {

	@Autowired
	ProductService ps;

	@Autowired
	CategoryService cs;

	@GetMapping
	public String service(Model model) {
		List<vn.devpro.minhhieu.model.Category> categories = cs.findAllActive();
		List<Product> products = ps.findAllActive();
		model.addAllAttributes(Map.of("products", products, "category", categories));
		return "customer/pages_Service";
	}

//	@RequestMapping(value = { "/product/{productId}" }, method = RequestMethod.GET)
//	public String home(final Model model, @PathVariable("productId") int productId) {
//
//		// lấy sản phẩm từ danh sách
//		Product product = ps.getById(productId);
//		model.addAttribute("product", product);
//
//		// model.addAttribute("productImages", product.getProductImages());
//
//		return "customer/pages_Service";
//	}
}
