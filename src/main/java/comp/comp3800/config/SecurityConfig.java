package comp.comp3800.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import static org.springframework.security.config.Customizer.withDefaults;

@Configuration
@EnableWebSecurity
public class SecurityConfig {
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http)
            throws Exception {
        http
                .authorizeHttpRequests(authorize -> authorize
                        //work from up to down so 'all user can read' is  at bottom
                        //just copy the link and paste for has role teacher
                        .requestMatchers("/admin/users/**").hasRole("TEACHER")

                        .requestMatchers("/lecture/create").hasRole("TEACHER")


                        .requestMatchers("/lecture/coursematerial/{id}/delete").hasRole("TEACHER")
                        .requestMatchers("/lecture/coursematerial/*/attachment/*/delete").hasRole("TEACHER")


                        .requestMatchers("/poll/admin/**").hasRole("TEACHER")

                        .requestMatchers("/poll/**").hasAnyRole("TEACHER","STUDENT")
                        .requestMatchers("/lecture/coursematerial/**").hasAnyRole("TEACHER","STUDENT")

                        .anyRequest().permitAll()
                )
                .formLogin(form -> form
                        .loginPage("/login")
                        .failureUrl("/login?error")
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/logout")
                        .logoutSuccessUrl("/login?logout")
                        .invalidateHttpSession(true)
                        .deleteCookies("JSESSIONID")
                )
                .rememberMe(remember -> remember
                        .key("uniqueAndSecret")
                        .tokenValiditySeconds(86400)
                )
                .httpBasic(withDefaults());
        return http.build();
    }

    @Bean
    public PasswordEncoder passwordEncoder() {
        return org.springframework.security.crypto.password.NoOpPasswordEncoder.getInstance();
    }
}