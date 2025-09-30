package vn.devpro.minhhieu.controller.administrator;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import vn.devpro.minhhieu.controller.BaseController;

@Controller
public class HomeAdminController extends BaseController {

	@RequestMapping(value = "admin/home")
	public String home() {
		return "administrator/home";
	}

}
