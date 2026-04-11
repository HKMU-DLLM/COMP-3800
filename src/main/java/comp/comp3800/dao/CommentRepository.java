package comp.comp3800.dao;

import comp.comp3800.model.Comment;
import comp.comp3800.model.CommentHistoryItem;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {

    List<Comment> findByTargetType(Comment.TargetType targetType);
    void deleteByTargetTypeAndTargetId(Comment.TargetType targetType, Long targetId);
    List<Comment> findByTargetTypeAndTargetIdOrderByCreatedAtAsc(
            Comment.TargetType targetType, Long targetId);
    @Query("""
        SELECT new comp.comp3800.model.CommentHistoryItem(
            c.id,
            CASE WHEN c.targetType = 'LECTURE' THEN 'Lecture' ELSE 'Poll' END,
            c.targetId,
            CASE 
                WHEN c.targetType = 'LECTURE' THEN l.title 
                ELSE p.question 
            END,
            c.content,
            c.createdAt
        )
        FROM Comment c
        LEFT JOIN Lecture l ON c.targetType = 'LECTURE' AND c.targetId = l.id
        LEFT JOIN Poll p ON c.targetType = 'POLL' AND c.targetId = p.id
        WHERE c.author.id = :authorId
        ORDER BY c.createdAt DESC
    """)
    List<CommentHistoryItem> findCommentHistoryByAuthorId(@Param("authorId") Long authorId);
    void deleteByAuthorId(Long authorId);
}