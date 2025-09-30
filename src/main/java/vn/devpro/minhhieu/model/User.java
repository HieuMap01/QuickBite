// vn.devpro.minhhieu.model.User.java
package vn.devpro.minhhieu.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "tbl_user")
public class User extends BaseModel {

	@Column(name = "username", length = 120, nullable = false)
	private String username;

	@Column(name = "password", length = 120, nullable = false)
	private String password;

	@Column(name = "name", length = 300)
	private String name;

	@Column(name = "email", length = 200)
	private String email;

	@Column(name = "mobile", length = 60)
	private String mobile;

	@Column(name = "address", length = 300)
	private String address;

	@Column(name = "avatar", length = 300)
	private String avatar;

	@Column(name = "description", length = 500)
	private String description;

	@Column(name = "status")
	private Boolean status = true; // mặc định active

	public User() {
		super();
	}

	public User(String username, String password, String name, String email, String mobile, String address,
			String avatar, String description, Boolean status) {
		super();
		this.username = username;
		this.password = password;
		this.name = name;
		this.email = email;
		this.mobile = mobile;
		this.address = address;
		this.avatar = avatar;
		this.description = description;
		this.status = status;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getAvatar() {
		return avatar;
	}

	public void setAvatar(String avatar) {
		this.avatar = avatar;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Boolean getStatus() {
		return status;
	}

	public void setStatus(Boolean status) {
		this.status = status;
	}
}
