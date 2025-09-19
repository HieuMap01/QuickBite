package vn.devpro.minhhieu.configure;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import static vn.devpro.minhhieu.dto.QbContanst.FOLDER_UPLOAD;

@Configuration
public class MvcConfigure implements WebMvcConfigurer{


	@Bean
    public ViewResolver viewResolver(){
        InternalResourceViewResolver bean = new InternalResourceViewResolver();
        bean.setViewClass(JstlView.class);
        bean.setPrefix("/WEB-INF/views/");
        bean.setSuffix(".jsp");
        return bean;
    }

    public void addResourceHandlers(org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/customer/**").addResourceLocations("classpath:/customer/");
        registry.addResourceHandler("/administrator/**").addResourceLocations("classpath:/administrator/");
		registry.addResourceHandler("/UploadFiles/**").addResourceLocations("file:" + FOLDER_UPLOAD );
        
    }
}
