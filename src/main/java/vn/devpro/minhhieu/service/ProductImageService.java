package vn.devpro.minhhieu.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.devpro.minhhieu.model.ProductImage;

@Service
public class ProductImageService extends BaseService<ProductImage> {

	@Override
	public Class<ProductImage> clazz() {
		// TODO Auto-generated method stub
		return ProductImage.class;
	}

	public List<ProductImage> findByProductId(int productId) {
		String sql = "SELECT * FROM tbl_product_image WHERE product_id = " + productId + " ORDER BY id ASC";
		return (List<ProductImage>) this.executeNativeSql(sql);

	}

}
