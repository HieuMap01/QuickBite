package vn.devpro.minhhieu.service;

import java.util.List;

import vn.devpro.minhhieu.model.User;

public interface UserService {
	boolean existsByUsername(String username);

	boolean existsByEmail(String email);

	User save(User user);

	List<User> findAllActive();

	List<User> findAdminUsers();
}
