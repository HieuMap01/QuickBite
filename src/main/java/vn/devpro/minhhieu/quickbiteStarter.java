package vn.devpro.minhhieu;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.PropertySource;

@SpringBootApplication
@PropertySource("classpath:application-secret.properties") // nạp thêm (import) một file cấu hình .properties từ
															// classpath vào Environment (môi trường cấu hình của ứng
															// dụng).
public class quickbiteStarter {

	public static void main(String[] args) {

		SpringApplication Start = new SpringApplication(quickbiteStarter.class);
		Start.run(args);
	}
}
