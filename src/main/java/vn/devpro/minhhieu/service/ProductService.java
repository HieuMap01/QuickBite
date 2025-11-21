package vn.devpro.minhhieu.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.devpro.minhhieu.dto.ProductSearch;
import vn.devpro.minhhieu.model.Product;

@Service
public class ProductService extends BaseService<Product> {

	@Override
	public Class<Product> clazz() {
		// TODO Auto-generated method stub
		return Product.class;
	}

	public List<Product> findAllActive() {
		String sql = "SELECT * FROM tbl_product WHERE status=1";
		return executeNativeSql(sql);
	}

	public List<Product> findAllActiveByCategoryId(int categoryId) {
		String sql = "SELECT * FROM tbl_product WHERE status=1 AND category_id = " + categoryId;
		return executeNativeSql(sql);
	}

	public List<Product> search(ProductSearch ps) {
		String sql = "SELECT * FROM tbl_product p WHERE 1=1";
		// all = 2, active = 1, inactive = 0

		if (ps.getStatus() != 2) {
			sql += " AND p.status=" + ps.getStatus();
		}
		if (ps.getCategoryId() != 0) {
			sql += " AND p.category_id=" + ps.getCategoryId();
		}

		String keyword;
		if (ps.getKeyword() != null) {
			keyword = ps.getKeyword();
			sql += " AND (LOWER(p.name) like '%" + keyword + "%'" + " OR LOWER(p.short_description) like '%" + keyword
					+ "%')";
		}

		String beginDate = ps.getBeginDate();
		String endDate = ps.getEndDate();

		if (beginDate != null && endDate != null) {
			sql += " AND p.create_date BETWEEN '" + beginDate + "'AND" + endDate + "'";
		}
		return executeNativeSql(sql);
	}

}
