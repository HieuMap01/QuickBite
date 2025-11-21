package vn.devpro.minhhieu.controller.administrator;

import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
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
@RequestMapping(value = "/admin/user/")
public class AdminUserController extends BaseController {

	@Autowired
	private UserService us;

	@Autowired
	private RoleService rs;

	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String userList(final Model model) throws IOException {
		// lay danh sach user tu tbl_user
		List<User> users = us.findAllActive();
		model.addAttribute("users", users);
		return "administrator/user/user-list";
	}

	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String userAdd(final Model model) throws IOException {
		// lấy danh sách user
		List<User> users = us.findAll();
		List<Role> roles = rs.findAll();

		model.addAllAttributes(Map.of("users", users, "roles", roles));

		User user = new User();

		user.setCreateDate(new Date());

		model.addAttribute("user", user);

		return "administrator/user/user-add";
	}

	// Save user to database
	@RequestMapping(value = "add-save", method = RequestMethod.POST)
	public String userAddSave(final Model model, final HttpServletRequest request, @ModelAttribute("user") User user)
			throws IOException {
		if (!StringUtils.isEmpty(request.getParameter("role"))) {
			int roleId = Integer.parseInt(request.getParameter("role"));
			// Lay role tu tbl_role trong DB
			Role role = rs.getById(roleId);
			// Luu user_id va role_id vao tbl_user_role
			user.addRelationalUserRole(role);
			// Ma hoa password
			user.setPassword(new BCryptPasswordEncoder(4).encode(user.getPassword()));
			// Luu user vao bang tbl_user
			us.save(user);
		}
		// Khong chon role thi khong luu user
		return "administrator/user/user-list";
	}

//-------------------- Edit user-----------------------------------------	
	@RequestMapping(value = "edit/{userId}", method = RequestMethod.GET)
	public String userEdit(final Model model, @PathVariable("userId") int userId // Lay user id khi click Edit
	) throws IOException {

		// Lay user tu tbl_user trong database
		User user = us.getById(userId);
		model.addAttribute("user", user);

		List<User> users = us.findAll();
		model.addAttribute("users", users);

		return "administrator/user/user-edit";
	}

	// Save user to database
	@RequestMapping(value = "edit-save", method = RequestMethod.POST)
	public String userEditSave(final Model model, final HttpServletRequest request, @ModelAttribute("user") User user)
			throws IOException {

		us.save(user);

		return "redirect:list";
	}

//-------------------- Delete user-----------------------------------------	
//	@RequestMapping(value = "/admin/user-delete/{userId}", method = RequestMethod.GET)
//	public String userDelete(final Model model,
//			@PathVariable("userId") int userId //Lay user id khi click Edit
//			) throws IOException {
//		
//		//Lay user tu tbl_user trong database
//		userService.deleteUserById(userId);
//		
//		return "redirect:/admin/user-list";
//	}
//	
//-------------------- Inactive user-----------------------------------------	
	@RequestMapping(value = "delete/{userId}", method = RequestMethod.GET)
	public String userDelete(final Model model, @PathVariable("userId") int userId // Lay user id khi click Edit
	) throws IOException {

		// Lay user tu tbl_user trong database
		User user = us.getById(userId);
		user.setStatus(Boolean.FALSE);

		us.save(user);

		return "redirect:list";
	}
}
