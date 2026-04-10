package comp.comp3800.dao;

import comp.comp3800.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {

    List<Comment> findByTargetType(Comment.TargetType targetType);

    List<Comment> findByTargetTypeAndTargetIdOrderByCreatedAtAsc(
            Comment.TargetType targetType, Long targetId);
}