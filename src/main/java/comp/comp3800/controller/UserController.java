package comp.comp3800.controller;

import comp.comp3800.dao.UserRepository;
import comp.comp3800.model.User;
import jakarta.annotation.Resource;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class UserController {

    @Resource
    private UserRepository userRepo;

    // Form backing object
    public static class SignupForm {
        private String username;
        private String password;
        private String fullName;
        private String email;
        private String phone;
        private String role; // "STUDENT" or "TEACHER"

        // getters and setters
        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }

        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }

        public String getFullName() { return fullName; }
        public void setFullName(String fullName) { this.fullName = fullName; }

        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }

        public String getPhone() { return phone; }
        public void setPhone(String phone) { this.phone = phone; }

        public String getRole() { return role; }
        public void setRole(String role) { this.role = role; }
    }

    @GetMapping("/signup")
    public String showSignupForm(Model model) {
        model.addAttribute("userForm", new SignupForm());
        return "signup";  // /WEB-INF/jsp/signup.jsp
    }

    @PostMapping("/signup")
    public String handleSignup(@ModelAttribute("userForm") SignupForm form) {
        // Create User entity
        User user = new User();
        user.setUsername(form.getUsername());

        user.setPassword(form.getPassword()); // plain text for dev only

        user.setFullName(form.getFullName());
        user.setEmail(form.getEmail());
        user.setPhone(form.getPhone());
        user.setRole(User.Role.valueOf(form.getRole())); // STUDENT or TEACHER
        user.setEnabled(true);

        userRepo.save(user);

        // Redirect to login after successful signup
        return "redirect:/login";
    }
}