package comp.comp3800.dao;

import comp.comp3800.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserService implements UserDetailsService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private PollVoteRepository pollVoteRepository;

    // ====================== 原本的 Security 方法 ======================
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("User not found: " + username));

        return org.springframework.security.core.userdetails.User
                .withUsername(user.getUsername())
                .password(user.getPassword())
                .roles(user.getRole().name())
                .build();
    }

    // ====================== 新增：安全的刪除方法 ======================
    @Transactional
    public void deleteUser(Long id) {
        // 1. 先刪除該 user 的所有 comments
        commentRepository.deleteByAuthorId(id);

        // 2. 再刪除該 user 的所有 poll votes
        pollVoteRepository.deleteByVoterId(id);

        // 3. 最後刪除 user
        userRepository.deleteById(id);
    }
}