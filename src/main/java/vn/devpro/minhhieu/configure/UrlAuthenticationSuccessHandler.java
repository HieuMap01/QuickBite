package vn.devpro.minhhieu.configure;

import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.WebAttributes;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

public class UrlAuthenticationSuccessHandler implements AuthenticationSuccessHandler {

	// Điều hướng den request
	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();

	@Override // Chuyển đến request thich hop voi role khi xac thuc thanh cong
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		handle(request, response, authentication); // Xac dinh URL dich
		clearAuthenticationAttributes(request); // Xoa thong tin loi login cu
	}

	// Dua vao role cua user login de xac dinh request chuyen den (redirect)
	protected void handle(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException {
		RequestCache requestCache = new HttpSessionRequestCache();
		String targetUrl = null;
		if (response.isCommitted()) {
			return;
		}

		SavedRequest savedRequest = requestCache.getRequest(request, response);
//			System.out.println("targetUrl: " + targetUrl);

		if (savedRequest != null) {
			targetUrl = savedRequest.getRedirectUrl();
		} else {
			targetUrl = determineTargetUrl(authentication); // Lay URL phu hop voi role
		}
		clearAuthenticationAttributes(request);
		redirectStrategy.sendRedirect(request, response, targetUrl); // điều hướng target URL
	}

	// Lay role cua user va tra ve Url (action) tuong ung voi authentication
	protected String determineTargetUrl(final Authentication authentication) throws IllegalStateException {

		Map<String, String> roleTargetUrlMap = new HashMap<String, String>();
		// key: Role - value: URL
		// Key la role name, value la Url (action)
		roleTargetUrlMap.put("ADMIN", "/admin/home");
//			roleTargetUrlMap.put("STAFF", "/staff/list-product");
		roleTargetUrlMap.put("CUSTOMER", "/index");

		// Lay danh sach cac roles
		final Collection<? extends GrantedAuthority> authorities = authentication.getAuthorities();

		// authorities lay Trong class User
		for (final GrantedAuthority grantedAuthority : authorities) {
			String authorityName = grantedAuthority.getAuthority(); // role name

			if (roleTargetUrlMap.containsKey(authorityName)) {
//						System.out.println("authorityName: " + authorityName);
//						System.out.println("role url map: " + roleTargetUrlMap.get(authorityName).toString());

				// Trả về target url của user đăng nhập
				return roleTargetUrlMap.get(authorityName);
			}
		}
		throw new IllegalStateException();
	}

	protected void clearAuthenticationAttributes(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		if (session == null) {
			return;
		}
		session.removeAttribute(WebAttributes.AUTHENTICATION_EXCEPTION);
	}
}
