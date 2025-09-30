package vn.devpro.minhhieu.service;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Table;

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
		return (List<Model>) entityManager.createNativeQuery("SELECT * FROM" + table.name(), clazz()).getResultList();
	}
}
