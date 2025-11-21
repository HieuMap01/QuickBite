package vn.devpro.minhhieu.controller;

import java.util.Date;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.devpro.minhhieu.dto.RegisterForm;
import vn.devpro.minhhieu.model.Role;
import vn.devpro.minhhieu.model.User;
import vn.devpro.minhhieu.repository.RoleRepository;
import vn.devpro.minhhieu.service.MailService;
import vn.devpro.minhhieu.service.UserService;

@Controller
public class AuthController extends BaseController {

	@Autowired
	private UserService userService;

	@Autowired
	private RoleRepository roleRepository;

	@Autowired
	private PasswordEncoder passwordEncoder;

	@Autowired
	private MailService mailService;

	// Hiển thị form
	@GetMapping("/register")
	public String registerForm(Model model) {
		if (!model.containsAttribute("form"))
			model.addAttribute("form", new RegisterForm());
		return "pages_register"; // hoặc đúng path JSP của bạn
	}

	// Xử lý submit
	@PostMapping("/register")
    public String doRegister(@Valid @ModelAttribute("form") RegisterForm form, BindingResult binding,
            RedirectAttributes ra) {

        System.out.println("=== STARTING REGISTER ===");
        System.out.println("Username: " + form.getUsername());
        System.out.println("Email: " + form.getEmail());
        
        // 1) Validate cơ bản
        if (binding.hasErrors()) {
            System.out.println("❌ BINDING ERRORS: " + binding.getAllErrors());
            ra.addFlashAttribute("org.springframework.validation.BindingResult.form", binding);
            ra.addFlashAttribute("form", form);
            ra.addFlashAttribute("error", "Vui lòng kiểm tra lại các trường!");
            return "redirect:/register";
        }
        
        if (!form.getPassword().equals(form.getConfirmPassword())) {
            System.out.println("❌ PASSWORD NOT MATCH");
            ra.addFlashAttribute("form", form);
            ra.addFlashAttribute("error", "Password và Confirm Password không khớp.");
            return "redirect:/register";
        }
        
        if (userService.existsByUsername(form.getUsername())) {
            System.out.println("❌ USERNAME EXISTS");
            ra.addFlashAttribute("form", form);
            ra.addFlashAttribute("error", "Username đã tồn tại.");
            return "redirect:/register";
        }
        
        if (userService.existsByEmail(form.getEmail())) {
            System.out.println("❌ EMAIL EXISTS");
            ra.addFlashAttribute("form", form);
            ra.addFlashAttribute("error", "Email đã được sử dụng.");
            return "redirect:/register";
        }

        try {
            // 2) Tạo user
            User u = new User();
            u.setUsername(form.getUsername().trim());
            u.setPassword(passwordEncoder.encode(form.getPassword()));
            u.setEmail(form.getEmail().trim());
            u.setName(form.getName());
            u.setMobile(form.getMobile());
            u.setAddress(form.getAddress());
            u.setStatus(true);
            u.setCreateDate(new Date());
            u.setUpdateDate(new Date());
            
            System.out.println("✓ User object created");

            // 3) Gán role CUSTOMER
            Role customer = roleRepository.findByName("CUSTOMER")
                    .orElseThrow(() -> new IllegalStateException("Role CUSTOMER chưa có trong DB"));
            u.addRelationalUserRole(customer);
            System.out.println("✓ Role assigned");

            // 4) Lưu
            User savedUser = userService.save(u);
            System.out.println("✓ User saved with ID: " + (savedUser != null ? savedUser.getId() : "NULL"));

            // 5) Gửi mail cho admin
            try {
                mailService.notifyAdminNewUser(u.getUsername(), u.getEmail(), u.getName(), u.getMobile(), u.getAddress());
                System.out.println("✓ Admin mail sent");
            } catch (Exception e) {
                System.out.println("⚠ Admin mail failed: " + e.getMessage());
                e.printStackTrace();
            }

            // 6) mail chào mừng user
            try {
                mailService.sendWelcomeToUser(u.getEmail(), u.getUsername());
                System.out.println("✓ Welcome mail sent");
            } catch (Exception e) {
                System.out.println("⚠ Welcome mail failed: " + e.getMessage());
                e.printStackTrace();
            }

            // 7) Điều hướng
            ra.addFlashAttribute("success", "Đăng ký thành công! Vui lòng đăng nhập.");
            System.out.println("✓ REGISTER SUCCESS - Redirecting to /login");
            return "redirect:/login";
            
        } catch (Exception e) {
            System.out.println("❌ FATAL ERROR: " + e.getMessage());
            e.printStackTrace();
            ra.addFlashAttribute("error", "Lỗi: " + e.getMessage());
            ra.addFlashAttribute("form", form);
            return "redirect:/register";
        }
    }

	@GetMapping("/login")
	public String login() {
		return "pages_Login";
	}
}
