// vn.devpro.minhhieu.service.impl.UserServiceImpl.java
package vn.devpro.minhhieu.service.impl;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import vn.devpro.minhhieu.model.User;
import vn.devpro.minhhieu.repository.UserRepository;
import vn.devpro.minhhieu.service.BaseService;
import vn.devpro.minhhieu.service.UserService;

@Service
@Transactional
public class UserServiceImpl extends BaseService<User> implements UserService {

	@Override
	public Class<User> clazz() {
		// TODO Auto-generated method stub
		return User.class;
	}

	private final UserRepository userRepository;

	@PersistenceContext
	private EntityManager entityManager;

	@Autowired
	public UserServiceImpl(UserRepository userRepository) {
		this.userRepository = userRepository;
	}

	@Override
	public boolean existsByUsername(String username) {
		return userRepository.existsByUsername(username);
	}

	@Override
	public boolean existsByEmail(String email) {
		return userRepository.existsByEmail(email);
	}

	@Override
	public User save(User user) {
		return userRepository.save(user);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> findAllActive() {
		// Lấy danh sách tất cả user còn đang active trong hệ thống
		String sql = "SELECT * FROM tbl_user WHERE status = 1";
		return entityManager.createNativeQuery(sql, User.class).getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<User> findAdminUsers() {
		// Lấy danh sách tất cả user có quyền ADMIN.
		String sql = "SELECT * FROM tbl_user u, tbl_user_role ur, "
				+ "tbl_role r WHERE u.id=ur.user_id AND ur.role_id = r.id AND r.name='ADMIN'";
		return entityManager.createNativeQuery(sql, User.class).getResultList();
	}

	@Override
	public List<User> findAll() {
		return userRepository.findAll();
	}

	@Override
	public User getById(int id) {
		// TODO Auto-generated method stub
		return super.getById(id);
	}

}
