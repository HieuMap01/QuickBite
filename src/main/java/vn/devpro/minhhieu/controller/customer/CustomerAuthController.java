package vn.devpro.minhhieu.controller.customer;

import javax.validation.Valid;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder; // <-- có nhờ spring-security-crypto
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.devpro.minhhieu.controller.BaseController;
import vn.devpro.minhhieu.dto.RegisterForm;
import vn.devpro.minhhieu.model.User;
import vn.devpro.minhhieu.service.MailService;
import vn.devpro.minhhieu.service.UserService;

@Controller
@RequestMapping("/auth")
public class CustomerAuthController extends BaseController {

	private final UserService userService;
	private final MailService mailService;
	private final BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();

	public CustomerAuthController(UserService userService, MailService mailService) {
		this.userService = userService;
		this.mailService = mailService;
	}

	@GetMapping("/register")
	public String register(Model model) {
		model.addAttribute("active", "auth");
		if (!model.containsAttribute("registerForm")) {
			model.addAttribute("registerForm", new RegisterForm());
		}
		return "customer/pages_register";
	}

	@PostMapping("/register")
	public String doRegister(@Valid @ModelAttribute("registerForm") RegisterForm form, BindingResult binding,
			Model model, RedirectAttributes ra) {
		model.addAttribute("active", "auth");

		if (userService.existsByUsername(form.getUsername())) {
			binding.rejectValue("username", "username.exists", "Username đã tồn tại");
		}
		if (userService.existsByEmail(form.getEmail())) {
			binding.rejectValue("email", "email.exists", "Email đã tồn tại");
		}
		if (binding.hasErrors())
			return "customer/pages_register";

		User u = new User();
		u.setUsername(form.getUsername());
		u.setPassword(encoder.encode(form.getPassword())); // mã hoá an toàn
		u.setEmail(form.getEmail());
		u.setName(form.getName());
		u.setMobile(form.getMobile());
		u.setStatus(true);
		userService.save(u);

		try {
			mailService.notifyAdminNewUser(u.getUsername(), u.getEmail(), u.getName(), u.getMobile());
		} catch (Exception e) {
			System.err.println("Notify admin failed: " + e.getMessage());
		}

		try {
			mailService.sendWelcomeToUser(u.getEmail(), u.getUsername());
		} catch (Exception e) {
			System.err.println("Welcome mail failed: " + e.getMessage());
		}

		ra.addFlashAttribute("message", "Đăng ký thành công! Vui lòng đăng nhập.");
		return "redirect:/auth/login";
	}

	@GetMapping("/test-mail")
	@ResponseBody
	public String testMail() {
		try {
			// In thông số JavaMailSender để chắc chắn đang dùng đúng host/port/user
			org.springframework.mail.javamail.JavaMailSenderImpl impl = (org.springframework.mail.javamail.JavaMailSenderImpl) mailService
					.getSenderForDebug();

			System.out.println("[MAIL CFG] host=" + impl.getHost() + ", port=" + impl.getPort() + ", username="
					+ impl.getUsername());

			// Gửi thử về chính bạn
			mailService.notifyAdminNewUser("testuser", "test@example.com", "Test Name", "0123456789");
			return "OK: sent to admin (" + impl.getUsername() + ")";
		} catch (Exception e) {
			e.printStackTrace(); // ép in stacktrace ra console
			return "ERROR: " + e.getClass().getSimpleName() + " - " + e.getMessage();
		}
	}

	@GetMapping("/login")
	public String login(Model model) {
		model.addAttribute("active", "auth");
		return "customer/pages_Login";
	}
}
