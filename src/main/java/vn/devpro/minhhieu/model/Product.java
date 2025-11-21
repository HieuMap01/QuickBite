package vn.devpro.minhhieu.model;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_product")
public class Product extends BaseModel {

	@Column(name = "name", length = 300, nullable = false)
	private String name;

	@Column(name = "avatar", length = 300, nullable = false)
	private String avatar;

	@Column(name = "price", nullable = true)
	private BigDecimal price = BigDecimal.ZERO;

	@Column(name = "sale_price", nullable = true)
	private BigDecimal salePrice = BigDecimal.ZERO;

	@Column(name = "short_description", length = 500, nullable = true)
	private String shortDescription;

	@Column(name = "detail_description", nullable = true)
	private String detailDescription;

	@Column(name = "is_hot", nullable = true)
	private Boolean isHot = Boolean.FALSE;

	@Column(name = "seo", length = 1000, nullable = true)
	private String seo;

	// Mapping many-to-one: tbl_product-to-tbl_category-category_id
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "category_id", referencedColumnName = "id")
	private Category category;

	// ---------Mapping one-to-many: tbl_product-to-tbl_product_image-----------
	// cascade = CascadeType.ALL: Mọi thao tác trên cha (Product) sẽ cascade xuống
	// con (ProductImage)
	// vd: lưu, sửa , xóa, cập nhật
	// mappedBy = "product" Chỉ ra bên sở hữu khóa ngoại là field product ở entity
	// Set<ProductImage Dùng Set để tránh trùng phần tử trong bộ nhớ.
	// Khởi tạo sẵn để tránh NPE khi thêm phần tử.
	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "product")
	private Set<ProductImage> productImage = new HashSet<ProductImage>();

	// khi them sản phẩm vào bảng sản phẩm thì tự động thêm ảnh...
	// Phương pháp thêm và xóa các phần tử trong danh sách sản phẩm quan hệ
	public void addRelationProductImage(ProductImage productImage) {
		if (productImage == null)
			return;
		this.productImage.add(productImage); // thêm vào collection bên Product
		productImage.setProduct(this); // // set 'product' ở bên ProductImage (bên sở hữu FK)
	}

	public void removeRelationProductImage(ProductImage productImage) {
		if (productImage == null)
			return;
		this.productImage.remove(productImage);
		productImage.setProduct(this);
	}

	// many-to-one: product-to-user-create
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "create_by", referencedColumnName = "id")
	private User userCreateProduct;

	// many-to-one: product-to-user-update
	@ManyToOne(fetch = FetchType.EAGER)
	@JoinColumn(name = "update_by", referencedColumnName = "id")
	private User userUpdateProduct;

	public Product() {
		super();
	}

	public Product(Integer id, Date createDate, Date updateDate, Boolean status, String name, String avatar,
			BigDecimal price, BigDecimal sale_price, String shortDescription, String detailDescription, Boolean isHot,
			String seo, Category category, Set<ProductImage> productImage, User userCreateProduct,
			User userUpdateProduct) {
		super(id, createDate, updateDate, status);
		this.name = name;
		this.avatar = avatar;
		this.price = price;
		this.salePrice = sale_price;
		this.shortDescription = shortDescription;
		this.detailDescription = detailDescription;
		this.isHot = isHot;
		this.seo = seo;
		this.category = category;
		this.productImage = productImage;
		this.userCreateProduct = userCreateProduct;
		this.userUpdateProduct = userUpdateProduct;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigDecimal getSalePrice() {
		return salePrice;
	}

	public void setSalePrice(BigDecimal sale_price) {
		this.salePrice = sale_price;
	}

	public String getShortDescription() {
		return shortDescription;
	}

	public void setShortDescription(String shortDescription) {
		this.shortDescription = shortDescription;
	}

	public String getDetailDescription() {
		return detailDescription;
	}

	public void setDetailDescription(String detailDescription) {
		this.detailDescription = detailDescription;
	}

	public Boolean getIsHot() {
		return isHot;
	}

	public void setIsHot(Boolean isHot) {
		this.isHot = isHot;
	}

	public String getSeo() {
		return seo;
	}

	public void setSeo(String seo) {
		this.seo = seo;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Set<ProductImage> getProductImage() {
		return productImage;
	}

	public void setProductImage(Set<ProductImage> productImage) {
		this.productImage = productImage;
	}

	public User getUserCreateProduct() {
		return userCreateProduct;
	}

	public void setUserCreateProduct(User userCreateProduct) {
		this.userCreateProduct = userCreateProduct;
	}

	public User getUserUpdateProduct() {
		return userUpdateProduct;
	}

	public void setUserUpdateProduct(User userUpdateProduct) {
		this.userUpdateProduct = userUpdateProduct;
	}

}
