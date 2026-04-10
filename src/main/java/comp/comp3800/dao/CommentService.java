package comp.comp3800.dao;

import comp.comp3800.model.Comment;
import comp.comp3800.model.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.security.Principal;
import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private UserRepository userRepository;

    public List<Comment> getCommentsForLect() {
        return commentRepository.findByTargetType(Comment.TargetType.LECTURE);
    }

    public List<Comment> getCommentsForPoll() {
        return commentRepository.findByTargetType(Comment.TargetType.POLL);
    }


    @Transactional
    public Comment addCommentToLecture(Long lectureId, String content, Principal principal) {
        User author = userRepository.findByUsername(principal.getName())
                .orElseThrow(() -> new RuntimeException("User not found"));

        Comment comment = new Comment();
        comment.setAuthor(author);
        comment.setContent(content);
        comment.setTargetType(Comment.TargetType.LECTURE);
        comment.setTargetId(lectureId);

        return commentRepository.save(comment);
    }

    @Transactional
    public Comment addCommentToPoll(Long pollId, String content, Principal principal) {
        User author = userRepository.findByUsername(principal.getName())
                .orElseThrow(() -> new RuntimeException("User not found"));

        Comment comment = new Comment();
        comment.setAuthor(author);
        comment.setContent(content);
        comment.setTargetType(Comment.TargetType.POLL);
        comment.setTargetId(pollId);

        return commentRepository.save(comment);
    }

    public List<Comment> getCommentsForLecture(Long lectureId) {
        return commentRepository.findByTargetTypeAndTargetIdOrderByCreatedAtAsc(
                Comment.TargetType.LECTURE, lectureId);
    }

    public List<Comment> getCommentsForPoll(Long pollId) {
        return commentRepository.findByTargetTypeAndTargetIdOrderByCreatedAtAsc(
                Comment.TargetType.POLL, pollId);
    }

    @Transactional
    public void deleteComment(Long commentId) {
        commentRepository.deleteById(commentId);
    }
}