package vn.devpro.minhhieu.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Table;
import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import vn.devpro.minhhieu.model.BaseModel;

@Service
public abstract class BaseService<Model extends BaseModel> {

	@PersistenceContext
	EntityManager entityManager;

	public abstract Class<Model> clazz();

	// lấy một bản ghi theo id
	public Model getById(int id) {
		return entityManager.find(clazz(), id);
	}

	// lấy tất cả bản ghi trong 1 bảng
	@SuppressWarnings("unchecked") // chỉ để tránh cảnh báo ép kiểu.
	public List<Model> fillAll() {
		Table table = clazz().getAnnotation(Table.class);
		// chạy native SQL -> query toàn bộ dữ liệu trong bảng -> clazz() → chỉ định
		// kiểu entity để Hibernate map kết quả SQL thành object Java.
		return (List<Model>) entityManager.createNativeQuery("SELECT * FROM" + table.name(), clazz()).getResultList();
	}

	// thêm mới hoặc sửa bản ghi
	@Transactional // Giúp dữ liệu an toàn, tránh tình trạng insert nửa chừng mà bị lỗi
	public Model saveOrUpdate(Model entity) {
		if (entity.getId() == null || entity.getId() <= 0) {
			entityManager.persist(entity); // thêm mới (INSERT) một entity vào DB.
			return entity;
		} else {
			return entityManager.merge(entity);// update entity`
		}
	}

	// xóa 1 bản ghi theo entity
	@Transactional
	public void delete(Model entity) {
		entityManager.remove(entity);
	}

	// xóa bản ghi theo id
	@Transactional
	public void deleteById(int id) {
		Model entity = this.getById(id);
		delete(entity);
	}

	// Giúp chạy bất kỳ câu SQL gốc nào từ trong Service. Tái sử dụng được cho mọi
	// entity
	@SuppressWarnings("unchecked")
	public List<Model> executeNativeSql(String sql) {
		try {
			// tạo query SQL gốc -> kết quả được map thành List<Model>.
			javax.persistence.Query query = entityManager.createNativeQuery(sql, clazz());
			return query.getResultList(); // Lấy toàn bộ kết quả dưới dạng List<Model>.

		} catch (Exception e) {
			// TODO: handle exception
			return null;
		}
	}

}
