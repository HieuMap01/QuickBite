// vn.devpro.minhhieu.repository.UserRepository.java
package vn.devpro.minhhieu.repository;

import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.devpro.minhhieu.model.User;

@Repository
public interface UserRepository extends JpaRepository<User, Integer> {
	boolean existsByUsername(String username);

	boolean existsByEmail(String email);

	Optional<User> findByUsername(String username); // thêm dòng này
}
