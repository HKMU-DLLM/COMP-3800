package comp.comp3800.model;

import java.time.Instant;

public record CommentHistoryItem(
        Long commentId,
        String targetType,
        Long targetId,
        String targetTitle,
        String content,
        Instant createdAt
) {}