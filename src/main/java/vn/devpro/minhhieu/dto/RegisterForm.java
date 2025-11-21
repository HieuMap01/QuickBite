// vn.devpro.minhhieu.dto.RegisterForm.java
package vn.devpro.minhhieu.dto;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

public class RegisterForm {
	@NotBlank
	@Size(min = 2, max = 120, message = "username must be between 2 and 120 characters")
	private String username;

	@NotBlank
	@Size(min = 2, max = 120, message = "password must be between 3 and 120 characters")
	private String password;

	@NotBlank
	@Email
	private String email;

	private String name;
	private String mobile;
	private String address;
	private String confirmPassword;

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

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

}
