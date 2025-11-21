package vn.devpro.minhhieu.service;

import java.util.List;

import org.springframework.stereotype.Service;

import vn.devpro.minhhieu.model.SaleOrder;

@Service
public class SaleOrderService extends BaseService<SaleOrder> {
	@Override
	public Class<SaleOrder> clazz() {
		// TODO Auto-generated method stub
		return SaleOrder.class;
	}

	// (Giữ lại nếu muốn dùng theo username, thêm LOWER để tránh phân biệt
	// hoa/thường)
	@SuppressWarnings("unchecked")
	public List<SaleOrder> findAllByUsername(String username) {
		String jpql = "SELECT o FROM SaleOrder o " + "WHERE LOWER(o.user.username) = LOWER(:uname) "
				+ "ORDER BY o.id DESC";
		return entityManager.createQuery(jpql).setParameter("uname", username).getResultList();
	}

	// ✅ Dùng userId (an toàn, khớp DB chắc chắn)
	@SuppressWarnings("unchecked")
	public List<SaleOrder> findAllByUserId(Integer userId) {
		String jpql = "SELECT o FROM SaleOrder o WHERE o.user.id = :uid ORDER BY o.id DESC";
		return entityManager.createQuery(jpql).setParameter("uid", userId).getResultList();
	}

	// Lấy chi tiết đơn + items
	public SaleOrder findOrderWithItems(Integer id) {
		try {
			String jpql = "SELECT DISTINCT o FROM SaleOrder o " + "LEFT JOIN FETCH o.items i "
					+ "LEFT JOIN FETCH i.product " + "WHERE o.id = :oid";
			return entityManager.createQuery(jpql, SaleOrder.class).setParameter("oid", id).getSingleResult();
		} catch (Exception e) {
			return null;
		}
	}

}
