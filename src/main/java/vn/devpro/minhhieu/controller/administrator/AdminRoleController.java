package vn.devpro.minhhieu.controller.administrator;

import java.io.IOException;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import vn.devpro.minhhieu.controller.BaseController;
import vn.devpro.minhhieu.model.Role;
import vn.devpro.minhhieu.model.User;
import vn.devpro.minhhieu.service.RoleService;
import vn.devpro.minhhieu.service.UserService;

@Controller
@RequestMapping("/admin/role/")
public class AdminRoleController extends BaseController {

	@Autowired
	private RoleService rs;

	@Autowired
	private UserService us;

	// role list
	@GetMapping(value = "list")
	public String rolelist(final Model model) throws IOException {
		List<Role> roles = rs.findAllActive();
		model.addAttribute("roles", roles);
		return "administrator/role/role-list";
	}

//------------------Role add----------------------------------------------------	
	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String roleAdd(final Model model, final HttpServletRequest request, final HttpServletResponse response)
			throws IOException {

		Role role = new Role();
		Date currentDate = new Date();
		role.setCreateDate(currentDate);
		role.setUpdateDate(currentDate);
		model.addAttribute("role", role);
		List<User> users = us.findAllActive();
		model.addAttribute("users", users);

		return "administrator/role/role-add";
	}

	@RequestMapping(value = "add-save", method = RequestMethod.POST)
	public String roleAddSave(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("role") Role role) throws IOException {

		rs.saveOrUpdate(role);

		return "redirect:add";
	}

//------------------Role edit----------------------------------------------------	
	@RequestMapping(value = "edit/{roleId}", method = RequestMethod.GET)
	public String roleEdit(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("roleId") int roleId) throws IOException {

		Role role = rs.getById(roleId); // get role from db by id
		model.addAttribute("role", role);

		List<User> users = us.findAll();
		model.addAttribute("users", users);

		return "administrator/role/role-edit";
	}

	@RequestMapping(value = "edit-save", method = RequestMethod.POST)
	public String roleEditSave(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@ModelAttribute("role") Role role) throws IOException {

		rs.saveOrUpdate(role);

		return "redirect:list";
	}

//-----------------Delete role-------------------------------------------------
//	@RequestMapping(value = "/admin/role-delete/{roleId}", method = RequestMethod.GET)
//	public String roleDelete(final Model model, final HttpServletRequest request,
//			final HttpServletResponse response,
//			@PathVariable("roleId") int roleId //Get category id from category list when click Delete
//			) throws IOException {
//		
//		roleService.deleteRoleById(roleId);
//		
//		//Get role list
//		//List<Role> roles = roleService.findAll();
//		//model.addAttribute("roles", roles);
//	
//		return "redirect:/admin/role-list";
//	}

//-----------------Inactive role-------------------------------------------------
	@RequestMapping(value = "delete/{roleId}", method = RequestMethod.GET)
	public String roleInactvie(final Model model, final HttpServletRequest request, final HttpServletResponse response,
			@PathVariable("roleId") int roleId // Get role id from role list when click Delete
	) throws IOException {

		Role role = rs.getById(roleId);
		role.setStatus(Boolean.FALSE);
		rs.inactiveRole(role);

		// Get category list
//		List<Role> roles = roleService.findAll();
//		model.addAttribute("roles", roles);

		return "redirect:list";
	}
}
