package vn.devpro.minhhieu.controller.customer;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

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
	public String listService(@RequestParam(value = "catId", required = false, defaultValue = "0") int catId,
			Model model) {

		model.addAttribute("categories", cs.findAllActive());
		model.addAttribute("activeCatId", catId == 0 ? null : catId);

		List<Product> products;
		if (catId == 0) {
			// Không chọn danh mục cụ thể -> hiện tất cả
			products = ps.findAllActive();
		} else {
			// Lọc theo danh mục
			products = ps.findAllActiveByCategoryId(catId);
		}

		model.addAttribute("products", products);
		return "customer/pages_Service";
	}

	@GetMapping("/search")
	public String searchService(@RequestParam(value = "q", required = false) String q,
			@RequestParam(value = "catId", required = false, defaultValue = "0") Integer catId, Model model) {

		// Build điều kiện tìm kiếm giống Admin nhưng dành cho khách
		vn.devpro.minhhieu.dto.ProductSearch s = new vn.devpro.minhhieu.dto.ProductSearch();
		s.setStatus(1); // chỉ lấy sản phẩm Active cho trang customer
		s.setCategoryId(catId == null ? 0 : catId);
		s.setKeyword((q != null && !q.trim().isEmpty()) ? q.trim() : null);

		// Tuỳ bạn có muốn phân trang DB tại đây hay không (setFirstResult/MaxResults
		// trong ps.search)
		java.util.List<vn.devpro.minhhieu.model.Product> products = ps.search(s);

		// Data cho view
		model.addAttribute("categories", cs.findAllActive());
		model.addAttribute("activeCatId", s.getCategoryId());
		model.addAttribute("keyword", s.getKeyword());
		model.addAttribute("products", products);

		// Trả về trang service của customer
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
