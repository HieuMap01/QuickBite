package vn.devpro.minhhieu;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class quickbiteStarter {

    public static void main(String[] args) {
        
        SpringApplication Start = new SpringApplication(quickbiteStarter.class);
        Start.run(args);
    }
}
