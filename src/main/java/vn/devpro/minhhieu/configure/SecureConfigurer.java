package vn.devpro.minhhieu.configure;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;

@Configuration
@EnableWebSecurity
public class SecureConfigurer extends WebSecurityConfigurerAdapter {
	// method định nghĩa luật bảo mật cho ứng dụng
	@Bean
	public org.springframework.security.crypto.password.PasswordEncoder passwordEncoder() {
		// độ mạnh 10 là mặc định, bạn có thể giữ 4 nếu muốn khớp với cấu hình cũ
		return new org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder(4);
	}

	@Override
	protected void configure(final HttpSecurity http) throws Exception {
		// bắt đầu cấu hình phân quyền cho các request
		http.csrf().disable().authorizeRequests()// batws cacs request tu browser

				// cho phep cac request, paths khong bij rangf buoc login
				.antMatchers("/administrator/**", "/customer/**", "/UploadFiles/**", "/login", "/logout", "/register",
						"/register/**")
				.permitAll()

				// Vùng tài khoản: BẮT BUỘC đăng nhập (fix principal null)
				.antMatchers("/account/**").authenticated()

				// cac request kieu admin phai login xac thuc
				// .antMatchers("/admin/**").authenticated()
				.antMatchers("/admin/**").hasAnyAuthority("ADMIN").and()

				// Direct den URL duoc request truoc khi login
				.requestCache().requestCache(new HttpSessionRequestCache())

				.and()

				// neues chua login (xacs thuwc) thi phai redirect den trang login
				.formLogin().loginPage("/login").loginProcessingUrl("/login_processing_url")

				// .defaultSuccessUrl("/admin/home", true) // login thành công vào trang home
				// admin

				.successHandler(new UrlAuthenticationSuccessHandler())
				// login không thanhf cong
				.failureUrl("/login?login_error=true")

				.and()

				// Cau hinh phan logout
				.logout().logoutUrl("/logout").logoutSuccessUrl("/index").invalidateHttpSession(true)
				.deleteCookies("JSESSIONID")

				.and().rememberMe().key("uniqueAndSecret").tokenValiditySeconds(86400);

	}

	@Autowired
	private vn.devpro.minhhieu.service.UserDetailsServiceImpl userDetailsService;

	@Autowired // Cach xac thuc bao mat voi user load tu DB
	public void configureGlobal(AuthenticationManagerBuilder auth) throws Exception {
		auth.userDetailsService(userDetailsService).passwordEncoder(new BCryptPasswordEncoder(4));
	}

	public static void main(String[] args) {
		System.out.println(new BCryptPasswordEncoder(4).encode("123"));
	}
}
