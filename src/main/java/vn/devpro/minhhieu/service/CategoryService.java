package vn.devpro.minhhieu.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.devpro.minhhieu.model.Category;

@Service
public class CategoryService extends BaseService<Category> {

	@Override
	public Class<Category> clazz() {
		// TODO Auto-generated method stub
		return Category.class;
	}

	// SELECT * FROM: lấy tất cả các cột từ bảng ...
	// WHERE name= : lọc những hàng có cột bằng với giá trị chuỗi
	public List<Category> findByName(String name) {
		String sql = "SELECT * FROM tbl_category WHERE name='" + name + "'";
		return super.executeNativeSql(sql);
	}

	public List<Category> findAllActive() {
		String sql = "SELECT * FROM tbl_category WHERE status=1";
		return super.executeNativeSql(sql);
	}

}
