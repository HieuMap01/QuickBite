package vn.devpro.minhhieu.service;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import vn.devpro.minhhieu.model.User;

@Service
public class UserDetailsServiceImpl extends BaseService<User> implements UserDetailsService {

	@Override
	public Class<User> clazz() {
		// TODO Auto-generated method stub
		return User.class;
	}

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		// TODO Auto-generated method stub
		// lay user trong tbl_user theo username (username tuwf form login)
		String sql = "SELECT * FROM tbl_user u WHERE u.username='" + username + "' AND u.status=1";
		User user = this.getEntityByNativeSQL(sql);
		if (user != null) {
//			System.out.println("user name" + user.getUsername());
//			System.out.println("password" + user.getPassword());
			return user;
		} else {
			return new User(); // UserDetails khong duoc null
		}
	}

}
