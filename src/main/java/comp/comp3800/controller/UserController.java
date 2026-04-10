package comp.comp3800.controller;

import comp.comp3800.dao.UserRepository;
import comp.comp3800.model.User;
import jakarta.annotation.Resource;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.server.ResponseStatusException;

import java.security.Principal;

@Controller
public class UserController {

    @Resource
    private UserRepository userRepo;

    // ===== Signup backing object =====
    public static class SignupForm {
        private String username;
        private String password;
        private String fullName;
        private String email;
        private String phone;
        private String role; // "STUDENT" or "TEACHER"

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
        return "signup";
    }

    @PostMapping("/signup")
    public String handleSignup(@ModelAttribute("userForm") SignupForm form) {
        User user = new User();
        user.setUsername(form.getUsername());
        user.setPassword(form.getPassword()); // encode in real app
        user.setFullName(form.getFullName());
        user.setEmail(form.getEmail());
        user.setPhone(form.getPhone());
        user.setRole(User.Role.valueOf(form.getRole()));
        user.setEnabled(true);

        userRepo.save(user);
        return "redirect:/login";
    }


    // ===== Profile form backing object =====
    public static class ProfileForm {
        private Long id;
        private String username;
        private String password;
        private String fullName;
        private String email;
        private String phone;
        private String role;   // "STUDENT" or "TEACHER"

        public Long getId() { return id; }
        public void setId(Long id) { this.id = id; }

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

    // 1) View user info (no form)
    @GetMapping("/userinfo")
    public String showProfile(Model model, Principal principal) {
        if (principal == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
        }

        String username = principal.getName();
        User user = userRepo.findByUsername(username)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        model.addAttribute("user", user);
        return "userinfo";  // /WEB-INF/jsp/userinfo.jsp
    }

    // 1) Show edit form
    @GetMapping("/userinfo/edituser")
    public String showEditForm(Model model, Principal principal) {
        if (principal == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
        }

        String username = principal.getName();
        User user = userRepo.findByUsername(username)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        model.addAttribute("user", user);
        return "edituser";
    }

    @PostMapping("/userinfo/edituser")
    public String updateUserInfo(@RequestParam String username,
                                 @RequestParam(required = false) String password,
                                 @RequestParam String fullName,
                                 @RequestParam String email,
                                 @RequestParam String phone,
                                 @RequestParam String role,
                                 Principal principal) {

        if (principal == null) {
            throw new ResponseStatusException(HttpStatus.UNAUTHORIZED);
        }

        String currentUsername = principal.getName();
        User user = userRepo.findByUsername(currentUsername)
                .orElseThrow(() -> new ResponseStatusException(HttpStatus.NOT_FOUND));

        user.setUsername(username);
        user.setFullName(fullName);
        user.setEmail(email);
        user.setPhone(phone);
        user.setRole(User.Role.valueOf(role));

        if (password != null && !password.isBlank()) {
            user.setPassword(password);
        }

        userRepo.save(user);

        return "redirect:/userinfo";
    }
}




