
package vn.devpro.minhhieu.controller.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.devpro.minhhieu.controller.BaseController;
import vn.devpro.minhhieu.model.Product;
import vn.devpro.minhhieu.model.ProductImage;
import vn.devpro.minhhieu.service.ProductImageService;
import vn.devpro.minhhieu.service.ProductService;

@Controller
@RequestMapping("/product")
public class CustomerProductController extends BaseController {
	@Autowired
	ProductService ps;

	@Autowired
	ProductImageService pis;

	@GetMapping("/{productId}")
	public String detail(@PathVariable("productId") int productId, Model model) {
		Product product = ps.getById(productId);
		if (product == null)
			return "redirect:/index";

		List<ProductImage> pImg = pis.findByProductId(productId);
		model.addAttribute("product", product);
		model.addAttribute("images", pImg);
		return "customer/pages_Chitietsp";
	}
}
