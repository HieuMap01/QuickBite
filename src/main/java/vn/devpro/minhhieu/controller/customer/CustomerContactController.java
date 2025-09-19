package vn.devpro.minhhieu.controller.customer;

import static vn.devpro.minhhieu.dto.QbContanst.FOLDER_UPLOAD;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import vn.devpro.minhhieu.controller.BaseController;
import vn.devpro.minhhieu.model.Contact;

@Controller
@RequestMapping("/contact/")
public class CustomerContactController extends BaseController {

	@RequestMapping(value = "view", method = RequestMethod.GET)
	public String home(final Model model) {
		Contact ct = new Contact();
		model.addAttribute("contact", ct);// đẩy đối tượng sang view để khởi tạo
		return "customer/pages_Contact";
	}

	@RequestMapping(value = "save", method = RequestMethod.POST)
	public String saveContact(HttpServletRequest request, @ModelAttribute Contact ct) {
		// lấy dư liệu do view gửi sang
		ct.printALL();
		return "redirect:/contact/view";
	}

	@RequestMapping(value = "sf-edit", method = RequestMethod.GET)
	public String editViewSF(Model model) {
		Contact contact = new Contact("Bùi Minh Hiếu", "buiminhhieu12092003@gmail.com", "0386215712", "Mai dịch",
				"đồ ăn chưa chín ", "gsmkdlgsdigjw09jg");
		model.addAttribute("contact", contact);

		return "customer/pages_Contact";
	}

	@RequestMapping(value = "save-sf", method = RequestMethod.POST)
	public String saveContactSF(HttpServletRequest request, @ModelAttribute Contact ct,
			@RequestParam("contactFile") MultipartFile file, RedirectAttributes ra) throws IOException {
		// lấy dư liệu do view gửi sang
		ct.printALL();

		int saved = 0;
		if (file != null && !file.getOriginalFilename().isEmpty()) {
			File dir = new File(FOLDER_UPLOAD + "ContactFiles/");
			if (!dir.exists()) {
				dir.mkdir();
			}
		}

		String path = FOLDER_UPLOAD + "ContactFiles/" + file.getOriginalFilename();
		File fileDest = new File(path);
		file.transferTo(fileDest);
		saved = 1;

		ra.addFlashAttribute("toast", "Đã lưu liên hệ" + (saved > 0 ? (" và " + saved + " file.") : "."));
		ra.addFlashAttribute("toastType", "success");

		return "redirect:/contact/sf-edit";
	}

}
