package vn.devpro.minhhieu.controller.administrator;

import static vn.devpro.minhhieu.dto.QbContanst.FOLDER_UPLOAD;
import static vn.devpro.minhhieu.dto.QbContanst.ITEMS_ON_PAGE;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import vn.devpro.minhhieu.controller.BaseController;
import vn.devpro.minhhieu.dto.ProductSearch;
import vn.devpro.minhhieu.model.Category;
import vn.devpro.minhhieu.model.Product;
import vn.devpro.minhhieu.model.ProductImage;
import vn.devpro.minhhieu.model.User;
import vn.devpro.minhhieu.service.CategoryService;
import vn.devpro.minhhieu.service.ProductService;
import vn.devpro.minhhieu.service.UserService;

@Controller
@RequestMapping("/admin/product/")
public class ProductAdminController extends BaseController {

	@Autowired
	CategoryService cs;

	@Autowired
	UserService us;

	@Autowired
	ProductService ps;

	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String view(final Model model, final HttpServletRequest request) {
		ProductSearch productSearch = new ProductSearch();

		// Nhận các tham số tìm kiếm từ URL (status, categoryId, keyword, beginDate,
		// endDate, currentPage, totalItems).

		// xử lý các thông tin liên quan đến tìm kiếm
		productSearch.setStatus(2); // all
		String str = request.getParameter("status");
		if (str != null && !StringUtils.isEmpty(str)) {
			productSearch.setStatus(Integer.parseInt(str));
		}

		productSearch.setCategoryId(0);// all category
		str = request.getParameter("categoryId");
		if (str != null && !StringUtils.isEmpty(str)) {
			productSearch.setCategoryId(Integer.parseInt(str));
		}

		productSearch.setKeyword(null);
		str = request.getParameter("keyword");
		if (str != null && !StringUtils.isEmpty(str)) {
			productSearch.setKeyword(str);
		}

		productSearch.setBeginDate(null);
		productSearch.setEndDate(null);

		String beginDate = request.getParameter("beginDate");
		String endDate = request.getParameter("endDate");
		if (beginDate != null && !StringUtils.isEmpty(beginDate) && endDate != null && !StringUtils.isEmpty(endDate)) {
			productSearch.setBeginDate(beginDate);
			productSearch.setEndDate(endDate);
		}

		// tất cả sản phẩm tìm kiếm được
		List<Product> allProductSearch = ps.search(productSearch);

		// tinhs toans phan trang
		productSearch.setCurrentPage(1);// khởi động mặc định ở trang 1

		// lấy trang hiện tại
		str = request.getParameter("currentPage");
		if (str != null && !StringUtils.isEmpty(str)) {
			productSearch.setCurrentPage(Integer.parseInt(str));
		}

		// nếu bấm nút search thì phải reset trang hiện tại về 1
		str = request.getParameter("totalItems");
		if (str != null && !StringUtils.isEmpty(str)) {
			int oldTotalItems = Integer.parseInt(str);
			if (allProductSearch.size() != oldTotalItems) {
				productSearch.setCurrentPage(1);
			}
		}
		// số sản phẩm trong 1 trang
		productSearch.setItemsOnPage(ITEMS_ON_PAGE);

		// tổng số sản phẩm
		productSearch.setTotalItems(allProductSearch.size());
		// tổng số trang
		int totalPages = allProductSearch.size() / ITEMS_ON_PAGE;
		if (allProductSearch.size() % ITEMS_ON_PAGE != 0) {
			totalPages++;
		}
		productSearch.setTotalPages(totalPages);
		// lấy danh sách của trang hiện tại (cần hiển thị)
		List<Product> products = new ArrayList<Product>();
		int firstIndex = (productSearch.getCurrentPage() - 1) * ITEMS_ON_PAGE;
		int lastIndex = firstIndex + ITEMS_ON_PAGE;
		if (lastIndex > allProductSearch.size()) {
			lastIndex = allProductSearch.size();
		}

		products = allProductSearch.subList(firstIndex, lastIndex);

		model.addAttribute("products", products);
		model.addAttribute("productSearch", productSearch);

		List<Category> categories = cs.findAllActive();
		model.addAttribute("categories", categories);

		return "administrator/product/product-list";
	}

	@RequestMapping(value = "add", method = RequestMethod.GET)
	public String add(final Model model) {
		Product p = new Product();
		List<Category> c = cs.findAllActive();
		List<User> u = us.findAllActive();

		p.setCreateDate(new Date());
		model.addAllAttributes(Map.of("product", p, "categories", c, "users", u));

		return "administrator/product/product-add";
	}

	// kiểm tra danh ách file avatar
	// MultipartFile là kiểu dữ liệu của Spring MVC dùng để nhận file tải lên từ
	// form HTML
	public boolean isUploadFile(MultipartFile avatar) {
		if (avatar != null && !StringUtils.isEmpty(avatar.getOriginalFilename())) {
			// avatar.getOriginalFilename() Lấy tên gốc của file do người dùng tải lên
			return true;
		}
		return false;
	}

	// kiểm tra danh sách file ảnh
	public boolean isUploadImg(MultipartFile[] img) {
		if (img != null && img.length > 0) {
			return true;
		}
		return false;
	}

	@RequestMapping(value = "add-save", method = RequestMethod.POST)
	public String save(final Model model, @ModelAttribute("product") Product product,
			@RequestParam("avatarFile") MultipartFile avatarFile,
			@RequestParam("imageFiles") MultipartFile[] imageFiles) throws IOException {
		// xử lý file avatar
		if (isUploadFile(avatarFile)) {
			// lưu file vào thư mục
			String path = FOLDER_UPLOAD + "Product/Avatar/" + avatarFile.getOriginalFilename();

			File file = new File(path);
			avatarFile.transferTo(file);

			// lưu đường dẫn vào db
			product.setAvatar("Product/Avatar/" + avatarFile.getOriginalFilename());
		}

		// xử lý danh sách ảnh
		if (isUploadImg(imageFiles)) {
			for (MultipartFile img : imageFiles) {
				if (isUploadFile(img)) {
					String path = FOLDER_UPLOAD + "Product/img/" + img.getOriginalFilename();

					File file = new File(path);

					img.transferTo(file);

					ProductImage pImg = new ProductImage();
					pImg.setCreateDate(new Date());
					pImg.setPath("Product/img/" + img.getOriginalFilename());
					pImg.setStatus(true);
					pImg.setTitle(img.getOriginalFilename());

					pImg.setProduct(product);
					product.addRelationProductImage(pImg);

				}
			}

		}
		ps.saveOrUpdate(product);
		return "redirect:/admin/product/add";
	}

	@RequestMapping(value = "edit/{productId}", method = RequestMethod.GET)
	public String edit(final Model model, @PathVariable("productId") int productId) {

		Product p = ps.getById(productId);
		List<Category> c = cs.findAllActive();
		List<User> u = us.findAllActive();

		p.setCreateDate(new Date());
		model.addAllAttributes(Map.of("product", p, "categories", c, "users", u));

		return "administrator/product/product-edit";
	}

	@RequestMapping(value = "edit-save", method = RequestMethod.POST)
	public String update(final Model model, @ModelAttribute("product") Product product,
			@RequestParam("avatarFile") MultipartFile avatarFile,
			@RequestParam("imageFiles") MultipartFile[] imageFiles) throws IOException {

		Product dbProduct = ps.getById(product.getId());

		// xử lý file avatar
		if (isUploadFile(avatarFile)) {
			// xóa avatar cũ nếu có
			if (product.getAvatar() != null && !StringUtils.isEmpty(product.getAvatar())) {
				String path = FOLDER_UPLOAD + product.getAvatar();
				File file = new File(path);
				file.delete();
			}
			// lưu file avatar mới
			String path = FOLDER_UPLOAD + "Product/Avatar/" + avatarFile.getOriginalFilename();

			File file = new File(path);
			avatarFile.transferTo(file);

			// lưu đường dẫn vào db
			product.setAvatar("Product/Avatar/" + avatarFile.getOriginalFilename());
		} else {
			product.setAvatar(dbProduct.getAvatar());
		}

		// xử lý danh sách ảnh
		if (isUploadImg(imageFiles)) {
			for (MultipartFile img : imageFiles) {
				if (isUploadFile(img)) {
					String path = FOLDER_UPLOAD + "Product/img/" + img.getOriginalFilename();

					File file = new File(path);

					img.transferTo(file);

					ProductImage pImg = new ProductImage();
					pImg.setCreateDate(new Date());
					pImg.setPath("Product/img/" + img.getOriginalFilename());
					pImg.setStatus(true);
					pImg.setTitle(img.getOriginalFilename());

					pImg.setProduct(product);
					product.addRelationProductImage(pImg);

				}
			}

		}
		ps.saveOrUpdate(product);
		return "redirect:/admin/product/list";
	}

	@RequestMapping(value = "delete/{productId}", method = RequestMethod.GET)
	public String deleteEdit(@PathVariable("productId") int productId) {
		// ẩn dữ liệu đi chứ ko phải xóa hoàn toàn vì liên quan đến cơ sở dữ liệu

		Product product = ps.getById(productId);
		product.setStatus(false);

		ps.saveOrUpdate(product);

		return "redirect:/admin/product/list";
	}

}