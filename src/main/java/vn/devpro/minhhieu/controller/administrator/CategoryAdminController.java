package vn.devpro.minhhieu.controller.administrator;

import java.util.Date;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.minhhieu.controller.BaseController;
import vn.devpro.minhhieu.model.Category;
import vn.devpro.minhhieu.model.User;

@Controller
@RequestMapping("/admin/category/")
public class CategoryAdminController extends BaseController {

	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String list(Model model) {
		return "administrator/category/category-list";
	}

	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String view_add(Model model) {
		Category category = new Category();
		model.addAttribute("category", category);
		
		category.setCreateDate(new Date());
		
		List<User> user = us
	}
}
