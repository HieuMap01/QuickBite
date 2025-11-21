package vn.devpro.minhhieu.dto;

import java.math.BigDecimal;
import java.math.BigInteger;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

public class Cart {

	private List<CartProduct> cartProducts = new ArrayList<CartProduct>();

	public Cart() {
		super();
	}

	public Cart(List<CartProduct> cartProducts) {
		super();
		this.cartProducts = cartProducts;
	}

	public List<CartProduct> getCartProducts() {
		return cartProducts;
	}

	public void setCartProducts(List<CartProduct> cartProducts) {
		this.cartProducts = cartProducts;
	}

	// tìm vị trí item theo id -> +/- nhanh giỏ hàng
	public int findById(int id) {
		for (int i = 0; i < cartProducts.size(); i++) {
			if (cartProducts.get(i).getId() == id)
				return i;
		}
		return -1;
	}

	// xóa 1 dòng khỏi giỏ hàng
	public void removeById(int id) {
		for (Iterator<CartProduct> it = cartProducts.iterator(); it.hasNext();) {
			if (it.next().getId() == id) {
				it.remove();
				break;
			}
		}
	}

	// cộng tất cả giá sản phẩm
	public BigDecimal totalCartPrice() {
		BigDecimal total = BigDecimal.ZERO;
		for (CartProduct p : cartProducts) {
			total = total.add(p.totalPrice());
		}
		return total;
	}

	// cộng tất cả số lượng sản phẩm
	public BigInteger totalQuantity() {
		BigInteger q = BigInteger.ZERO;
		for (CartProduct p : cartProducts) {
			q = q.add(p.getQuantity());
		}
		return q;
	}

	public void clear() {
		cartProducts.clear();
	}

}
