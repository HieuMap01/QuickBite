package vn.devpro.minhhieu.dto;

import java.math.BigDecimal;
import java.math.BigInteger;

public class CartProduct {
	private int id;
	private String name;
	private BigDecimal price;
	private BigInteger quantity;
	private String avatar;

	// tổng giá thành các sản phẩm
	public BigDecimal totalPrice() {
		return this.price.multiply(new BigDecimal(this.quantity));
	}

	public void updateQuantity(BigInteger additionalQuatity) {
		if (additionalQuatity == null)
			return;
		this.quantity = this.quantity.add(additionalQuatity);
		if (this.quantity.compareTo(BigInteger.ONE) < 0) {
			this.quantity = BigInteger.ONE; // không cho < 1 (nếu muốn về 0 để xóa thì xử lý ở controller)
		}
	}

	public CartProduct() {
		super();
	}

	public CartProduct(Integer id, String name, BigDecimal price, BigInteger quantity, String avatar) {
		super();
		this.id = id;
		this.name = name;
		this.price = price;
		this.quantity = quantity;
		this.avatar = avatar;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public BigInteger getQuantity() {
		return quantity;
	}

	public void setQuantity(BigInteger quantity) {
		this.quantity = quantity;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

}
