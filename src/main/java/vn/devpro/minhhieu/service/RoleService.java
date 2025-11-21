package vn.devpro.minhhieu.service;

import java.util.List;

import javax.transaction.Transactional;

import org.springframework.stereotype.Service;

import vn.devpro.minhhieu.model.Role;

@Service
public class RoleService extends BaseService<Role> {

	@Override
	public Class<Role> clazz() {
		// TODO Auto-generated method stub
		return Role.class;
	}

	public List<Role> findAllActive() {
		String sql = "SELECT * FROM tbl_role WHERE status=1";
		return super.executeNativeSql(sql);
	}

	// Xử lý Inactive role (xóa mềm)
	@Transactional
	public void inactiveRole(Role role) {
		try {
			// Gọi hàm update chung từ BaseService
			super.saveOrUpdate(role);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
