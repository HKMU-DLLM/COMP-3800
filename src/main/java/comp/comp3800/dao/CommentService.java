package comp.comp3800.dao;

import comp.comp3800.model.Comment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {

    @Autowired
    private CommentRepository commentRepository;

    public List<Comment> getCommentsForLect(Long lectId) {
        return commentRepository.findByTargetIdAndTargetType(lectId, Comment.TargetType.LECTURE);
    }

    public List<Comment> getCommentsForPoll(Long pollId) {
        return commentRepository.findByTargetIdAndTargetType(pollId, Comment.TargetType.POLL);
    }
}
