package vn.devpro.minhhieu.model;

public class Contact {
	private String fullname;
	private String email;
	private String phone;
	private String address;
	private String subject;
	private String message;
	
	
	public Contact() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Contact(String fullname, String email, String phone, String address, String subject, String message) {
		super();
		this.fullname = fullname;
		this.email = email;
		this.phone = phone;
		this.address = address;
		this.subject = subject;
		this.message = message;
	}
	public void printALL() {
		System.out.println("Họ và Tên: " + fullname);
		System.out.println("Email: " + email);
		System.out.println("Phone: " + phone);
		System.out.println("Address: " + address);
		System.out.println("Subject: " + subject);
		System.out.println("Message: " + message);
	}

	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getFullname() {
		return fullname;
	}
	public void setFullname(String fullname) {
		this.fullname = fullname;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}
	
	
}
