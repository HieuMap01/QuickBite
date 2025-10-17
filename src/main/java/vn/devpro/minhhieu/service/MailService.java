package vn.devpro.minhhieu.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

@Service
public class MailService {
	private final JavaMailSender mailSender;

	@Value("${spring.mail.username}")
	private String from;

	@Value("${app.mail.admin}")
	private String adminEmail;

	public MailService(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}

	// DEBUG helper
	public JavaMailSender getSenderForDebug() {
		return mailSender;
	}

	public void notifyAdminNewUser(String username, String email, String name, String mobile, String address) {
		SimpleMailMessage msg = new SimpleMailMessage();
		msg.setFrom(from); // phải là chính spring.mail.username
		msg.setTo(adminEmail); // mail của bạn
		msg.setSubject("[Quickbite] New user: " + username);
		msg.setText("Username: " + username + "\nEmail: " + email + "\nName: " + name + "\nMobile: " + mobile
				+ "\nAddress: " + address);
		mailSender.send(msg);
		System.out.println("Mail sent to admin: " + adminEmail);
	}

	public void sendWelcomeToUser(String toEmail, String username) {
		SimpleMailMessage msg = new SimpleMailMessage();
		msg.setFrom(from);
		msg.setTo(toEmail);
		msg.setSubject("Welcome to Quickbite");
		msg.setText("Xin chào " + username + ", tài khoản của bạn đã được tạo.");
		mailSender.send(msg);
		System.out.println("Welcome mail sent to: " + toEmail);
	}
}
